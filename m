From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/2] Echoaudio: remove line-out volume from
	vmixer cards
Date: Sun, 15 Mar 2009 21:33:55 +0100
Message-ID: <20090315213355.e7ca643b.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 8196F1037F1
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 21:33:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

With this patch the drivers do not set the vmixer volume anymore at startup
because it is actually the output volume of the voices and ALSA mandates
that the volume must be 0 by default.


Signed-off-by Giuliano Pochini <pochini@shiny.it>

diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigodj_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigodj_dsp.c	2009-03-15 17:24:35.000000000 +0100
@@ -63,18 +63,6 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Default routing of the virtual channels: vchannels 0-3 and
-	vchannels 4-7 are routed to real channels 0-4 */
-	set_vmixer_gain(chip, 0, 0, 0);
-	set_vmixer_gain(chip, 1, 1, 0);
-	set_vmixer_gain(chip, 2, 2, 0);
-	set_vmixer_gain(chip, 3, 3, 0);
-	set_vmixer_gain(chip, 0, 4, 0);
-	set_vmixer_gain(chip, 1, 5, 0);
-	set_vmixer_gain(chip, 2, 6, 0);
-	set_vmixer_gain(chip, 3, 7, 0);
-	err = update_vmixer_level(chip);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigo_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigo_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigo_dsp.c	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigo_dsp.c	2009-03-15 17:24:14.000000000 +0100
@@ -63,18 +63,6 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Default routing of the virtual channels: all vchannels are routed
-	to the stereo output */
-	set_vmixer_gain(chip, 0, 0, 0);
-	set_vmixer_gain(chip, 1, 1, 0);
-	set_vmixer_gain(chip, 0, 2, 0);
-	set_vmixer_gain(chip, 1, 3, 0);
-	set_vmixer_gain(chip, 0, 4, 0);
-	set_vmixer_gain(chip, 1, 5, 0);
-	set_vmixer_gain(chip, 0, 6, 0);
-	set_vmixer_gain(chip, 1, 7, 0);
-	err = update_vmixer_level(chip);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigoio_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigoio_dsp.c	2009-03-15 17:24:00.000000000 +0100
@@ -63,18 +63,6 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	/* Default routing of the virtual channels: all vchannels are routed
-	to the stereo output */
-	set_vmixer_gain(chip, 0, 0, 0);
-	set_vmixer_gain(chip, 1, 1, 0);
-	set_vmixer_gain(chip, 0, 2, 0);
-	set_vmixer_gain(chip, 1, 3, 0);
-	set_vmixer_gain(chip, 0, 4, 0);
-	set_vmixer_gain(chip, 1, 5, 0);
-	set_vmixer_gain(chip, 0, 6, 0);
-	set_vmixer_gain(chip, 1, 7, 0);
-	err = update_vmixer_level(chip);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/mia_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/mia_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/mia_dsp.c	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/mia_dsp.c	2009-03-15 17:23:37.000000000 +0100
@@ -69,18 +69,6 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)))
 		return err;
 
-	/* Default routing of the virtual channels: vchannels 0-3 go to analog
-	outputs and vchannels 4-7 go to S/PDIF outputs */
-	set_vmixer_gain(chip, 0, 0, 0);
-	set_vmixer_gain(chip, 1, 1, 0);
-	set_vmixer_gain(chip, 0, 2, 0);
-	set_vmixer_gain(chip, 1, 3, 0);
-	set_vmixer_gain(chip, 2, 4, 0);
-	set_vmixer_gain(chip, 3, 5, 0);
-	set_vmixer_gain(chip, 2, 6, 0);
-	set_vmixer_gain(chip, 3, 7, 0);
-	err = update_vmixer_level(chip);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }



--
Giuliano.
