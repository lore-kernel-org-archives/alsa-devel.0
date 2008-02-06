From: "M G" <lists.mg@googlemail.com>
Subject: snd-hda-intel: Fix volume-wheel and microphone on
	Fujitsu-Siemens Amilo M3438G
Date: Wed, 6 Feb 2008 17:14:37 +0100
Message-ID: <74d457500802060814j64532e95v8c689cbb491c6b46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 8685B1037EE
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 17:14:39 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so4187848pyg.36
	for <alsa-devel@alsa-project.org>; Wed, 06 Feb 2008 08:14:38 -0800 (PST)
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

Currently the default model that gets selected on this hardware is "F1734".
Using this model neither the volume-wheel nor microphone (internal or
external) work.

The first part of my patch changes the default model to "fujitsu", this
enables the volume wheel on the left side of the laptop.

The second part changes the capture settings and thus makes it possible to
record from microphones. Now when capturing from the external microphone I
can hear myself talking but its quite quiet. I can improve this a little by
raising the capture volume, but if I raise it above 40 I can no longer
record anything.



Questions:
Is this patch any good or is there a better way to fix my problems?
Why is the recording so quiet and why can't I record with capture value
above 40?



Patch:
diff -r c4c5e6ced12f pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c    Wed Feb 06 15:48:06 2008 +0100
+++ b/pci/hda/patch_realtek.c    Wed Feb 06 15:59:28 2008 +0100
@@ -2917,7 +2917,7 @@ static struct snd_pci_quirk alc880_cfg_t
     SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_W810),
     SND_PCI_QUIRK(0x1695, 0x400d, "EPoX", ALC880_5ST_DIG),
     SND_PCI_QUIRK(0x1695, 0x4012, "EPox EP-5LDA", ALC880_5ST_DIG),
-    SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_F1734),
+    SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_FUJITSU),
     SND_PCI_QUIRK(0x1734, 0x10ac, "FSC", ALC880_UNIWILL),
     SND_PCI_QUIRK(0x1734, 0x10b0, "Fujitsu", ALC880_FUJITSU),
     SND_PCI_QUIRK(0x1854, 0x0018, "LG LW20", ALC880_LG_LW),
@@ -3161,7 +3161,7 @@ static struct alc_config_preset alc880_p
         .dig_out_nid = ALC880_DIGOUT_NID,
         .num_channel_mode = ARRAY_SIZE(alc880_2_jack_modes),
         .channel_mode = alc880_2_jack_modes,
-        .input_mux = &alc880_capture_source,
+        .input_mux = &alc880_6stack_capture_source,
         .unsol_event = alc880_uniwill_p53_unsol_event,
         .init_hook = alc880_uniwill_p53_hp_automute,
     },
