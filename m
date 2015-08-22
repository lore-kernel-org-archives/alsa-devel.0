From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Bind vendor specific kcontrol
	handlers before standard ones" to the asoc tree
Date: Sat, 22 Aug 2015 08:55:31 -0700
Message-ID: <E1ZTB8l-0000RY-6m@finisterre>
References: <c16322a038d8b6ccd9f5235cfea2c28b81a90c5d.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A53226047E
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 17:55:44 +0200 (CEST)
In-Reply-To: <c16322a038d8b6ccd9f5235cfea2c28b81a90c5d.1439892263.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Bind vendor specific kcontrol handlers before standard ones

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

>From 88a17d8fb7c4a156ec13e6668b46dbbedf670ff7 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Tue, 18 Aug 2015 18:11:51 +0800
Subject: [PATCH] ASoC: topology: Bind vendor specific kcontrol handlers before
 standard ones

Vendor specific handlers should override standard handlers. So we can
handle things in the order from specific to generic.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h |  2 +-
 sound/soc/soc-topology.c     | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 865a141..a6541a1 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -136,7 +136,7 @@ struct snd_soc_tplg_ops {
 	int (*manifest)(struct snd_soc_component *,
 		struct snd_soc_tplg_manifest *);
 
-	/* bespoke kcontrol handlers available for binding */
+	/* vendor specific kcontrol handlers available for binding */
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
 };
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 73e959c..ca551b9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -66,7 +66,7 @@ struct soc_tplg {
 	u32 index;	/* current block index */
 	u32 req_index;	/* required index, only loaded/free matching blocks */
 
-	/* kcontrol operations */
+	/* vendor specific kcontrol operations */
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
 
@@ -513,22 +513,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 {
 	int i;
 
-	/* try and map standard kcontrols handler first */
-	for (i = 0; i < num_ops; i++) {
-
-		if (ops[i].id == hdr->ops.put)
-			k->put = ops[i].put;
-		if (ops[i].id == hdr->ops.get)
-			k->get = ops[i].get;
-		if (ops[i].id == hdr->ops.info)
-			k->info = ops[i].info;
-	}
-
-	/* standard handlers found ? */
-	if (k->put && k->get && k->info)
-		return 0;
-
-	/* none found so try bespoke handlers */
+	/* try and map vendor specific kcontrol handlers first */
 	for (i = 0; i < num_bops; i++) {
 
 		if (k->put == NULL && bops[i].id == hdr->ops.put)
@@ -539,7 +524,22 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 			k->info = bops[i].info;
 	}
 
-	/* bespoke handlers found ? */
+	/* vendor specific handlers found ? */
+	if (k->put && k->get && k->info)
+		return 0;
+
+	/* none found so try standard kcontrol handlers */
+	for (i = 0; i < num_ops; i++) {
+
+		if (k->put == NULL && ops[i].id == hdr->ops.put)
+			k->put = ops[i].put;
+		if (k->get == NULL && ops[i].id == hdr->ops.get)
+			k->get = ops[i].get;
+		if (k->info == NULL && ops[i].id == hdr->ops.info)
+			k->info = ops[i].info;
+	}
+
+	/* standard handlers found ? */
 	if (k->put && k->get && k->info)
 		return 0;
 
-- 
2.5.0
