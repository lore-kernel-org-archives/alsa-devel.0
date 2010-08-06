From: Steven Eastland <seastland@gmail.com>
Subject: [PATCH] New snd-hda-intel model/pin config for hp
	dv7-4000
Date: Fri, 06 Aug 2010 15:07:35 -0600
Message-ID: <4C5C7997.8090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D54D510394B
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 23:07:38 +0200 (CEST)
Received: by pwi4 with SMTP id 4so841588pwi.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 14:07:37 -0700 (PDT)
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

  This provides a new model and pin config for the snd-hda-intel 
92HD83XXX codec for hp laptop model dv7-4000, enabling the subwoofer.

Signed-off-by: Steven Eastland <seastland at gmail.com>
---

--- alsa-kernel/pci/hda/patch_sigmatel.c  2010-07-20 14:06:12.000000000 
-0600
+++ alsa-kernel/pci/hda/patch_sigmatel.c  2010-07-26 13:04:55.000000000 
-0600
@@ -94,6 +94,7 @@
   STAC_92HD83XXX_PWR_REF,
   STAC_DELL_S14,
   STAC_92HD83XXX_HP,
+ STAC_HP_DV7_4000,
   STAC_92HD83XXX_MODELS
  };

@@ -1628,10 +1629,17 @@
   0x40f000f0, 0x40f000f0,
  };

+static unsigned int hp_dv7_4000_pin_configs[10] = {
+ 0x03a12050, 0x0321201f, 0x40f000f0, 0x90170110,
+ 0x40f000f0, 0x40f000f0, 0x90170110, 0xd5a30140,
+ 0x40f000f0, 0x40f000f0,
+};
+
  static unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] = {
   [STAC_92HD83XXX_REF] = ref92hd83xxx_pin_configs,
   [STAC_92HD83XXX_PWR_REF] = ref92hd83xxx_pin_configs,
   [STAC_DELL_S14] = dell_s14_pin_configs,
+ [STAC_HP_DV7_4000] = hp_dv7_4000_pin_configs,
  };

  static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
@@ -1640,6 +1648,7 @@
   [STAC_92HD83XXX_PWR_REF] = "mic-ref",
   [STAC_DELL_S14] = "dell-s14",
   [STAC_92HD83XXX_HP] = "hp",
+ [STAC_HP_DV7_4000] = "hp-dv7-4000",
  };

  static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
