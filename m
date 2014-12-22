From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Fix BYTCR machine driver
	MODULE_ALIAS
Date: Mon, 22 Dec 2014 16:49:20 +0200
Message-ID: <1419259760-19066-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1419259760-19066-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 331542605EC
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 15:49:28 +0100 (CET)
In-Reply-To: <1419259760-19066-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_sst_bytcr_dpcm_rt5640 doesn't autoload because MODULE_ALIAS doesn't
match with "bytt100_rt5640" platform device.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/bytcr_dpcm_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/bytcr_dpcm_rt5640.c b/sound/soc/intel/bytcr_dpcm_rt5640.c
index f5d0fc1ab10c..eef0c56ec32e 100644
--- a/sound/soc/intel/bytcr_dpcm_rt5640.c
+++ b/sound/soc/intel/bytcr_dpcm_rt5640.c
@@ -227,4 +227,4 @@ module_platform_driver(snd_byt_mc_driver);
 MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver");
 MODULE_AUTHOR("Subhransu S. Prusty <subhransu.s.prusty@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bytrt5640-audio");
+MODULE_ALIAS("platform:bytt100_rt5640");
-- 
2.1.3
