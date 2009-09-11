From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] add channel order map interface in asoc core
Date: Sat, 12 Sep 2009 01:16:29 +0800
Message-ID: <1252689389-11661-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E22B24720
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 19:16:45 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so7162fga.2
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2009 10:16:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch adds an interface to set the relationship between audio
channel number and slot number. The interface should be really useful
because audio channel n doesn't always use slot n in all platforms. And
for some devices, the relationship even can change with sound mode
switch in 2.1,3.1,4.1,5.1,6.1,7.1 etc.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 include/sound/soc-dai.h |    7 +++++++
 sound/soc/soc-core.c    |   24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 97ca9af..5c84566 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -114,6 +114,10 @@ int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
 
+int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
+	unsigned int tx_num, unsigned int *tx_slot,
+	unsigned int rx_num, unsigned int *rx_slot);
+
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 
 /* Digital Audio Interface mute */
@@ -148,6 +152,9 @@ struct snd_soc_dai_ops {
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
 		unsigned int tx_mask, unsigned int rx_mask,
 		int slots, int slot_width);
+	int (*set_channel_map)(struct snd_soc_dai *dai,
+		unsigned int tx_num, unsigned int *tx_slot,
+		unsigned int rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ff04ad..ba1f8e5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2251,6 +2251,30 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
 /**
+ * snd_soc_dai_set_channel_map - configure DAI audio channel map
+ * @dai: DAI
+ * @tx_num: how many TX channels
+ * @tx_slot: pointer to an array which imply the TX slot number channel
+ *           0~num-1 uses
+ * @rx_num: how many RX channels
+ * @rx_slot: pointer to an array which imply the RX slot number channel
+ *           0~num-1 uses
+ *
+ * configure the relationship between channel number and TDM slot number.
+ */
+int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
+	unsigned int tx_num, unsigned int *tx_slot,
+	unsigned int rx_num, unsigned int *rx_slot)
+{
+	if (dai->ops && dai->ops->set_tdm_slot)
+		return dai->ops->set_channel_map(dai, tx_num, tx_slot,
+			rx_num, rx_slot);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
+
+/**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
  * @tristate: tristate enable
-- 
1.5.6.3
