From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Mark expected switch
	fall-through" to the asoc tree
Date: Thu,  2 Aug 2018 11:12:06 +0100 (BST)
Message-ID: <20180802101206.185311124241@debutante.sirena.org.uk>
References: <797d14078a5e024360e27285f5f61d6319041d21.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C460B2677FC
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 12:12:06 +0200 (CEST)
In-Reply-To: <797d14078a5e024360e27285f5f61d6319041d21.1533151956.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Mark expected switch fall-through

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

>From 065dcc270af66acb4226b49f635b41a054b663d4 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 1 Aug 2018 14:49:13 -0500
Subject: [PATCH] ASoC: rt5640: Mark expected switch fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1056547 ("Missing break in switch")
Addresses-Coverity-ID: 1056548 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 8bf8d360c25f..27770143ae8f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1665,6 +1665,7 @@ static int get_sdp_info(struct snd_soc_component *component, int dai_id)
 			break;
 		case RT5640_IF_113:
 			ret |= RT5640_U_IF1;
+			/* fall through */
 		case RT5640_IF_312:
 		case RT5640_IF_213:
 			ret |= RT5640_U_IF2;
@@ -1680,6 +1681,7 @@ static int get_sdp_info(struct snd_soc_component *component, int dai_id)
 			break;
 		case RT5640_IF_223:
 			ret |= RT5640_U_IF1;
+			/* fall through */
 		case RT5640_IF_123:
 		case RT5640_IF_321:
 			ret |= RT5640_U_IF2;
-- 
2.18.0
