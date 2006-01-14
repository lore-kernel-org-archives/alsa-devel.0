From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 4/4] echoaudio - minor changes
Date: Sat, 14 Jan 2006 18:04:17 +0000
Message-ID: <20060114180417.46de3397.pochini@shiny.it>
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


Check for more error conditions during hw init, expecially
when debugging is enabled.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__indi2/pci/echoaudio/echo3g_dsp.c alsa-driver/pci/echoaudio/echo3g_dsp.c
--- alsa-driver__indi2/pci/echoaudio/echo3g_dsp.c	2006-01-12 21:40:10.000000000 +0000
+++ alsa-driver/pci/echoaudio/echo3g_dsp.c	2006-01-14 16:27:21.000000000 +0000
@@ -98,10 +98,13 @@ static int init_hw(struct echoaudio *chi
 	chip->non_audio_spdif = FALSE;
 	chip->bad_board = FALSE;
 
-	err = init_line_levels(chip);
-	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
-	set_phantom_power(chip, 0);
-	set_professional_spdif(chip, TRUE);
+	if ((err = init_line_levels(chip)) < 0)
+		return err;
+	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	snd_assert(err >= 0, return err);
+	err = set_phantom_power(chip, 0);
+	snd_assert(err >= 0, return err);
+	err = set_professional_spdif(chip, TRUE);
 
 	DE_INIT(("init_hw done\n"));
 	return err;
diff -dup alsa-driver__indi2/pci/echoaudio/gina24_dsp.c alsa-driver/pci/echoaudio/gina24_dsp.c
--- alsa-driver__indi2/pci/echoaudio/gina24_dsp.c	2006-01-11 21:32:51.000000000 +0000
+++ alsa-driver/pci/echoaudio/gina24_dsp.c	2006-01-14 16:27:21.000000000 +0000
@@ -76,8 +76,10 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	err = init_line_levels(chip);
-	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	if ((err = init_line_levels(chip)) < 0)
+		return err;
+	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	snd_assert(err >= 0, return err);
 	err = set_professional_spdif(chip, TRUE);
 
 	DE_INIT(("init_hw done\n"));
diff -dup alsa-driver__indi2/pci/echoaudio/indigo_dsp.c alsa-driver/pci/echoaudio/indigo_dsp.c
--- alsa-driver__indi2/pci/echoaudio/indigo_dsp.c	2006-01-12 21:35:13.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigo_dsp.c	2006-01-14 16:16:03.000000000 +0000
@@ -69,7 +69,7 @@ static int init_hw(struct echoaudio *chi
 	set_vmixer_gain(chip, 1, 5, 0);
 	set_vmixer_gain(chip, 0, 6, 0);
 	set_vmixer_gain(chip, 1, 7, 0);
-	update_vmixer_level(chip);
+	err = update_vmixer_level(chip);
 
 	DE_INIT(("init_hw done\n"));
 	return err;
diff -dup alsa-driver__indi2/pci/echoaudio/indigodj_dsp.c alsa-driver/pci/echoaudio/indigodj_dsp.c
--- alsa-driver__indi2/pci/echoaudio/indigodj_dsp.c	2006-01-12 21:35:13.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigodj_dsp.c	2006-01-14 16:16:03.000000000 +0000
@@ -69,7 +69,7 @@ static int init_hw(struct echoaudio *chi
 	set_vmixer_gain(chip, 1, 5, 0);
 	set_vmixer_gain(chip, 2, 6, 0);
 	set_vmixer_gain(chip, 3, 7, 0);
-	update_vmixer_level(chip);
+	err = update_vmixer_level(chip);
 
 	DE_INIT(("init_hw done\n"));
 	return err;
diff -dup alsa-driver__indi2/pci/echoaudio/indigoio_dsp.c alsa-driver/pci/echoaudio/indigoio_dsp.c
--- alsa-driver__indi2/pci/echoaudio/indigoio_dsp.c	2006-01-12 21:35:13.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigoio_dsp.c	2006-01-14 16:16:03.000000000 +0000
@@ -69,7 +69,7 @@ static int init_hw(struct echoaudio *chi
 	set_vmixer_gain(chip, 1, 5, 0);
 	set_vmixer_gain(chip, 0, 6, 0);
 	set_vmixer_gain(chip, 1, 7, 0);
-	update_vmixer_level(chip);
+	err = update_vmixer_level(chip);
 
 	DE_INIT(("init_hw done\n"));
 	return err;
diff -dup alsa-driver__indi2/pci/echoaudio/layla24_dsp.c alsa-driver/pci/echoaudio/layla24_dsp.c
--- alsa-driver__indi2/pci/echoaudio/layla24_dsp.c	2006-01-11 21:32:51.000000000 +0000
+++ alsa-driver/pci/echoaudio/layla24_dsp.c	2006-01-14 16:27:21.000000000 +0000
@@ -69,7 +69,8 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	snd_assert(err >= 0, return err);
 	err = set_professional_spdif(chip, TRUE);
 
 	DE_INIT(("init_hw done\n"));
diff -dup alsa-driver__indi2/pci/echoaudio/mona_dsp.c alsa-driver/pci/echoaudio/mona_dsp.c
--- alsa-driver__indi2/pci/echoaudio/mona_dsp.c	2006-01-11 21:32:51.000000000 +0000
+++ alsa-driver/pci/echoaudio/mona_dsp.c	2006-01-14 16:27:21.000000000 +0000
@@ -74,7 +74,8 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
+	snd_assert(err >= 0, return err);
 	err = set_professional_spdif(chip, TRUE);
 
 	DE_INIT(("init_hw done\n"));


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
