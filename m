From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS SNDCTL_DSP_GETISPACE, non-blocking read: messy
 :-\
Date: Tue, 28 Oct 2003 14:30:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310281428510.21064@pnote.perex-int.cz>
References: <20031025200221.GA6415@rhlx01.fht-esslingen.de> <s5hbrs27uu6.wl@alsa2.suse.de>
 <20031027121158.GA30019@rhlx01.fht-esslingen.de> <s5hd6ch620s.wl@alsa2.suse.de>
 <Pine.LNX.4.53.0310281335370.21064@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0310281335370.21064@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: andi@rhlx01.fht-esslingen.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Oct 2003, Jaroslav Kysela wrote:

> On Tue, 28 Oct 2003, Takashi Iwai wrote:
>
> > At Mon, 27 Oct 2003 13:11:58 +0100,
> > Andreas Mohr wrote:
> > >
> > > Hello Takashi,
> > >
> > > On Mon, Oct 27, 2003 at 01:01:37PM +0100, Takashi Iwai wrote:
> > > > At Sat, 25 Oct 2003 22:02:21 +0200,
> > > > Andreas Mohr wrote:
> > > > > Or, as a short summary:
> > > > > The application is perfectly well aware of how many bytes there are left
> > > > > to read (from calling SNDCTL_DSP_GETISPACE) and then does a read() with
> > > > > this amount of bytes, however since the ALSA OSS layer attempts to read
> > > > > this byte amount in blocks of runtime->oss.period_bytes bytes from the sound
> > > > > device, we ARTIFICIALLY cause a -EAGAIN to be returned due to insufficient
> > > > > available data, thus potentially confusing many OSS applications.
> > > > >
> > > > > Now what to do here?
> > > >
> > > > this problem is a bit touch, because the ALSA OSS layer does the
> > > > sample-rate conversion, etc.
> > > > when the sample rate is converted between 44.1kHz and 48kHz, some
> > > > round error may happen and it will be accumulated.   hence, the size
> > > > will be different between two cases: reading a whole period once and
> > > > reading a period by multiple calls.
> > > >
> > > > i'll take a more deeper look...
> > > Ah, thanks! (also for the explanation given above)
> > >
> > > Given that 1.0 is approaching, it'd certainly be useful to get such a
> > > problem fixed ;-)
> >
> > i come to believe that it's a bug, too.
> > as you wrote, the fix is easy except for the rare problem what i
> > mentioned above.  in that case (e.g. the sample-rate conversion
> > between 44.1 and 48khz required), you'll still get -EAGAIN
> > occasionally.  but normally, it seems ok.
> >
> > the attached is the patch to fix the original problem.
> > to take back to the old behavior (always reading a whole period),
> > you can write "whole-frag" command to the proc file.
> >
> > anyway, i'll try a bit more to solve the problem above.
>
> I think that the problem is at another place. I'm investigating the bug in
> code now.

Yes, several assumptions were made and the SPACE ioctls were a bit broken.
I've put a fix to our CVS (also included to this e-mail). Hopefully, it
won't break another OSS applications.

						Jaroslav

Index: pcm_oss.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
retrieving revision 1.53
diff -u -r1.53 pcm_oss.c
--- pcm_oss.c	30 Sep 2003 09:28:26 -0000	1.53
+++ pcm_oss.c	28 Oct 2003 13:26:12 -0000
@@ -125,8 +125,8 @@
 	if (runtime->period_size == runtime->oss.period_bytes)
 		return frames;
 	if (runtime->period_size < runtime->oss.period_bytes)
-		return frames * (runtime->oss.period_bytes / runtime->period_size);
-	return frames / (runtime->period_size / runtime->oss.period_bytes);
+		return (frames * runtime->period_size) / runtime->oss.period_bytes;
+	return (frames * runtime->oss.period_bytes) / runtime->period_size;
 }

 static int snd_pcm_oss_format_from(int format)
@@ -451,7 +451,7 @@
 	sw_params->tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
 	sw_params->period_step = 1;
 	sw_params->sleep_min = 0;
-	sw_params->avail_min = runtime->period_size;
+	sw_params->avail_min = 1;
 	sw_params->xfer_align = 1;
 	if (atomic_read(&runtime->mmap_count) ||
 	    (substream->oss.setup && substream->oss.setup->nosilence)) {
@@ -470,7 +470,6 @@
 		snd_printd("SW_PARAMS failed: %i\n", err);
 		goto failure;
 	}
-	runtime->control->avail_min = runtime->period_size;

 	runtime->oss.periods = params_periods(sparams);
 	oss_period_size = snd_pcm_plug_client_size(substream, params_period_size(sparams));
@@ -883,7 +882,7 @@
 				if (tmp <= 0)
 					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 				runtime->oss.bytes += tmp;
-				runtime->oss.buffer_used = runtime->oss.period_bytes;
+				runtime->oss.buffer_used = tmp;
 			}
 			tmp = bytes;
 			if ((size_t) tmp > runtime->oss.buffer_used)
@@ -1425,6 +1424,7 @@
 	snd_pcm_substream_t *substream;
 	snd_pcm_runtime_t *runtime;
 	snd_pcm_sframes_t delay;
+	int fixup;
 	struct count_info info;
 	int err;

@@ -1447,9 +1447,13 @@
 		if (err == -EPIPE || err == -ESTRPIPE) {
 			err = 0;
 			delay = 0;
+			fixup = 0;
+		} else {
+			fixup = runtime->oss.buffer_used;
 		}
 	} else {
 		err = snd_pcm_oss_capture_position_fixup(substream, &delay);
+		fixup = -runtime->oss.buffer_used;
 	}
 	if (err < 0)
 		return err;
@@ -1469,7 +1473,8 @@
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			snd_pcm_oss_simulate_fill(substream);
 	} else {
-		info.blocks = delay / runtime->period_size;
+		delay = snd_pcm_oss_bytes(substream, delay) + fixup;
+		info.blocks = delay / runtime->oss.period_bytes;
 	}
 	if (copy_to_user(_info, &info, sizeof(info)))
 		return -EFAULT;
@@ -1481,6 +1486,7 @@
 	snd_pcm_substream_t *substream;
 	snd_pcm_runtime_t *runtime;
 	snd_pcm_sframes_t avail;
+	int fixup;
 	struct audio_buf_info info;
 	int err;

@@ -1500,7 +1506,7 @@
 	if (runtime->oss.prepare) {
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			info.bytes = runtime->oss.period_bytes * runtime->periods;
-			info.fragments = runtime->periods;
+			info.fragments = runtime->oss.periods;
 		} else {
 			info.bytes = 0;
 			info.fragments = 0;
@@ -1511,16 +1517,19 @@
 			if (err == -EPIPE || err == -ESTRPIPE) {
 				avail = runtime->buffer_size;
 				err = 0;
+				fixup = 0;
 			} else {
 				avail = runtime->buffer_size - avail;
+				fixup = -runtime->oss.buffer_used;
 			}
 		} else {
 			err = snd_pcm_oss_capture_position_fixup(substream, &avail);
+			fixup = runtime->oss.buffer_used;
 		}
 		if (err < 0)
 			return err;
-		info.bytes = snd_pcm_oss_bytes(substream, avail);
-		info.fragments = avail / runtime->period_size;
+		info.bytes = snd_pcm_oss_bytes(substream, avail) + fixup;
+		info.fragments = info.bytes / runtime->oss.period_bytes;
 	}

 #ifdef OSS_DEBUG

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
