From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: SOF: core: fix undefined nocodec
	reference
Date: Tue,  7 May 2019 11:32:36 -0500
Message-ID: <20190507163236.8783-3-pierre-louis.bossart@linux.intel.com>
References: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49F8FF80726
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 18:32:46 +0200 (CEST)
In-Reply-To: <20190507163236.8783-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, kbuild-all@01.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The existing code mistakenly uses IS_ENABLED in C code instead of as
in conditional compilation, leading to the following error:

ld: sound/soc/sof/core.o: in function `sof_machine_check':
sound/soc/sof/core.c:279: undefined reference to `sof_nocodec_setup'

Fix by using #if !IS_ENABLED()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 39cbd84ff9c8..5ddbfa8f1a28 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -265,11 +265,10 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
 	if (plat_data->machine)
 		return 0;
 
-	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)) {
-		dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
-		return -ENODEV;
-	}
-
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
+	dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
+	return -ENODEV;
+#else
 	/* fallback to nocodec mode */
 	dev_warn(sdev->dev, "No ASoC machine driver found - using nocodec\n");
 	machine = devm_kzalloc(sdev->dev, sizeof(*machine), GFP_KERNEL);
@@ -284,6 +283,7 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
 	plat_data->machine = machine;
 
 	return 0;
+#endif
 }
 
 static int sof_probe_continue(struct snd_sof_dev *sdev)
-- 
2.17.1
