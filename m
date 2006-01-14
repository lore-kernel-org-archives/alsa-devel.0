From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 3/3] echoaudio - minor changes
Date: Sat, 14 Jan 2006 18:03:50 +0000
Message-ID: <20060114180350.49ed5bde.pochini@shiny.it>
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



The latest firmware for the Gina3G hasn't input nominal level controls
anymore. This patch removes them.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__indi1/pci/echoaudio/echo3g_dsp.c alsa-driver/pci/echoaudio/echo3g_dsp.c
--- alsa-driver__indi1/pci/echoaudio/echo3g_dsp.c	2006-01-11 20:56:39.000000000 +0000
+++ alsa-driver/pci/echoaudio/echo3g_dsp.c	2006-01-12 21:40:10.000000000 +0000
@@ -74,7 +74,8 @@ static int init_hw(struct echoaudio *chi
 		chip->px_analog_in = chip->bx_analog_in = 14;
 		chip->px_digital_in = chip->bx_digital_in = 16;
 		chip->px_num = chip->bx_num = 24;
-		chip->has_phantom_power = 1;
+		chip->has_phantom_power = TRUE;
+		chip->hasnt_input_nominal_level = TRUE;
 	} else if (err == E3G_LAYLA3G_BOX_TYPE) {
 		chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
 						ECHO_CLOCK_BIT_SPDIF |
diff -dup alsa-driver__indi1/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__indi1/pci/echoaudio/echoaudio.c	2006-01-11 21:13:33.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio.c	2006-01-12 21:40:10.000000000 +0000
@@ -1939,8 +1939,9 @@ static int __devinit snd_echo_probe(stru
 #endif
 
 #ifdef ECHOCARD_HAS_INPUT_NOMINAL_LEVEL
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_intput_nominal_level, chip))) < 0)
-		goto ctl_error;
+	if (!chip->hasnt_input_nominal_level)
+		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_intput_nominal_level, chip))) < 0)
+			goto ctl_error;
 #endif
 
 #ifdef ECHOCARD_HAS_OUTPUT_NOMINAL_LEVEL
diff -dup alsa-driver__indi1/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver__indi1/pci/echoaudio/echoaudio.h	2006-01-09 22:14:51.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio.h	2006-01-12 21:40:10.000000000 +0000
@@ -387,6 +387,7 @@ struct echoaudio {
 	char non_audio_spdif;			/* 3G - only */
 	char digital_in_automute;		/* Gina24, Layla24, Mona - only */
 	char has_phantom_power;
+	char hasnt_input_nominal_level;		/* Gina3G */
 	char phantom_power;			/* Gina3G - only */
 	char has_midi;
 	char midi_input_enabled;



--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
