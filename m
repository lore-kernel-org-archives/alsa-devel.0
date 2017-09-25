From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove unneeded dai->driver check" to
	the asoc tree
Date: Mon, 25 Sep 2017 17:31:20 +0100 (BST)
Message-ID: <20170925163120.93528440053@finisterre.ee.mobilebroadband>
References: <87h8vrpnsg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 050C4266EEB
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:09 +0200 (CEST)
In-Reply-To: <87h8vrpnsg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove unneeded dai->driver check

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

>From 464719255e095b0cc05a30b124f2cdc67a930d7f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Sep 2017 01:38:34 +0000
Subject: [PATCH] ASoC: remove unneeded dai->driver check

On soc_add_dai(), it is checking dai->driver->xxx,
This means, dai->driver is mandatory, never been NULL.
dai->driver check is not needed.
This patch removes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 091ebe198194..e16220600e51 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2631,7 +2631,7 @@ EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir)
 {
-	if (dai->driver && dai->driver->ops->set_sysclk)
+	if (dai->driver->ops->set_sysclk)
 		return dai->driver->ops->set_sysclk(dai, clk_id, freq, dir);
 
 	return snd_soc_component_set_sysclk(dai->component, clk_id, 0,
@@ -2699,7 +2699,7 @@ EXPORT_SYMBOL_GPL(snd_soc_component_set_sysclk);
 int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
 	int div_id, int div)
 {
-	if (dai->driver && dai->driver->ops->set_clkdiv)
+	if (dai->driver->ops->set_clkdiv)
 		return dai->driver->ops->set_clkdiv(dai, div_id, div);
 	else
 		return -EINVAL;
@@ -2719,7 +2719,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_clkdiv);
 int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	unsigned int freq_in, unsigned int freq_out)
 {
-	if (dai->driver && dai->driver->ops->set_pll)
+	if (dai->driver->ops->set_pll)
 		return dai->driver->ops->set_pll(dai, pll_id, source,
 					 freq_in, freq_out);
 
@@ -2785,7 +2785,7 @@ EXPORT_SYMBOL_GPL(snd_soc_component_set_pll);
  */
 int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
-	if (dai->driver && dai->driver->ops->set_bclk_ratio)
+	if (dai->driver->ops->set_bclk_ratio)
 		return dai->driver->ops->set_bclk_ratio(dai, ratio);
 	else
 		return -EINVAL;
@@ -2859,7 +2859,7 @@ static int snd_soc_xlate_tdm_slot_mask(unsigned int slots,
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	if (dai->driver && dai->driver->ops->xlate_tdm_slot_mask)
+	if (dai->driver->ops->xlate_tdm_slot_mask)
 		dai->driver->ops->xlate_tdm_slot_mask(slots,
 						&tx_mask, &rx_mask);
 	else
@@ -2868,7 +2868,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	dai->tx_mask = tx_mask;
 	dai->rx_mask = rx_mask;
 
-	if (dai->driver && dai->driver->ops->set_tdm_slot)
+	if (dai->driver->ops->set_tdm_slot)
 		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 				slots, slot_width);
 	else
@@ -2892,7 +2892,7 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 	unsigned int tx_num, unsigned int *tx_slot,
 	unsigned int rx_num, unsigned int *rx_slot)
 {
-	if (dai->driver && dai->driver->ops->set_channel_map)
+	if (dai->driver->ops->set_channel_map)
 		return dai->driver->ops->set_channel_map(dai, tx_num, tx_slot,
 			rx_num, rx_slot);
 	else
@@ -2909,7 +2909,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
  */
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	if (dai->driver && dai->driver->ops->set_tristate)
+	if (dai->driver->ops->set_tristate)
 		return dai->driver->ops->set_tristate(dai, tristate);
 	else
 		return -EINVAL;
-- 
2.14.1
