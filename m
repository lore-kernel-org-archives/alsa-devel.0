From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] add channel order setting interface in asoc
	core
Date: Fri, 11 Sep 2009 17:03:42 +0800
Message-ID: <1252659822-12915-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id A17FD1037F3
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 11:02:51 +0200 (CEST)
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

Hi Mark,
As discussed, I am adding a patch to add an interface to set the
relationship between audio channel No. and slot No.
The interface should be really useful because nobody can ensure
audio channel n always uses slot n in all platforms. And for some
devices, the relationship even can change with sound mode switch
in 2.1,3.1,4.1,5.1,6.1,7.1.
After the patch is applied, I can change bfin stuff based on it.
Thanks,
Barry

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 include/sound/soc-dai.h |    5 +++++
 sound/soc/soc-core.c    |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 97ca9af..7439425 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -114,6 +114,9 @@ int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
 
+int snd_soc_dai_set_channel_order(struct snd_soc_dai *dai,
+	unsigned int num, unsigned int *slot);
+
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 
 /* Digital Audio Interface mute */
@@ -148,6 +151,8 @@ struct snd_soc_dai_ops {
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
 		unsigned int tx_mask, unsigned int rx_mask,
 		int slots, int slot_width);
+	int (*set_channel_order)(struct snd_soc_dai *dai,
+		unsigned int num, unsigned int *slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7ff04ad..30d0143 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2251,6 +2251,24 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
 /**
+ * snd_soc_dai_set_channel_order - configure DAI audio channel order
+ * @dai: DAI
+ * @num: how many channels
+ * @slot: pointer to an array which imply the slot number channel 0~num-1 uses
+ *
+ * configure the relationship between channel number and TDM slot number.
+ */
+int snd_soc_dai_set_channel_order(struct snd_soc_dai *dai,
+		unsigned int num, unsigned int *slot)
+{
+	if (dai->ops && dai->ops->set_tdm_slot)
+		return dai->ops->set_channel_order(dai, num, slot);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_order);
+
+/**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
  * @tristate: tristate enable
-- 
1.5.6.3
