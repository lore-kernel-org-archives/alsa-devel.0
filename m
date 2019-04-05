From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: remove link components before
	cleaning up card resources" to the asoc tree
Date: Fri,  5 Apr 2019 09:43:24 +0700 (+07)
Message-ID: <20190405024325.0A412441D3B@finisterre.ee.mobilebroadband>
References: <20190405003040.8709-4-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9DD1F8974D
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:43:38 +0200 (CEST)
In-Reply-To: <20190405003040.8709-4-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: remove link components before cleaning up card resources

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

>From f96fb7d198ca624fe33c4145a004eb5a3d0eddec Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 4 Apr 2019 17:30:40 -0700
Subject: [PATCH] ASoC: core: remove link components before cleaning up card
 resources

When the card is registered by the machine driver,
dai link components are probed after the snd_card is
created. This is done in snd_soc_bind_card() which calls
snd_soc_instantiate_card() to first create the snd_card
and then probes the link components by calling
soc_probe_link_components(). The snd_card is used by the
component driver to add the kcontrols associated
with dapm widgets to the card.

When the machine driver is unregistered, the snd_card
is freed when the card resources are cleaned up.
But the snd_card needs to be valid while unloading the
topology dapm widgets in order to remove the kcontrols
from the card.

Since, unloading topology is done when the component
driver is removed, the link components should be removed
in snd_soc_unbind_card(). This will ensure that the kcontrols
are removed before the card resources are cleaned up and
the snd_card itself is freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6f4842977b8d..75f6a8085a76 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2831,10 +2831,21 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
 static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 {
+	struct snd_soc_pcm_runtime *rtd;
+	int order;
+
 	if (card->instantiated) {
 		card->instantiated = false;
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
+
+		/* remove all components used by DAI links on this card */
+		for_each_comp_order(order) {
+			for_each_card_rtds(card, rtd) {
+				soc_remove_link_components(card, rtd, order);
+			}
+		}
+
 		soc_cleanup_card_resources(card);
 		if (!unregister)
 			list_add(&card->list, &unbind_card_list);
-- 
2.20.1
