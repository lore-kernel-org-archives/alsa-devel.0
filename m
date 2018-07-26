From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine: Use standard
	pcm_format_to_bits() macro" to the asoc tree
Date: Thu, 26 Jul 2018 17:11:12 +0100 (BST)
Message-ID: <20180726161112.4F75744007A@finisterre.ee.mobilebroadband>
References: <20180725211722.18944-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A86926779F
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:42 +0200 (CEST)
In-Reply-To: <20180725211722.18944-7-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine: Use standard pcm_format_to_bits() macro

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

>From 8adf3df4156345f1edcdfa8c7f7beeb0de351ce2 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 23:17:22 +0200
Subject: [PATCH] ASoC: dmaengine: Use standard pcm_format_to_bits() macro

The conversion from PCM format type to bits needs an explicit cast,
and it'll be uglier.  Since we have a standard macro for that, let's
use it instead.

This patch fixes the sparse warning:
  sound/soc/soc-generic-dmaengine-pcm.c:200:63: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 120f7b39e256..52fd7af952a5 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -188,7 +188,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 			case 32:
 			case 64:
 				if (addr_widths & (1 << (bits / 8)))
-					hw.formats |= (1LL << i);
+					hw.formats |= pcm_format_to_bits(i);
 				break;
 			default:
 				/* Unsupported types */
-- 
2.18.0
