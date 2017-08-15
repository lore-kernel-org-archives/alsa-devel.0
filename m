From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/5] ASoC: rockchip: constify snd_soc_dai_ops structures
Date: Tue, 15 Aug 2017 17:10:09 +0200
Message-ID: <1502809812-13891-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/rockchip/rockchip_pdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index c5ddeed..400e29e 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -249,7 +249,7 @@ static int rockchip_pdm_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static struct snd_soc_dai_ops rockchip_pdm_dai_ops = {
+static const struct snd_soc_dai_ops rockchip_pdm_dai_ops = {
 	.set_fmt = rockchip_pdm_set_fmt,
 	.trigger = rockchip_pdm_trigger,
 	.hw_params = rockchip_pdm_hw_params,
