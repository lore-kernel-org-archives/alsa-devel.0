From: Ken Arromdee <arromdee@rahul.net>
Subject: Re: Help with AD1816 driver please...
Date: Fri, 3 Feb 2006 09:52:54 -0800 (PST)
Message-ID: <Pine.LNX.4.44.0602030951480.18169-100000@green.rahul.net>
References: <1138945160.15691.239.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1138945160.15691.239.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Here's the diff.

Note that this only fixes half of the problem.  I haven't been able to
figure out the other half.

--- ad1816a_lib.c.orig	2006-02-02 23:32:50.000000000 -0500
+++ ad1816a_lib.c	2006-02-02 23:38:54.000000000 -0500
@@ -174,7 +174,7 @@
 
 
 static int snd_ad1816a_trigger(struct snd_ad1816a *chip, unsigned char what,
-	           int channel, int cmd)
+	           int channel, int cmd, int iscapture)
 {
     int error = 0;
 
@@ -183,10 +183,14 @@
     case SNDRV_PCM_TRIGGER_STOP:
 	spin_lock(&chip->lock);
 	cmd = (cmd == SNDRV_PCM_TRIGGER_START) ? 0xff: 0x00;
-	if (what & AD1816A_PLAYBACK_ENABLE)
+	/* if (what & AD1816A_PLAYBACK_ENABLE) */
+	/* That is not valid, because playback and capture enable
+	 * are the same bit pattern, just to different addresses
+	 */
+	if (!iscapture)
 	    snd_ad1816a_out_mask(chip, AD1816A_PLAYBACK_CONFIG,
 		AD1816A_PLAYBACK_ENABLE, cmd);
-	if (what & AD1816A_CAPTURE_ENABLE)
+	if (iscapture)
 	    snd_ad1816a_out_mask(chip, AD1816A_CAPTURE_CONFIG,
 		AD1816A_CAPTURE_ENABLE, cmd);
 	spin_unlock(&chip->lock);
@@ -203,14 +207,14 @@
 {
     struct snd_ad1816a *chip = snd_pcm_substream_chip(substream);
     return snd_ad1816a_trigger(chip, AD1816A_PLAYBACK_ENABLE,
-	SNDRV_PCM_STREAM_PLAYBACK, cmd);
+	SNDRV_PCM_STREAM_PLAYBACK, cmd, 0);
 }
 
 static int snd_ad1816a_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 {
     struct snd_ad1816a *chip = snd_pcm_substream_chip(substream);
     return snd_ad1816a_trigger(chip, AD1816A_CAPTURE_ENABLE,
-	SNDRV_PCM_STREAM_CAPTURE, cmd);
+	SNDRV_PCM_STREAM_CAPTURE, cmd, 1);
 }
 
 static int snd_ad1816a_hw_params(struct snd_pcm_substream *substream,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
