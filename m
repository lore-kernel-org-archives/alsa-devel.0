From: Klaas De Craemer <klaasdc@gmail.com>
Subject: [PATCH] Sigmatel stac92hd71b7 low HP volume
Date: Sun, 5 Oct 2008 22:10:46 +0200
Message-ID: <200810052210.46360.klaasdc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 8314F243B1
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Oct 2008 22:10:53 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so686381eyc.56
	for <alsa-devel@alsa-project.org>; Sun, 05 Oct 2008 13:10:52 -0700 (PDT)
Content-Disposition: inline
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

Hello,

A few days ago, I posted a patch to the linux kernel list, but afterwards I realised that it is 
more appropriate for the alsa list. So I repost it here.

Below is my patch for an issue on Dell E6500 notebooks with the Sigmatel stac92hd71b7 codec. In 
the default snd-hda-intel configuration, the sound going to the headphone jack 
goes comes directly from the DAC, resulting in very low volume output. The patch changes the 
codec's widget connections so that the internal mixer is put in between and sets its 
input amplifiers to the maximum value. The output to the internal speaker port has been left 
untouched.
I have tested this and it gives a much better output.

Klaas De Craemer


diff -uNr linux-2.6.26.5/sound/pci/hda/patch_sigmatel.c 
linux-2.6.26.5.new/sound/pci/hda/patch_sigmatel.c
--- linux-2.6.26.5/sound/pci/hda/patch_sigmatel.c	2008-09-08 19:40:20.000000000 +0200
+++ linux-2.6.26.5.new/sound/pci/hda/patch_sigmatel.c	2008-10-02 20:08:51.000000000 +0200
@@ -624,6 +624,22 @@
 	{}
 };
 
+static struct hda_verb stac92hd71b7_core_init[] = {
+	/* set master volume and direct control */
+	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* connect headphone jack to mixer */
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+	/* Increase mixer volume for the two dac's */
+	{ 0x17, 0x370, 0x7f },
+	{ 0x17, 0x371, 0x7f },
+	{}
+};
+
 static struct hda_verb stac92hd71bxx_core_init[] = {
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
@@ -3642,6 +3658,10 @@
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
 		break;
+	case 0x111d76b2: /* Dell E6500 stac92hd71b7 configuration */
+		spec->mixer = stac92hd71bxx_mixer;
+		spec->init = stac92hd71b7_core_init;
+		break;
 	default:
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
