From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sof-rt5682: fix AMP quirk
	support" to the asoc tree
Date: Tue, 21 May 2019 21:32:41 +0100 (BST)
Message-ID: <20190521203241.3EB451126D18@debutante.sirena.org.uk>
References: <20190520194645.432-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9749DF89723
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:49 +0200 (CEST)
In-Reply-To: <20190520194645.432-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sof-rt5682: fix AMP quirk support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From df9366131a452296d040a7a496d93108f1fc240c Mon Sep 17 00:00:00 2001
From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Date: Mon, 20 May 2019 14:46:42 -0500
Subject: [PATCH] ASoC: Intel: sof-rt5682: fix AMP quirk support

The use of BIT/GENMASK was incorrect, fix.

Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 39ddefec4991..3343dbcd506f 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -29,9 +29,10 @@
 #define SOF_RT5682_MCLK_EN			BIT(3)
 #define SOF_RT5682_MCLK_24MHZ			BIT(4)
 #define SOF_SPEAKER_AMP_PRESENT		BIT(5)
-#define SOF_RT5682_SSP_AMP(quirk)		((quirk) & GENMASK(8, 6))
-#define SOF_RT5682_SSP_AMP_MASK			(GENMASK(8, 6))
 #define SOF_RT5682_SSP_AMP_SHIFT		6
+#define SOF_RT5682_SSP_AMP_MASK                 (GENMASK(8, 6))
+#define SOF_RT5682_SSP_AMP(quirk)	\
+	(((quirk) << SOF_RT5682_SSP_AMP_SHIFT) & SOF_RT5682_SSP_AMP_MASK)
 
 /* Default: MCLK on, MCLK 19.2M, SSP0  */
 static unsigned long sof_rt5682_quirk = SOF_RT5682_MCLK_EN |
-- 
2.20.1
