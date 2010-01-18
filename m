From: "Andrew Kohlsmith (Mailing List Account)" <aklists@mixdown.ca>
Subject: issue with sound stopping and not being able to restart
Date: Mon, 18 Jan 2010 10:04:52 -0500
Message-ID: <201001181004.55594.aklists@mixdown.ca>
Reply-To: akohlsmith-lists@mixdown.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gromit.mixdown.ca (gromit.mixdown.ca [208.68.91.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C546103821
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 16:05:01 +0100 (CET)
Received: from aklaptop.localnet (localhost.localdomain [127.0.0.1])
	by gromit.mixdown.ca (Postfix) with ESMTP id 149FEE130017
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 10:03:25 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Good morning,

I am new to ALSA development, but experienced in C. I wrote up a little test 
application which simply opens one playback and one capture device and spits 
noise into the playback and recording it on the capture device.  I cross-
correlate the data streams to determine the "depth" or latency of the pipe, 
end-to-end.

I'm using playback and capture callbacks to handle the audio.

The program seems to work reasonably well, but at seemingly random times 
either the playback or capture stream will "hiccup" (xrun) -- I am handling 
this case, but it's fairly often that the stream does NOT resume and I'm stuck 
with either no playback or no capture.

I've looked at the example programs and the documentation and I do not see 
what it is I'm doing wrong.  I'm posting my code here, hopefully someone can 
show me the error of my way.

Capture/playback setup (error checking removed):
snd_pcm_open(handle, fname, stream, SND_PCM_NONBLOCK);
snd_pcm_hw_params_malloc(hwptr);
snd_pcm_hw_params_any(h, hwp);
snd_pcm_hw_params_set_access(h, hwp, 
SND_PCM_ACCESS_RW_INTERLEAVED);
snd_pcm_hw_params_set_format(h, hwp, SND_PCM_FORMAT_S16_LE);
snd_pcm_hw_params_set_rate(h, hwp, 8000, 0);
snd_pcm_hw_params_set_channels(h, hwp, 2);
snd_pcm_hw_params_set_buffer_size(h, hwp, BUF_SIZE);
snd_pcm_hw_params(h, hwp);

At this point I have the capture or playback device set up for 16 bit signed 
linear data in interleaved format and two channels. I've set up the buffers to 
be 160 frames, or 20ms. Each of these calls is checked for errors, and I do 
verify that the rate, buffer size and buffer time are what I expect.  There is 
nothing unusual going on with these calls that I can determine.

I set up the playback and capture callbacks thusly (again checking for errors)
snd_async_add_pcm_handler(&ahp, hp, playback_callback, &pb_data);
snd_async_add_pcm_handler(&ahc, hc, capture_callback, &cap_data);

At this point I believe I'm ready to go, all I have to do is start playback 
and capture:
if((fcount = snd_pcm_writei(h[PLAYBACK], pb_data.buf, BUF_SIZE)) != BUF_SIZE) 
{
	if(fcount < 0) {
		if((e = snd_pcm_recover(h[PLAYBACK], fcount, 0)) < 0)
			fprintf(stderr, "initial: can't writei: %s\n", snd_strerror(e));
	} else {
		fprintf(stderr, "initial: short write: %d instead of %d\n", fcount, 
BUF_SIZE);
	}
}

if((e = snd_pcm_start(h[CAPTURE])) < 0) {
	fprintf(stderr, "capture prepare error: %s\n", snd_strerror(e));
	return 1;
}

Now the playback and capture handlers are called by ALSA as required.  The 
capture handler looks like this:

/* capture callback. Called by ALSA whenever a period time is up */
void capture_callback(snd_async_handler_t *ah)
{
	snd_pcm_t *h = snd_async_handler_get_pcm(ah);
	struct async_data *d = snd_async_handler_get_callback_private(ah);
	snd_pcm_sframes_t fa;
	short *p;
	int i, fc, e, faloops;
	struct timeval tv;
	static int c=0;

/* read in whatever is available */

	fa = snd_pcm_avail_update(h);
	faloops = 0;
	while(fa > 0) {
		if(fa > BUF_SIZE)
			fa = BUF_SIZE;

		if((fc = snd_pcm_readi(h, d->buf, fa)) != fa) {
			if(fc < 0) {
				if((e = snd_pcm_recover(h, e, 0)) < 0) {
					fprintf(stderr, "callback: can't readi: %s\n", 
snd_strerror(e));
				}

				fc = 0;
			} else {
				fprintf(stderr, "callback: short read: %d instead of %ld\n", fc, 
fa);
			}
		}

		for(i=0,p=&d->buf[0]; i<fc; i++) {
			*d->ptr++ = *p++;
			p++;

			if(d->ptr > &in[MAX_BUFS * (BUF_SIZE - 1)]) {
				d->ptr = (short *)&in[0];
			}
		}

		c += fc;
		if(c >= BUF_SIZE) {
			gettimeofday(&tv, NULL);
			c -= BUF_SIZE;

			in_step++;
			if(in_step >= MAX_BUFS)
				in_step = 0;
		}

		frames_cap += fc;
		fa = snd_pcm_avail_update(h);
		faloops++;
	};

	cap_faloops=faloops;
}

The playback callback is very similar:

/* playback callback. Called by ALSA whenever a period time is up */
void playback_callback(snd_async_handler_t *ah)
{
	snd_pcm_t *h = snd_async_handler_get_pcm(ah);
	struct async_data *d = snd_async_handler_get_callback_private(ah);
	snd_pcm_sframes_t fa;
	int i, fc, e, faloops;
	static int c=0;
	struct timeval tv;

	fa = snd_pcm_avail_update(h);
	faloops = 0;
	while(fa > 0) {
		if(fa > BUF_SIZE)
			fa = BUF_SIZE;

		for(i=0; i<fa; i++) {
			d->buf[i*2] = awgn(&noise_source);
			d->buf[i*2+1] = awgn(&noise_source);
		}

		if((fc = snd_pcm_writei(h, d->buf, fa)) != fa) {
			if(fc < 0) {
				if((e = snd_pcm_recover(h, e, 0)) < 0) {
					fprintf(stderr, "callback: can't writei: error %x %s\n", e, 
snd_strerror(e));
				}

				fc = 0;
			} else {
				fprintf(stderr, "callback: short write: %d instead of %ld\n", fc, 
fa);
			}
		}

		for(i=0; i<fc; i++) {
			*d->ptr++ = d->buf[i*2];
			if(d->ptr > &out[MAX_BUFS * (BUF_SIZE - 1)]) {
				d->ptr = (short *)&out[0];
			}
		}

		c += fc;
		if(c >= BUF_SIZE) {
			gettimeofday(&tv, NULL);
			c -= BUF_SIZE;
			out_step++;
			if(out_step >= MAX_BUFS)
				out_step = 0;
		}

		frames_pb += fc;
		fa = snd_pcm_avail_update(h);
		faloops++;
	};

	pb_faloops = faloops;
}

That's really it; the main loop keeps track of the in_step and out_step 
variables and does the cross-correlation as the data comes in.  Now it seems 
that it's the capture playback that is getting xruns, but I when capture xruns 
occur my playback callback seems to stop, and sometimes the entire program 
just hangs as if it is waiting for ALSA to call one of the callbacks.

Can anyone shed any light on this? I'm certain it's something very simple and 
braindead, but I can't find it.

Regards,
Andrew
