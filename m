From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added software reset register
	to readable registers" to the asoc tree
Date: Wed,  8 Aug 2018 12:07:47 +0100 (BST)
Message-ID: <20180808110747.7170C1124340@debutante.sirena.org.uk>
References: <20180808030638.8085-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B259C2678DA
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 13:07:51 +0200 (CEST)
In-Reply-To: <20180808030638.8085-1-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added software reset register to readable registers

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

>From 0717edbdfed61b4c1e8291140f78882d3a481042 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Tue, 7 Aug 2018 20:06:38 -0700
Subject: [PATCH] ASoC: max98373: Added software reset register to readable
 registers

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a92586106932..92b7125ea169 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -488,6 +488,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
 static bool max98373_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MAX98373_R2000_SW_RESET:
 	case MAX98373_R2001_INT_RAW1 ... MAX98373_R200C_INT_EN3:
 	case MAX98373_R2010_IRQ_CTRL:
 	case MAX98373_R2014_THERM_WARN_THRESH
-- 
2.18.0
