From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: hda - Sanity check of unexpected
	cap_sync_hook override
Date: Thu, 21 Jun 2018 14:25:01 +0200
Message-ID: <20180621122501.22290-6-tiwai@suse.de>
References: <20180621122501.22290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AB5F22676CA
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 14:25:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2D05EAFEE
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:25:05 +0000 (UTC)
In-Reply-To: <20180621122501.22290-1-tiwai@suse.de>
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

There are a couple of places setting cap_sync_hook in the codec
drivers, and they just overwrite the value.  Add a sanity check via
WARN_ON() in case if an old non-NULL value is overridden and
forgotten.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 1 +
 sound/pci/hda/patch_realtek.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a9fd0572d526..b7339cb5c45b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -343,6 +343,7 @@ static void cxt_fixup_headphone_mic(struct hda_codec *codec,
 		snd_hdac_regmap_add_vendor_verb(&codec->core, 0x410);
 		break;
 	case HDA_FIXUP_ACT_PROBE:
+		WARN_ON(spec->gen.cap_sync_hook);
 		spec->gen.cap_sync_hook = cxt_update_headset_mode_hook;
 		spec->gen.automute_hook = cxt_update_headset_mode;
 		break;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 32a7a72033ae..d9461eebcfdf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4828,6 +4828,7 @@ static void alc_probe_headset_mode(struct hda_codec *codec)
 			spec->headphone_mic_pin = cfg->inputs[i].pin;
 	}
 
+	WARN_ON(spec->gen.cap_sync_hook);
 	spec->gen.cap_sync_hook = alc_update_headset_mode_hook;
 	spec->gen.automute_hook = alc_update_headset_mode;
 	spec->gen.hp_automute_hook = alc_update_headset_jack_cb;
-- 
2.17.1
