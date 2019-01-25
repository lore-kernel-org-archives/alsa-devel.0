From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/15] ASoC: add helper to change platform name
	for all dailinks
Date: Fri, 25 Jan 2019 14:34:55 -0600
Message-ID: <20190125203509.22994-2-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1EA267350
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:15 +0100 (CET)
In-Reply-To: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

To reuse the same machine drivers with Atom/SST, Skylake and SOF, we
need to change the default platform_name (or platforms->name in the
"modern" representation).

So far, this override was done with an automatic override, which was
broken by a set of changes for DT platforms related to deferred probe
handling.

This automatic override is actually not really needed, the machine
driver can already receive the platform name as a platform_data
parameter. This is used e.g. for HDaudio support where we have
different PCI aliases used for different platforms. We can reuse the
same mechanism and modify the machine drivers to override the dailinks
prior to registrating the card.

This will require additional work for SOF, but with this helper it'll
be just two lines of additional code per machine driver which is
reused, not the end of the world.

This helper can be simplified when all drivers have transitioned to
the "modern" representation of dailinks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3089257ead95..95689680336b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1580,6 +1580,37 @@ struct snd_soc_dai *snd_soc_card_get_codec_dai(struct snd_soc_card *card,
 	return NULL;
 }
 
+static inline
+int snd_soc_fixup_dai_links_platform_name(struct snd_soc_card *card,
+					  const char *platform_name)
+{
+	struct snd_soc_dai_link *dai_link;
+	const char *name;
+	int i;
+
+	if (!platform_name) /* nothing to do */
+		return 0;
+
+	/* set platform name for each dailink */
+	for_each_card_prelinks(card, i, dai_link) {
+		name = devm_kstrdup(card->dev, platform_name, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+
+		if (dai_link->platforms)
+			/* only single platform is supported for now */
+			dai_link->platforms->name = name;
+		else
+			/*
+			 * legacy mode, this case will be removed when all
+			 * derivers are switched to modern style dai_link.
+			 */
+			dai_link->platform_name = name;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *snd_soc_debugfs_root;
 #endif
-- 
2.17.1
