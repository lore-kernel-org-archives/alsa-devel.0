From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/9] ALSA: hda - Implement unbind more safely
Date: Fri, 27 Feb 2015 23:55:42 +0100
Message-ID: <1425077744-4553-8-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E93A52651A3
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 67093ABF6
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
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

Now we have all pieces ready, and put them into places:
- add the hda_pcm refcount to azx_pcm_open() and azx_pcm_close(),
- call the most of cleanup code in hda_codec_reset() from the codec
  driver remove,
- call the same code also from the hda_codec object free.

Then the codec driver can be unbound more safely now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c       |  3 +--
 sound/pci/hda/hda_codec.c      | 61 ++++++++++++++++++++++--------------------
 sound/pci/hda/hda_codec.h      |  1 +
 sound/pci/hda/hda_controller.c |  3 +++
 sound/pci/hda/hda_local.h      |  1 +
 5 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d0d5aead3746..114320864cea 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -130,8 +130,7 @@ static int hda_codec_driver_remove(struct device *dev)
 
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
-	codec->preset = NULL;
-	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	snd_hda_codec_cleanup_for_unbind(codec);
 	snd_hda_regmap_exit(codec);
 	module_put(dev->driver->owner);
 	return 0;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a8082677373e..a87b247a172a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1174,36 +1174,57 @@ struct hda_pcm *snd_hda_codec_pcm_new(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_pcm_new);
 
+/*
+ * codec destructor
+ */
 static void codec_release_pcms(struct hda_codec *codec)
 {
 	struct hda_pcm *pcm, *n;
 
 	list_for_each_entry_safe(pcm, n, &codec->pcm_list_head, list) {
 		list_del_init(&pcm->list);
+		if (pcm->pcm)
+			snd_device_disconnect(codec->card, pcm->pcm);
 		snd_hda_codec_pcm_put(pcm);
 	}
 }
 
-/*
- * codec destructor
- */
+void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec)
+{
+	cancel_delayed_work_sync(&codec->jackpoll_work);
+	flush_workqueue(codec->bus->workq);
+	if (!codec->in_freeing)
+		snd_hda_ctls_clear(codec);
+	codec_release_pcms(codec);
+	snd_hda_detach_beep_device(codec);
+	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	snd_hda_jack_tbl_clear(codec);
+	codec->proc_widget_hook = NULL;
+	codec->spec = NULL;
+
+	/* free only driver_pins so that init_pins + user_pins are restored */
+	snd_array_free(&codec->driver_pins);
+	snd_array_free(&codec->cvt_setups);
+	snd_array_free(&codec->spdif_out);
+	snd_array_free(&codec->verbs);
+	codec->preset = NULL;
+	codec->slave_dig_outs = NULL;
+	codec->spdif_status_reset = 0;
+	snd_array_free(&codec->mixers);
+	snd_array_free(&codec->nids);
+	remove_conn_list(codec);
+}
+
 static void snd_hda_codec_free(struct hda_codec *codec)
 {
 	if (!codec)
 		return;
-	cancel_delayed_work_sync(&codec->jackpoll_work);
-	codec_release_pcms(codec);
+	codec->in_freeing = 1;
 	if (device_is_registered(hda_codec_dev(codec)))
 		device_del(hda_codec_dev(codec));
-	snd_hda_jack_tbl_clear(codec);
 	free_init_pincfgs(codec);
 	flush_workqueue(codec->bus->workq);
 	list_del(&codec->list);
-	snd_array_free(&codec->mixers);
-	snd_array_free(&codec->nids);
-	snd_array_free(&codec->cvt_setups);
-	snd_array_free(&codec->spdif_out);
-	remove_conn_list(codec);
 	codec->bus->caddr_tbl[codec->addr] = NULL;
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 	snd_hda_sysfs_clear(codec);
@@ -2198,27 +2219,9 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 		return -EBUSY;
 
 	/* OK, let it free */
-	cancel_delayed_work_sync(&codec->jackpoll_work);
-	flush_workqueue(bus->workq);
-	snd_hda_ctls_clear(codec);
-	codec_release_pcms(codec);
-	snd_hda_detach_beep_device(codec);
 	if (device_is_registered(hda_codec_dev(codec)))
 		device_del(hda_codec_dev(codec));
 
-	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
-	snd_hda_jack_tbl_clear(codec);
-	codec->proc_widget_hook = NULL;
-	codec->spec = NULL;
-	/* free only driver_pins so that init_pins + user_pins are restored */
-	snd_array_free(&codec->driver_pins);
-	snd_array_free(&codec->cvt_setups);
-	snd_array_free(&codec->spdif_out);
-	snd_array_free(&codec->verbs);
-	codec->preset = NULL;
-	codec->slave_dig_outs = NULL;
-	codec->spdif_status_reset = 0;
-
 	/* allow device access again */
 	snd_hda_unlock_devices(bus);
 	return 0;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 5a9b04873655..07001797cece 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -328,6 +328,7 @@ struct hda_codec {
 #endif
 
 	/* misc flags */
+	unsigned int in_freeing:1; /* being released */
 	unsigned int spdif_status_reset :1; /* needs to toggle SPDIF for each
 					     * status change
 					     * (e.g. Realtek codecs)
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ad85f9bfaf57..cae50d5ffb81 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -420,6 +420,7 @@ static int azx_pcm_close(struct snd_pcm_substream *substream)
 		hinfo->ops.close(hinfo, apcm->codec, substream);
 	snd_hda_power_down(apcm->codec);
 	mutex_unlock(&chip->open_mutex);
+	snd_hda_codec_pcm_put(apcm->info);
 	return 0;
 }
 
@@ -806,6 +807,7 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	int err;
 	int buff_step;
 
+	snd_hda_codec_pcm_get(apcm->info);
 	mutex_lock(&chip->open_mutex);
 	azx_dev = azx_assign_device(chip, substream);
 	if (azx_dev == NULL) {
@@ -887,6 +889,7 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	snd_hda_power_down(apcm->codec);
  unlock:
 	mutex_unlock(&chip->open_mutex);
+	snd_hda_codec_pcm_put(apcm->info);
 	return err;
 }
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 0da5796b4690..4aefed9684c2 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -150,6 +150,7 @@ int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 #define snd_hda_add_vmaster(codec, name, tlv, slaves, suffix) \
 	__snd_hda_add_vmaster(codec, name, tlv, slaves, suffix, true, NULL)
 int snd_hda_codec_reset(struct hda_codec *codec);
+void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec);
 
 enum {
 	HDA_VMUTE_OFF,
-- 
2.3.0
