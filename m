From: Stelian Pop <stelian@popies.net>
Subject: [PATCH] Enable HP output on nVidia Corporation MCP79
	HDA (rev b1)	(Macbook Pro 5, 5)
Date: Thu, 30 Jul 2009 14:44:27 +0200
Message-ID: <20090730124426.GA11216@calypso>
Reply-To: Stelian Pop <stelian@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sd-11162.dedibox.fr (sd-11162.dedibox.fr [88.191.70.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 48A871038F1
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 14:44:30 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas =?iso-8859-1?Q?N=FC=DFlein?= <nutz@unfoog.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The patch below, to be applied on the latest sound-unstable-2.6.git,
enables headphones output on my MacBookPro 5,5, together with the
automuting feature.

Here is the exact soundcard id:
	Vendor Id: 0x10134206
	Subsystem Id: 0x106b4d00
	Revision Id: 0x100301

Thanks for the previous efforts to make this work !

Stelian.

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index f552738..09be633 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -832,6 +832,12 @@ static void cs_automute(struct hda_codec *codec)
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
 				    hp_present ? 0 : PIN_OUT);
 	}
+	if (spec->board_config == CS420X_MBP55) {
+		if (hp_present)
+			snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0x2);
+		else
+			snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0x8);
+	}
 }
 
 static void cs_automic(struct hda_codec *codec)
@@ -1133,10 +1139,10 @@ static int patch_cs420x(struct hda_codec *codec)
 
 	switch (spec->board_config) {
 	case CS420X_MBP55:
-		/* GPIO3 = EAPD? */
-		spec->gpio_mask = 0x08;
-		spec->gpio_dir = 0x08;
-		spec->gpio_data = 0x08;
+		/* GPIO1 = headphones */
+		/* GPIO3 = speakers */
+		spec->gpio_mask = 0x0a;
+		spec->gpio_dir = 0x0a;
 		break;
 	}
 

-- 
Stelian Pop <stelian@popies.net>
