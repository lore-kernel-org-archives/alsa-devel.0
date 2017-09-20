From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add missing snd_soc_component_set_jack"
	to the asoc tree
Date: Wed, 20 Sep 2017 04:42:01 -0700 (PDT)
Message-ID: <20170920114201.5A21F4400D3@finisterre.ee.mobilebroadband>
References: <87bmmvnizb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D9B73267505
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:42:03 +0200 (CEST)
In-Reply-To: <87bmmvnizb.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: add missing snd_soc_component_set_jack

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

>From 840bc44849b9d7f8eaae34ac7b434e17c4cf7368 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Sep 2017 06:08:42 +0000
Subject: [PATCH] ASoC: add missing snd_soc_component_set_jack

commit 44c07365e9e2 ("ASoC: add Component level set_jack") added new
snd_soc_component_set_jack(), but it didn't add definition on soc.h.
This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d22de9712c45..996bdbc125a5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1487,6 +1487,8 @@ int snd_soc_component_set_sysclk(struct snd_soc_component *component,
 int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 			      int source, unsigned int freq_in,
 			      unsigned int freq_out);
+int snd_soc_component_set_jack(struct snd_soc_component *component,
+			       struct snd_soc_jack *jack, void *data);
 
 #ifdef CONFIG_REGMAP
 
-- 
2.13.2
