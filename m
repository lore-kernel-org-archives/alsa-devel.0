From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: hda - Return the created kcontrol in
	__snd_hda_add_vmaster()
Date: Mon, 12 Mar 2012 15:28:47 +0100
Message-ID: <1331562530-16044-3-git-send-email-tiwai@suse.de>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id AFF2B10425D
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:56 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 66688927A5
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:29:56 +0100 (CET)
In-Reply-To: <1331562530-16044-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It'll be used for adding hooks in later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c    |    9 ++++++++-
 sound/pci/hda/hda_local.h    |    7 ++++---
 sound/pci/hda/patch_analog.c |    2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0c0ac0e..b79ee34 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2399,6 +2399,7 @@ static int init_slave_unmute(void *data, struct snd_kcontrol *slave)
  * @slaves: slave control names (optional)
  * @suffix: suffix string to each slave name (optional)
  * @init_slave_vol: initialize slaves to unmute/0dB
+ * @ctl_ret: store the vmaster kcontrol in return
  *
  * Create a virtual master control with the given name.  The TLV data
  * must be either NULL or a valid data.
@@ -2411,11 +2412,15 @@ static int init_slave_unmute(void *data, struct snd_kcontrol *slave)
  */
 int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 			unsigned int *tlv, const char * const *slaves,
-			const char *suffix, bool init_slave_vol)
+			  const char *suffix, bool init_slave_vol,
+			  struct snd_kcontrol **ctl_ret)
 {
 	struct snd_kcontrol *kctl;
 	int err;
 
+	if (ctl_ret)
+		*ctl_ret = NULL;
+
 	err = map_slaves(codec, slaves, suffix, check_slave_present, NULL);
 	if (err != 1) {
 		snd_printdd("No slave found for %s\n", name);
@@ -2439,6 +2444,8 @@ int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 		map_slaves(codec, slaves, suffix,
 			   tlv ? init_slave_0dB : init_slave_unmute, kctl);
 
+	if (ctl_ret)
+		*ctl_ret = kctl;
 	return 0;
 }
 EXPORT_SYMBOL_HDA(__snd_hda_add_vmaster);
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index caa6468..c3ee4ed 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -140,10 +140,11 @@ void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
 struct snd_kcontrol *snd_hda_find_mixer_ctl(struct hda_codec *codec,
 					    const char *name);
 int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
-			unsigned int *tlv, const char * const *slaves,
-			const char *suffix, bool init_slave_vol);
+			  unsigned int *tlv, const char * const *slaves,
+			  const char *suffix, bool init_slave_vol,
+			  struct snd_kcontrol **ctl_ret);
 #define snd_hda_add_vmaster(codec, name, tlv, slaves, suffix) \
-	__snd_hda_add_vmaster(codec, name, tlv, slaves, suffix, true)
+	__snd_hda_add_vmaster(codec, name, tlv, slaves, suffix, true, NULL)
 int snd_hda_codec_reset(struct hda_codec *codec);
 
 /* amp value bits */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index fa97a0c..7143393 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -229,7 +229,7 @@ static int ad198x_build_controls(struct hda_codec *codec)
 					  (spec->slave_vols ?
 					   spec->slave_vols : ad_slave_pfxs),
 					  "Playback Volume",
-					  !spec->avoid_init_slave_vol);
+					  !spec->avoid_init_slave_vol, NULL);
 		if (err < 0)
 			return err;
 	}
-- 
1.7.9.2
