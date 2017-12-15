From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: care Codec <-> Codec case by
	non_legacy_dai_naming" to the asoc tree
Date: Fri, 15 Dec 2017 15:11:00 +0000 (GMT)
Message-ID: <20171215151100.6BEE544006B@finisterre.ee.mobilebroadband>
References: <87y3m4d1p7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 93E92266D45
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 16:11:03 +0100 (CET)
In-Reply-To: <87y3m4d1p7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: care Codec <-> Codec case by non_legacy_dai_naming

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

>From cb2cf0de1174701b7c8c0285a0f398b9f2d30d8e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Dec 2017 05:10:47 +0000
Subject: [PATCH] ASoC: soc-core: care Codec <-> Codec case by
 non_legacy_dai_naming

CPU/Codec categorize will be removed soon.
Then, it need to know DAI is Codec somehow. This patch uses component
driver's "non_legacy_dai_naming" which is used by Codec for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 90f1122d91c4..b9ca939fd05c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1945,7 +1945,9 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	}
 
 	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
-	if (cpu_dai->codec) {
+	/* the component which has non_legacy_dai_naming is Codec */
+	if (cpu_dai->codec ||
+	    cpu_dai->component->driver->non_legacy_dai_naming) {
 		unsigned int inv_dai_fmt;
 
 		inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
-- 
2.15.0
