From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/2] Echoaudio, remove useless code
Date: Sat, 8 Oct 2005 12:46:55 +0000
Message-ID: <20051008124655.373ff4bd.pochini@shiny.it>
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


- Remove unneeded calls to set_nominal_level() because the comm page has
just been zeroed by init_dsp_comm_page().


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/darla24_dsp.c alsa-driver/pci/echoaudio/darla24_dsp.c
--- alsa-driver__orig/pci/echoaudio/darla24_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/darla24_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -62,10 +62,6 @@ static int init_hw(echoaudio_t *chip, u1
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Set professional nominal levels. This card has no digital i/o, so analog pipes are contiguous */
-	for (i = 0; i < num_busses_out(chip) + num_busses_in(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);	/* FALSE is +4dBu here */
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
diff -dup alsa-driver__orig/pci/echoaudio/echo3g_dsp.c alsa-driver/pci/echoaudio/echo3g_dsp.c
--- alsa-driver__orig/pci/echoaudio/echo3g_dsp.c	2005-09-24 11:54:35.000000000 +0000
+++ alsa-driver/pci/echoaudio/echo3g_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -111,13 +111,6 @@ static int init_hw(echoaudio_t *chip, u1
 	/* Must call this here after DSP is init to init gains and mutes */
 	err = init_line_levels(chip);
 
-	/* Set professional nominal levels (FALSE is +4dBu) */
-	for (i = 0; i < num_analog_busses_out(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);
-
-	for (i = 0; i < num_analog_busses_in(chip); i++)
-		err = set_nominal_level(chip, bx_analog_in(chip) + i, FALSE);
-
 	/* Set the digital mode to S/PDIF RCA */
 	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
 	set_phantom_power(chip, 0);
diff -dup alsa-driver__orig/pci/echoaudio/gina24_dsp.c alsa-driver/pci/echoaudio/gina24_dsp.c
--- alsa-driver__orig/pci/echoaudio/gina24_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/gina24_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -83,13 +83,6 @@ static int init_hw(echoaudio_t *chip, u1
 	/* Must call this here after DSP is init to init gains and mutes */
 	err = init_line_levels(chip);
 
-	/* Set professional nominal levels (FALSE is +4dBu) */
-	for (i = 0; i < num_analog_busses_out(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);
-
-	for (i = 0; i < num_analog_busses_in(chip); i++)
-		err = set_nominal_level(chip, bx_analog_in(chip) + i, FALSE);
-
 	/* Set the digital mode to S/PDIF RCA */
 	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
 
diff -dup alsa-driver__orig/pci/echoaudio/layla20_dsp.c alsa-driver/pci/echoaudio/layla20_dsp.c
--- alsa-driver__orig/pci/echoaudio/layla20_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/layla20_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -68,13 +68,6 @@ static int init_hw(echoaudio_t *chip, u1
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Set professional nominal levels (FALSE is +4dBu) */
-	for (i = 0; i < num_analog_busses_out(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);
-
-	for (i = 0; i < num_analog_busses_in(chip); i++)
-		err = set_nominal_level(chip, bx_analog_in(chip) + i, FALSE);
-
 	/* Set the S/PDIF output format to "professional" */
 	err = set_professional_spdif(chip, TRUE);
 
diff -dup alsa-driver__orig/pci/echoaudio/layla24_dsp.c alsa-driver/pci/echoaudio/layla24_dsp.c
--- alsa-driver__orig/pci/echoaudio/layla24_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/layla24_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -74,13 +74,6 @@ static int init_hw(echoaudio_t *chip, u1
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Set professional nominal levels (FALSE is +4dBu) */
-	for (i = 0; i < num_analog_busses_out(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);
-
-	for (i = 0; i < num_analog_busses_in(chip); i++)
-		err = set_nominal_level(chip, bx_analog_in(chip) + i, FALSE);
-
 	/* Set the digital mode to S/PDIF RCA */
 	set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
 
diff -dup alsa-driver__orig/pci/echoaudio/mia_dsp.c alsa-driver/pci/echoaudio/mia_dsp.c
--- alsa-driver__orig/pci/echoaudio/mia_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/mia_dsp.c	2005-10-08 09:14:11.000000000 +0000
@@ -69,13 +69,6 @@ static int init_hw(echoaudio_t *chip, u1
 	if ((err = init_line_levels(chip)))
 		return err;
 
-	/* Set professional nominal levels (FALSE is +4dBu) */
-	for (i = 0; i < num_analog_busses_out(chip); i++)
-		err = set_nominal_level(chip, i, FALSE);
-
-	for (i = 0; i < num_analog_busses_in(chip); i++)
-		err = set_nominal_level(chip, bx_analog_in(chip) + i, FALSE);
-
 	/* Default routing of the virtual channels: vchannels 0-3 go to analog
 	outputs and vchannels 4-7 go to S/PDIF outputs */
 	set_vmixer_gain(chip, 0, 0, 0);


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
