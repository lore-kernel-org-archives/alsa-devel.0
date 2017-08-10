From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add snd_soc_rtdcom_xxx()" to
	the asoc tree
Date: Thu, 10 Aug 2017 16:41:53 +0100
Message-ID: <E1dfpar-0001dp-8a@finisterre>
References: <87shh2lhbx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 03B942665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 17:42:04 +0200 (CEST)
In-Reply-To: <87shh2lhbx.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add snd_soc_rtdcom_xxx()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a0ac441152238c9b474bafa46940511d9b2e9c7e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Aug 2017 06:17:47 +0000
Subject: [PATCH] ASoC: soc-core: add snd_soc_rtdcom_xxx()

Current snd_soc_pcm_runtime has platform / codec pointers, and we could
use these specific pointer. But these will be replaced to more generic
"component" soon, and will need more generic method to get each
connected component pointer from rtd.

This patch adds new snd_soc_rtdcom_xxx() to connect/disconnect
component to rtd. It means same as previous "platform" / "codec"
pointer style, but more generic.
We can find necessary component pointer from rtd by using component
driver name on snd_soc_rtdcom_lookup().

Here, the reason why it uses "driver name" is that "component name"
was created by fmt_single_name() and difficult to use it from driver.
Driver of course knows its "driver name", thus, using it is more easy.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 13 +++++++++++++
 sound/soc/soc-core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index aad3f14966f1..87dbe39797ca 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -886,6 +886,18 @@ struct snd_soc_component {
 #endif
 };
 
+struct snd_soc_rtdcom_list {
+	struct snd_soc_component *component;
+	struct list_head list; /* rtd::component_list */
+};
+struct snd_soc_component*
+snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
+		       const char *driver_name);
+#define for_each_rtdcom(rtd, rtdcom) \
+	list_for_each_entry(rtdcom, &(rtd)->component_list, list)
+#define for_each_rtdcom_safe(rtd, rtdcom1, rtdcom2) \
+	list_for_each_entry_safe(rtdcom1, rtdcom2, &(rtd)->component_list, list)
+
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	struct device *dev;
@@ -1240,6 +1252,7 @@ struct snd_soc_pcm_runtime {
 
 	unsigned int num; /* 0-based and monotonic increasing */
 	struct list_head list; /* rtd list of the soc card */
+	struct list_head component_list; /* list of connected components */
 
 	/* bit field */
 	unsigned int dev_registered:1;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 07d708498500..c2462e0f0f0d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -551,6 +551,54 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
+static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
+			      struct snd_soc_component *component)
+{
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_rtdcom_list *new_rtdcom;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		/* already connected */
+		if (rtdcom->component == component)
+			return 0;
+	}
+
+	new_rtdcom = kmalloc(sizeof(*new_rtdcom), GFP_KERNEL);
+	if (!new_rtdcom)
+		return -ENOMEM;
+
+	new_rtdcom->component = component;
+	INIT_LIST_HEAD(&new_rtdcom->list);
+
+	list_add_tail(&new_rtdcom->list, &rtd->component_list);
+
+	return 0;
+}
+
+static void snd_soc_rtdcom_del_all(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_rtdcom_list *rtdcom1, *rtdcom2;
+
+	for_each_rtdcom_safe(rtd, rtdcom1, rtdcom2)
+		kfree(rtdcom1);
+
+	INIT_LIST_HEAD(&rtd->component_list);
+}
+
+struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
+						const char *driver_name)
+{
+	struct snd_soc_rtdcom_list *rtdcom;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		if ((rtdcom->component->driver->name == driver_name) ||
+		    strcmp(rtdcom->component->driver->name, driver_name) == 0)
+			return rtdcom->component;
+	}
+
+	return NULL;
+}
+
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream)
 {
@@ -575,6 +623,7 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	if (!rtd)
 		return NULL;
 
+	INIT_LIST_HEAD(&rtd->component_list);
 	rtd->card = card;
 	rtd->dai_link = dai_link;
 	rtd->codec_dais = kzalloc(sizeof(struct snd_soc_dai *) *
@@ -592,6 +641,7 @@ static void soc_free_pcm_runtime(struct snd_soc_pcm_runtime *rtd)
 {
 	if (rtd && rtd->codec_dais)
 		kfree(rtd->codec_dais);
+	snd_soc_rtdcom_del_all(rtd);
 	kfree(rtd);
 }
 
-- 
2.13.2
