From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8955: Mark expected switch
	fall-through" to the asoc tree
Date: Thu,  2 Aug 2018 11:11:47 +0100 (BST)
Message-ID: <20180802101147.D7B2A1124241@debutante.sirena.org.uk>
References: <7d2ee577e6a132b8a29663ea11ca1e449d1951bd.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AE56267806
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 12:11:48 +0200 (CEST)
In-Reply-To: <7d2ee577e6a132b8a29663ea11ca1e449d1951bd.1533151956.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8955: Mark expected switch fall-through

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

>From 85e7e77079f3201799467803f6c8533a9921e32d Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 1 Aug 2018 14:51:18 -0500
Subject: [PATCH] ASoC: wm8955: Mark expected switch fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115047 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8955.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index ba44e3d6c1e0..cd204f79647d 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -686,6 +686,7 @@ static int wm8955_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif |= WM8955_LRP;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif |= 0x3;
 		break;
-- 
2.18.0
