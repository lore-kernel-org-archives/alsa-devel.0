From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Change pass number of DAI
	smaller than graph" to the asoc tree
Date: Fri, 14 Aug 2015 19:13:19 -0700
Message-ID: <E1ZQQyF-0004I6-CU@finisterre>
References: <1439187223-1285-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D94EF2665B2
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:24 +0200 (CEST)
In-Reply-To: <1439187223-1285-1-git-send-email-mengdong.lin@intel.com>
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

   ASoC: topology: Change pass number of DAI smaller than graph

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

>From 1a8e7fab70c8d7cad2e606e7b21d46e42e51c2fd Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Mon, 10 Aug 2015 22:48:30 +0800
Subject: [PATCH] ASoC: topology: Change pass number of DAI smaller than graph

The PCM DAIs need to be loaded and added to ASoC core ealier than the
graph (route). Otherwise, adding routes will fail for missing DAIs.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8620dbf..942c1ac 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -44,12 +44,12 @@
 #define SOC_TPLG_PASS_VENDOR		1
 #define SOC_TPLG_PASS_MIXER		2
 #define SOC_TPLG_PASS_WIDGET		3
-#define SOC_TPLG_PASS_GRAPH		4
-#define SOC_TPLG_PASS_PINS		5
-#define SOC_TPLG_PASS_PCM_DAI		6
+#define SOC_TPLG_PASS_PCM_DAI		4
+#define SOC_TPLG_PASS_GRAPH		5
+#define SOC_TPLG_PASS_PINS		6
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PCM_DAI
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PINS
 
 struct soc_tplg {
 	const struct firmware *fw;
-- 
2.5.0
