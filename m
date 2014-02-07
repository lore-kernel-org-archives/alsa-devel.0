From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix leftover ifdef checks after
	modularization
Date: Fri,  7 Feb 2014 12:18:45 +0100
Message-ID: <1391771925-31031-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E5AD02607C8
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 12:18:45 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B8E9DABA6
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 11:18:45 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since the commit [595fe1b702c3: ALSA: hda - Make
CONFIG_SND_HDA_CODEC_* tristate], the kconfig variables for the
generic parser and codec drivers can be "m" instead of boolean, but
some codes are left unchanged to check only #ifdef
CONFIG_SND_HDA_CODEC_XXX, which is no longer true for modules.
This patch fixes them by replacing with IS_ENABLED() macros.

Fixes: 595fe1b702c3 ('ALSA: hda - Make CONFIG_SND_HDA_CODEC_* tristate')
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=70161
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 6 +++---
 sound/pci/hda/hda_intel.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ec4536c8d8d4..69acbf758bbb 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -932,7 +932,7 @@ int snd_hda_bus_new(struct snd_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_hda_bus_new);
 
-#ifdef CONFIG_SND_HDA_GENERIC
+#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
 #define is_generic_config(codec) \
 	(codec->modelname && !strcmp(codec->modelname, "generic"))
 #else
@@ -1570,7 +1570,7 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 EXPORT_SYMBOL_GPL(snd_hda_codec_update_widgets);
 
 
-#ifdef CONFIG_SND_HDA_CODEC_HDMI
+#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 /* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
 static bool is_likely_hdmi_codec(struct hda_codec *codec)
 {
@@ -1622,7 +1622,7 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 		unload_parser(codec); /* to be sure */
 		if (is_likely_hdmi_codec(codec))
 			patch = load_parser(codec, snd_hda_parse_hdmi_codec);
-#ifdef CONFIG_SND_HDA_GENERIC
+#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
 		if (!patch)
 			patch = load_parser(codec, snd_hda_parse_generic_codec);
 #endif
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fa2879a21a50..e354ab1ec20f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -198,7 +198,7 @@ MODULE_DESCRIPTION("Intel HDA driver");
 #endif
 
 #if defined(CONFIG_PM) && defined(CONFIG_VGA_SWITCHEROO)
-#ifdef CONFIG_SND_HDA_CODEC_HDMI
+#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 #define SUPPORT_VGA_SWITCHEROO
 #endif
 #endif
-- 
1.8.5.2
