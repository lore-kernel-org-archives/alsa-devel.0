From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: simple PCM helper function
Date: Tue, 10 Jan 2006 13:26:58 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601101254540.10330@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0601062102080.10811@tm8103.perex-int.cz>
 <43C28D90.10103@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A28813C
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 13:26:59 +0100 (MET)
In-Reply-To: <43C28D90.10103@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Jan 2006, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> 
> > Hi all,
> > 
> > I added three functions to alsa-lib - PCM API:
> > 
> > /*
> > * application helpers - these functions are implemented on top
> > * of the basic API
> > */
> > 
> > int snd_pcm_recover(snd_pcm_t *pcm, int err, int silent);
> > int snd_pcm_set_params(snd_pcm_t *pcm,
> > snd_pcm_format_t format,
> > snd_pcm_access_t access,
> > unsigned int channels,
> > unsigned int rate,
> > int soft_resample,
> > unsigned int latency);
> > int snd_pcm_get_params(snd_pcm_t *pcm,
> > snd_pcm_uframes_t *buffer_size,
> > snd_pcm_uframes_t *period_size);
> > 
> > 	These functions are intended for "lazy" people who are doing just
> > simple command line players or recorders and don't want to bother with
> > the ALSA details. The implementation comes from strong attitude against
> > alsa-lib on LKML by some people.
> > 	Please, look to them and tell me, if I missed something useable.
> > The really "minimalistic" example using these functions is in
> > alsa-lib/test/pcm_min.c (compile the code typing 'make pcm_min' in the
> > test directory).
> > 
> > Jaroslav
> > 
> > 
> Would it not have been better to provide a similar few function calls, 
> but use a method similar to MaxOSX. I.e. callback based. I.e. Set 
> parameters, and one of the parameters is the callback function of the 
> user's program. The application would then not care how big the sound 
> hardware buffer size was.

Yes, the callback method might be an alternative, but the standard way is 
simply write samples to device, so we shouldn't remove it.

 The callback would just be: 

> snd_pcm_callback(void *private, /* Private information provided by the 
> user application at set_params call */ void *buffer, /* Frame buffer */ 
> snd_pcm_uframes_t number_of_samples_please, /* number of samples for 
> frame buffer */
>            snd_pcm_format_t format, /* Might not be needed, but the same
> format. */
>            snd_pcm_uframe_t delay, /* Estimate of delay between the current
> time, and the time when the same will reach the DAC */
> int status);  /* RUNNING, XRUN etc. */
> 
> Where "number_of_samples_please" is likely to be the period size.
> One could therefore drop the

You must also add a new function "snd_pcm_check_for_space()" or something 
like this. The app callback will be called from this function. Also, the 
app callback function should probably take same parameters as 
snd_pcm_mmap_begin() handles (areas, offset), because we support more
ring buffer organization schemes.

So, to all others, is this mechanism worth to implement?

audio_callback(areas, offset, samples, status) {
	if (status)
		status = snd_pcm_recover();
	if (status) {
		/* handle error here */
		return;
	}
	... process new samples here, i/o from areas at specified offset ...
}

main() {
	snd_pcm_open()
	snd_pcm_set_params()
	snd_pcm_set_callback(audio_callback);
	while (1) {
		poll();
		if (poll_set_audio_fd)
			if (snd_pcm_check_for_space() < 0)
				/* handle error here */
	}
}
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
