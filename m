From: Alan H <alan@horstmann.fsworld.co.uk>
Subject: Alsa-OSS so-called 'Duplex-bug'
Date: Mon, 19 Jun 2006 15:15:28 +0100
Message-ID: <200606191515.28395.alan@horstmann.fsworld.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AGrlEG2Z4YjtS2P"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_AGrlEG2Z4YjtS2P
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There is considered by some to be a duplex bug in alsa-OSS, which affects for 
example audacity, which uses portaudio.  As this affects myself very much I 
have investigated.

The cause is that the OSS ioctl SNDCTL_DSP_CHANNELS cannot set separately the 
playback and capture channels.  With the original OSS this was not a problem 
AFAICT because separate playback and capture devices are created.  However, 
with the alsa-emulation, only a single device is created.  Thus it is not 
possible to record 4 chs while playing 2.

It seems to me that some method of separately setting playback and capture 
channels should be included in the emulation.  This could be through new 
ioctls eg SNDCTL_DSP_PCHANNELS and SNDCTL_DSP_CCHANNELS;  I have devised an 
alternative using the existing SNDCTL_DSP_CHANNELS, by passing 'channels' 
calculated as (playback_channels + 256 * capture_channels) so that in effect 
the first 8 bits are playback, the 2nd 8 bits are capture.  The result is 
compatible with the existing, as numbers < 255 are treated in the existing 
way, setting playback and capture the same if the sub-streams are active.  
Thus it has simply added an enhanced mode.

Diff is attached; I wonder what your thoughts are on this??  I have been able 
to very simply patch portaudio to use this facility and the system now works 
great.

Regards  Alan

--Boundary-00=_AGrlEG2Z4YjtS2P
Content-Type: text/x-diff; charset="us-ascii";
	name="pcm_oss.c-duplex-channels.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcm_oss.c-duplex-channels.diff"

--- alsa-kernel/core/oss/pcm_oss-orig.c	2006-04-13 11:51:24.000000000 +0100
+++ alsa-kernel/core/oss/pcm_oss.c	2006-06-19 11:08:07.000000000 +0100
@@ -1156,25 +1156,67 @@
 	return substream->runtime->oss.rate;
 }
 
+static int snd_pcm_oss_get_substream_channels(struct snd_pcm_oss_file *pcm_oss_file, int substrindx)
+{
+	struct snd_pcm_substream *substream;
+	int err = -1;
+
+	if (substrindx < 0 || substrindx > 1)
+		return err;
+	substream = pcm_oss_file->streams[substrindx];
+	if (substream == NULL)
+		return 0; /* Don't complain, consider as zero active channels */
+	return substream->runtime->oss.channels;
+}
+
 static int snd_pcm_oss_set_channels(struct snd_pcm_oss_file *pcm_oss_file, unsigned int channels)
 {
-	int idx;
+	struct snd_pcm_substream *substream;
+	int playback_channels, capture_channels, channels_set = -1;
+
 	if (channels < 1)
 		channels = 1;
-	if (channels > 128)
+	if (channels > 65025)
 		return -EINVAL;
-	for (idx = 1; idx >= 0; --idx) {
-		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
-		struct snd_pcm_runtime *runtime;
-		if (substream == NULL)
-			continue;
-		runtime = substream->runtime;
-		if (runtime->oss.channels != channels) {
-			runtime->oss.params = 1;
-			runtime->oss.channels = channels;
+
+	playback_channels = channels & 255;
+			/* lower 8 bits always set playback channels */
+	if (playback_channels > 128)
+		return -EINVAL;
+	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
+	printk("SND OSS: p/b chs %i\n", playback_channels);
+	if (substream != NULL)
+		if (substream->runtime->oss.channels != playback_channels) {
+			substream->runtime->oss.params = 1;
+			substream->runtime->oss.channels = playback_channels;
 		}
+
+	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
+	if (channels >255) { /* Enhanced channel set mode */
+		capture_channels = channels / 256 & 255;
+			 /* 2nd 8 bits set capture channels */
+		if (capture_channels > 128)
+			return -EINVAL;
+		if (substream != NULL)
+			if (substream->runtime->oss.channels != capture_channels) {
+				substream->runtime->oss.params = 1;
+				substream->runtime->oss.channels = capture_channels;
+			}
+		channels_set = snd_pcm_oss_get_substream_channels(
+				   pcm_oss_file, SNDRV_PCM_STREAM_PLAYBACK)
+				   + 256 * snd_pcm_oss_get_substream_channels(
+				   pcm_oss_file, SNDRV_PCM_STREAM_CAPTURE);
+	} else {  /* Standard mode, same num channels play and capture */
+		if (substream != NULL)
+			if (substream->runtime->oss.channels != channels) {
+				 /* Capture channels same as playback */
+				substream->runtime->oss.params = 1;
+				substream->runtime->oss.channels = channels;
+			}
+		channels_set = snd_pcm_oss_get_channels(pcm_oss_file);
 	}
-	return snd_pcm_oss_get_channels(pcm_oss_file);
+	printk("SND OSS: chs set %i\n", channels_set);
+	return channels_set;
 }

 static int snd_pcm_oss_get_channels(struct snd_pcm_oss_file *pcm_oss_file)

--Boundary-00=_AGrlEG2Z4YjtS2P
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_AGrlEG2Z4YjtS2P
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_AGrlEG2Z4YjtS2P--
