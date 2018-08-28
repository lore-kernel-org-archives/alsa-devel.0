From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Change MCLK to 48Mhz" to the asoc
	tree
Date: Tue, 28 Aug 2018 21:27:06 +0100 (BST)
Message-ID: <20180828202706.D37BE440078@finisterre.ee.mobilebroadband>
References: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E0D902678CC
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:27:13 +0200 (CEST)
In-Reply-To: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Change MCLK to 48Mhz

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a1b1e9880f0c2754a5ac416a546d9f295f72eabc Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 21 Aug 2018 12:29:43 +0530
Subject: [PATCH] ASoC: AMD: Change MCLK to 48Mhz

25Mhz MCLK which was earlier used was of spread type.
Thus, we were not getting accurate rate. The 48Mhz system
clk is of non-spread type and we are changing to it to get
accurate rate.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 95c5701e2a30..3879cccbd2c0 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -42,7 +42,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 25000000
+#define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-- 
2.18.0
