From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATHC] echoaudio, ADAT mode sample rate fix
Date: Sat, 11 Feb 2006 22:11:59 +0100
Message-ID: <20060211221159.22f6b3b1.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


The sample rate in ADAT mode must be limited at 48KHz, even if we are
using an analog channel. (also remove old usess commented out code)


Signed-off-by: Giulaino Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	2006-01-25 21:57:31.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio.c	2006-02-11 21:39:07.000000000 +0100
@@ -208,7 +208,7 @@ static int hw_rule_sample_rate(struct sn
 
 
 
-static int pcm_open(struct snd_pcm_substream *substream, signed char max_channels, char adat)
+static int pcm_open(struct snd_pcm_substream *substream, signed char max_channels)
 {
 	struct echoaudio *chip;
 	struct snd_pcm_runtime *runtime;
@@ -217,14 +217,7 @@ static int pcm_open(struct snd_pcm_subst
 
 	if (max_channels <= 0)
 		return -EAGAIN;
-/*
-	if (check_asic_status(chip) < 0) {
-		DE_HWP(("HW error. Trying to reload the firmware...\n"));
-		err = load_firmware(chip);
-		if (err || chip->bad_board)
-			return -EIO;
-	}
-*/
+
 	chip = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
@@ -242,7 +235,7 @@ static int pcm_open(struct snd_pcm_subst
 	pipe->constr.count = i;
 	if (pipe->hw.channels_max > max_channels)
 		pipe->hw.channels_max = max_channels;
-	if (adat) {
+	if (chip->digital_mode == DIGITAL_MODE_ADAT) {
 		pipe->hw.rate_max = 48000;
 		pipe->hw.rates &= SNDRV_PCM_RATE_8000_48000;
 	}
@@ -290,7 +283,7 @@ static int pcm_analog_in_open(struct snd
 	int err;
 
 	DE_ACT(("pcm_analog_in_open\n"));
-	if ((err = pcm_open(substream, num_analog_busses_in(chip) - substream->number, 0)) < 0)
+	if ((err = pcm_open(substream, num_analog_busses_in(chip) - substream->number)) < 0)
 		return err;
 	if ((err = snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 					hw_rule_capture_channels_by_format, NULL,
@@ -320,7 +313,7 @@ static int pcm_analog_out_open(struct sn
 	max_channels = num_analog_busses_out(chip);
 #endif
 	DE_ACT(("pcm_analog_out_open\n"));
-	if ((err = pcm_open(substream, max_channels - substream->number, 0)) < 0)
+	if ((err = pcm_open(substream, max_channels - substream->number)) < 0)
 		return err;
 	if ((err = snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 					hw_rule_playback_channels_by_format, NULL,
@@ -350,9 +343,9 @@ static int pcm_digital_in_open(struct sn
 	max_channels = num_digital_busses_in(chip) - substream->number;
 	down(&chip->mode_mutex);
 	if (chip->digital_mode == DIGITAL_MODE_ADAT)
-		err = pcm_open(substream, max_channels, 1);
+		err = pcm_open(substream, max_channels);
 	else	/* If the card has ADAT, subtract the 6 channels that S/PDIF doesn't have */
-		err = pcm_open(substream, max_channels - ECHOCARD_HAS_ADAT, 0);
+		err = pcm_open(substream, max_channels - ECHOCARD_HAS_ADAT);
 
 	if (err < 0)
 		goto din_exit;
@@ -390,9 +383,9 @@ static int pcm_digital_out_open(struct s
 	max_channels = num_digital_busses_out(chip) - substream->number;
 	down(&chip->mode_mutex);
 	if (chip->digital_mode == DIGITAL_MODE_ADAT)
-		err = pcm_open(substream, max_channels, 1);
+		err = pcm_open(substream, max_channels);
 	else	/* If the card has ADAT, subtract the 6 channels that S/PDIF doesn't have */
-		err = pcm_open(substream, max_channels - ECHOCARD_HAS_ADAT, 0);
+		err = pcm_open(substream, max_channels - ECHOCARD_HAS_ADAT);
 
 	if (err < 0)
 		goto dout_exit;




--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
