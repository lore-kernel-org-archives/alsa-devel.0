From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v2 07/11] ALSA: hda: add new API
	snd_hda_asoc_codec_new for ASoC codec drivers
Date: Mon, 11 Dec 2017 16:22:59 +0530
Message-ID: <1512989583-10877-8-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B37B267556
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 11:48:50 +0100 (CET)
In-Reply-To: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add API snd_hda_asoc_codec_new, to be called by generic ASoC codec
driver to create the hda_codec instance.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_codec.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_codec.h |   2 +
 2 files changed, 102 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 085fd9e..215b04d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -965,6 +965,106 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_new);
 
+/*
+ * FIXME:
+ * This function is very simillar to snd_hda_codec_new, but requires
+ * some special change for ASoC based codec drivers.
+ * Both functions can be combined into one.
+ */
+int snd_hda_asoc_codec_new(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec **codecp)
+{
+	struct hda_codec *codec = NULL;
+	hda_nid_t fg;
+	int err;
+	static struct snd_device_ops dev_ops = {
+		.dev_register = snd_hda_codec_dev_register,
+		.dev_disconnect = snd_hda_codec_dev_disconnect,
+		.dev_free = snd_hda_codec_dev_free,
+	};
+	struct snd_device *snd_dev;
+
+	if (snd_BUG_ON(!codecp))
+		return -EINVAL;
+	if (snd_BUG_ON(!bus))
+		return -EINVAL;
+	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
+		return -EINVAL;
+
+	codec = *codecp;
+
+	codec->core.exec_verb = codec_exec_verb;
+	codec->bus = bus;
+	codec->card = card;
+	codec->addr = codec_addr;
+	mutex_init(&codec->spdif_mutex);
+	mutex_init(&codec->control_mutex);
+	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
+	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
+	snd_array_init(&codec->init_pins, sizeof(struct hda_pincfg), 16);
+	snd_array_init(&codec->driver_pins, sizeof(struct hda_pincfg), 16);
+	snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);
+	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
+	snd_array_init(&codec->jacktbl, sizeof(struct hda_jack_tbl), 16);
+	snd_array_init(&codec->verbs, sizeof(struct hda_verb *), 8);
+	INIT_LIST_HEAD(&codec->conn_list);
+	INIT_LIST_HEAD(&codec->pcm_list_head);
+
+	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
+	codec->depop_delay = -1;
+	codec->fixup_id = HDA_FIXUP_ID_NOT_SET;
+
+#ifdef CONFIG_PM
+	codec->power_jiffies = jiffies;
+#endif
+
+	if (codec->bus->modelname) {
+		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
+		if (!codec->modelname) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	fg = codec->core.afg ? codec->core.afg : codec->core.mfg;
+	err = read_widget_caps(codec, fg);
+	if (err < 0)
+		goto error;
+
+	err = read_pin_defaults(codec);
+	if (err < 0)
+		goto error;
+
+	/* power-up all before initialization */
+	hda_set_power_state(codec, AC_PWRST_D0);
+
+	snd_hda_codec_proc_new(codec);
+
+	snd_hda_create_hwdep(codec);
+
+	err = snd_device_new(card, SNDRV_DEV_CODEC, codec, &dev_ops);
+	if (err < 0)
+		goto error;
+
+	list_for_each_entry(snd_dev, &card->devices, list) {
+		if (snd_dev->type == SNDRV_DEV_CODEC) {
+			void *device_data = snd_dev->device_data;
+
+			err = snd_device_register(card, device_data);
+			if (err < 0)
+				dev_err(bus->core.dev,
+				"device_register_all failed err = %d\n", err);
+		}
+	}
+
+	return 0;
+
+error:
+	put_device(hda_codec_dev(codec));
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hda_asoc_codec_new);
+
 /**
  * snd_hda_codec_update_widgets - Refresh widget caps and pin defaults
  * @codec: the HDA codec
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index d3099db..d863092 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -307,6 +307,8 @@ struct hda_codec {
  */
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp);
+int snd_hda_asoc_codec_new(struct hda_bus *bus, struct snd_card *card,
+		      unsigned int codec_addr, struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
 int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
-- 
2.7.4
