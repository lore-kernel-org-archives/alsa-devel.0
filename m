From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: hda - Remove obsoleted
	snd_hda_check_board_config() & co
Date: Mon, 18 Aug 2014 17:30:28 +0200
Message-ID: <1408375833-22957-2-git-send-email-tiwai@suse.de>
References: <1408375833-22957-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 386AF26564B
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 17:30:36 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9A64AD0D
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:30:35 +0000 (UTC)
In-Reply-To: <1408375833-22957-1-git-send-email-tiwai@suse.de>
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

The helper functions snd_hda_check_board_config() and
snd_hda_check_board_codec_sid_config() are no longer used since the
transition to the generic parser and all quirks have been replaced
with fixups.  Let's kill these dead codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 115 ----------------------------------------------
 sound/pci/hda/hda_local.h |   6 ---
 2 files changed, 121 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ec6a7d0d1886..0aa2e1ed1dbc 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4817,121 +4817,6 @@ int snd_hda_build_pcms(struct hda_bus *bus)
 EXPORT_SYMBOL_GPL(snd_hda_build_pcms);
 
 /**
- * snd_hda_check_board_config - compare the current codec with the config table
- * @codec: the HDA codec
- * @num_configs: number of config enums
- * @models: array of model name strings
- * @tbl: configuration table, terminated by null entries
- *
- * Compares the modelname or PCI subsystem id of the current codec with the
- * given configuration table.  If a matching entry is found, returns its
- * config value (supposed to be 0 or positive).
- *
- * If no entries are matching, the function returns a negative value.
- */
-int snd_hda_check_board_config(struct hda_codec *codec,
-			       int num_configs, const char * const *models,
-			       const struct snd_pci_quirk *tbl)
-{
-	if (codec->modelname && models) {
-		int i;
-		for (i = 0; i < num_configs; i++) {
-			if (models[i] &&
-			    !strcmp(codec->modelname, models[i])) {
-				codec_info(codec, "model '%s' is selected\n",
-					   models[i]);
-				return i;
-			}
-		}
-	}
-
-	if (!codec->bus->pci || !tbl)
-		return -1;
-
-	tbl = snd_pci_quirk_lookup(codec->bus->pci, tbl);
-	if (!tbl)
-		return -1;
-	if (tbl->value >= 0 && tbl->value < num_configs) {
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		char tmp[10];
-		const char *model = NULL;
-		if (models)
-			model = models[tbl->value];
-		if (!model) {
-			sprintf(tmp, "#%d", tbl->value);
-			model = tmp;
-		}
-		codec_info(codec, "model '%s' is selected for config %x:%x (%s)\n",
-			   model, tbl->subvendor, tbl->subdevice,
-			   (tbl->name ? tbl->name : "Unknown device"));
-#endif
-		return tbl->value;
-	}
-	return -1;
-}
-EXPORT_SYMBOL_GPL(snd_hda_check_board_config);
-
-/**
- * snd_hda_check_board_codec_sid_config - compare the current codec
-					subsystem ID with the
-					config table
-
-	   This is important for Gateway notebooks with SB450 HDA Audio
-	   where the vendor ID of the PCI device is:
-		ATI Technologies Inc SB450 HDA Audio [1002:437b]
-	   and the vendor/subvendor are found only at the codec.
-
- * @codec: the HDA codec
- * @num_configs: number of config enums
- * @models: array of model name strings
- * @tbl: configuration table, terminated by null entries
- *
- * Compares the modelname or PCI subsystem id of the current codec with the
- * given configuration table.  If a matching entry is found, returns its
- * config value (supposed to be 0 or positive).
- *
- * If no entries are matching, the function returns a negative value.
- */
-int snd_hda_check_board_codec_sid_config(struct hda_codec *codec,
-			       int num_configs, const char * const *models,
-			       const struct snd_pci_quirk *tbl)
-{
-	const struct snd_pci_quirk *q;
-
-	/* Search for codec ID */
-	for (q = tbl; q->subvendor; q++) {
-		unsigned int mask = 0xffff0000 | q->subdevice_mask;
-		unsigned int id = (q->subdevice | (q->subvendor << 16)) & mask;
-		if ((codec->subsystem_id & mask) == id)
-			break;
-	}
-
-	if (!q->subvendor)
-		return -1;
-
-	tbl = q;
-
-	if (tbl->value >= 0 && tbl->value < num_configs) {
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-		char tmp[10];
-		const char *model = NULL;
-		if (models)
-			model = models[tbl->value];
-		if (!model) {
-			sprintf(tmp, "#%d", tbl->value);
-			model = tmp;
-		}
-		codec_info(codec, "model '%s' is selected for config %x:%x (%s)\n",
-			   model, tbl->subvendor, tbl->subdevice,
-			   (tbl->name ? tbl->name : "Unknown device"));
-#endif
-		return tbl->value;
-	}
-	return -1;
-}
-EXPORT_SYMBOL_GPL(snd_hda_check_board_codec_sid_config);
-
-/**
  * snd_hda_add_new_ctls - create controls from the array
  * @codec: the HDA codec
  * @knew: the array of struct snd_kcontrol_new
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 364bb413e02a..8a018d4cbe98 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -371,12 +371,6 @@ void snd_print_pcm_bits(int pcm, char *buf, int buflen);
 /*
  * Misc
  */
-int snd_hda_check_board_config(struct hda_codec *codec, int num_configs,
-			       const char * const *modelnames,
-			       const struct snd_pci_quirk *pci_list);
-int snd_hda_check_board_codec_sid_config(struct hda_codec *codec,
-                               int num_configs, const char * const *models,
-                               const struct snd_pci_quirk *tbl);
 int snd_hda_add_new_ctls(struct hda_codec *codec,
 			 const struct snd_kcontrol_new *knew);
 
-- 
2.0.4
