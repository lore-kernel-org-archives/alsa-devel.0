From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add the type for BE DAI
	link" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:48 +0100
Message-ID: <E1Zi3u0-00084I-Vn@finisterre>
References: <68a98c1c67380b058865fa8e8cb05e2377b30f14.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F111E261294
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:54 +0200 (CEST)
In-Reply-To: <68a98c1c67380b058865fa8e8cb05e2377b30f14.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add the type for BE DAI link

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

>From 7c545b327d54cdc3f693093f744459f6e0d8ce58 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 30 Sep 2015 17:32:04 +0800
Subject: [PATCH] ASoC: topology: ABI - Add the type for BE DAI link

Define the topology type for BE DAI link: SND_SOC_TPLG_TYPE_BACKEND_LINK.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index eeb74a9c..f75fd29 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -103,7 +103,8 @@
 #define SND_SOC_TPLG_TYPE_PCM		7
 #define SND_SOC_TPLG_TYPE_MANIFEST	8
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
-#define SND_SOC_TPLG_TYPE_PDATA		10
+#define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
+#define SND_SOC_TPLG_TYPE_PDATA		11
 #define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
 
 /* vendor block IDs - please add new vendor types to end */
-- 
2.5.0
