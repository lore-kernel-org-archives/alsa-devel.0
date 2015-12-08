From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Define add/remove_dai_link ops for a
	soc card" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:17 +0000
Message-ID: <E1a6NfR-0003zB-HD@debutante>
References: <a7aecce7622d5206339f18e43521da8e46d43445.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED7A826062B
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:22 +0100 (CET)
In-Reply-To: <a7aecce7622d5206339f18e43521da8e46d43445.1449036307.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Define add/remove_dai_link ops for a soc card

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

>From d6f220ea13edfd3430fb42e09ff92e321ffb5762 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 2 Dec 2015 14:11:32 +0800
Subject: [PATCH] ASoC: Define add/remove_dai_link ops for a soc card

A machine driver can register the two ops.

When a DAI link is added or removed by a component's topology, the
ASoC core can call the ops to notify the machine driver for extra
intialization or destruction.

E.g. topology can create FE DAI links from a cpu DAI component, and
the machine driver may define an add_dai_link ops to set machine-specific
.init ops for the DAI link.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 410cb0b422be..af347bcdc2f6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1104,6 +1104,11 @@ struct snd_soc_card {
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
 
+	int (*add_dai_link)(struct snd_soc_card *,
+			    struct snd_soc_dai_link *link);
+	void (*remove_dai_link)(struct snd_soc_card *,
+			    struct snd_soc_dai_link *link);
+
 	long pmdown_time;
 
 	/* CPU <--> Codec DAI links  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bf4bccfc4b91..094856fa8cec 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1260,6 +1260,12 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
+	/* Notify the machine driver for extra initialization
+	 * on the link created by topology.
+	 */
+	if (dai_link->dobj.type && card->add_dai_link)
+		card->add_dai_link(card, dai_link);
+
 	list_add_tail(&dai_link->list, &card->dai_link_list);
 	card->num_dai_links++;
 
@@ -1290,6 +1296,12 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
+	/* Notify the machine driver for extra destruction
+	 * on the link created by topology.
+	 */
+	if (dai_link->dobj.type && card->remove_dai_link)
+		card->remove_dai_link(card, dai_link);
+
 	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
 		if (link == dai_link) {
 			list_del(&link->list);
-- 
2.6.2
