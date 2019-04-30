From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/19] ASoC: SOF: topology: add support for
	stricter ABI checks
Date: Tue, 30 Apr 2019 18:09:18 -0500
Message-ID: <20190430230934.4321-4-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0368F896AA
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:57 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fail early if topology is more recent than kernel and Kconfig is
selected.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 43 ++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 2b9de1b97447..b04b99cc0ff8 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3051,6 +3051,7 @@ static int sof_manifest(struct snd_soc_component *scomp, int index,
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	u32 size;
+	u32 abi_version;
 
 	size = le32_to_cpu(man->priv.size);
 
@@ -3060,20 +3061,36 @@ static int sof_manifest(struct snd_soc_component *scomp, int index,
 		return 0;
 	}
 
-	if (size == SOF_TPLG_ABI_SIZE) {
-		dev_info(sdev->dev,
-			 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
-			 man->priv.data[0], man->priv.data[1],
-			 man->priv.data[2], SOF_ABI_MAJOR, SOF_ABI_MINOR,
-			 SOF_ABI_PATCH);
-		if (SOF_ABI_VER(man->priv.data[0], man->priv.data[1],
-				man->priv.data[2]) <= SOF_ABI_VERSION)
-			return 0;
+	if (size != SOF_TPLG_ABI_SIZE) {
+		dev_err(sdev->dev, "error: invalid topology ABI size\n");
+		return -EINVAL;
 	}
-	dev_err(sdev->dev,
-		"error: Incompatible ABI version %d:%d:%d\n",
-		man->priv.data[0], man->priv.data[1], man->priv.data[2]);
-	return -EINVAL;
+
+	dev_info(sdev->dev,
+		 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
+		 man->priv.data[0], man->priv.data[1],
+		 man->priv.data[2], SOF_ABI_MAJOR, SOF_ABI_MINOR,
+		 SOF_ABI_PATCH);
+
+	abi_version = SOF_ABI_VER(man->priv.data[0],
+				  man->priv.data[1],
+				  man->priv.data[2]);
+
+	if (SOF_ABI_VERSION_INCOMPATIBLE(SOF_ABI_VERSION, abi_version)) {
+		dev_err(sdev->dev, "error: incompatible topology ABI version\n");
+		return -EINVAL;
+	}
+
+	if (abi_version > SOF_ABI_VERSION) {
+		if (!IS_ENABLED(CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS)) {
+			dev_warn(sdev->dev, "warn: topology ABI is more recent than kernel\n");
+		} else {
+			dev_err(sdev->dev, "error: topology ABI is more recent than kernel\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
 }
 
 /* vendor specific kcontrol handlers available for binding */
-- 
2.17.1
