From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Define API to find a dai link" to the
	asoc tree
Date: Fri, 04 Nov 2016 11:23:19 -0600
Message-ID: <E1c2iD1-0006nZ-68@finisterre>
References: <0ad5001040470e6b87034b0cdb9b58bc73ff6a1b.1475127338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 969C7266623
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:23:46 +0100 (CET)
In-Reply-To: <0ad5001040470e6b87034b0cdb9b58bc73ff6a1b.1475127338.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Define API to find a dai link

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

>From 17fb175520e5497d71351aa66a125324fcb625a7 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:04:12 +0800
Subject: [PATCH] ASoC: Define API to find a dai link

Define the API to find an existing DAI link of the soc card by matching
the ID, name and stream name.

Some cards may use unique ID for each DAI link, so matching ID is enough,
and name or stream name are not necessary. But user need to specify name
or stream name as well if not sure whether link ID is unique since most
cards use 0 as the default link ID.

Topology can use this API to find an existing BE link and configure it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f1c784e44f6..c3a38ee2b006 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1671,6 +1671,9 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
+struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+					       int id, const char *name,
+					       const char *stream_name);
 
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd903261..a7a1ca40bcf5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -972,6 +972,48 @@ struct snd_soc_dai *snd_soc_find_dai(
 }
 EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
+
+/**
+ * snd_soc_find_dai_link - Find a DAI link
+ *
+ * @card: soc card
+ * @id: DAI link ID to match
+ * @name: DAI link name to match, optional
+ * @stream name: DAI link stream name to match, optional
+ *
+ * This function will search all existing DAI links of the soc card to
+ * find the link of the same ID. Since DAI links may not have their
+ * unique ID, so name and stream name should also match if being
+ * specified.
+ *
+ * Return: pointer of DAI link, or NULL if not found.
+ */
+struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
+					       int id, const char *name,
+					       const char *stream_name)
+{
+	struct snd_soc_dai_link *link, *_link;
+
+	lockdep_assert_held(&client_mutex);
+
+	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+		if (link->id != id)
+			continue;
+
+		if (name && (!link->name || strcmp(name, link->name)))
+			continue;
+
+		if (stream_name && (!link->stream_name
+			|| strcmp(stream_name, link->stream_name)))
+			continue;
+
+		return link;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_find_dai_link);
+
 static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
 {
-- 
2.10.1
