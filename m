From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc_bind_dai_link() directly returns
	success for a bound DAI link" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:16 +0000
Message-ID: <E1a6NfQ-0003yi-J8@debutante>
References: <9cb8b4b46674b6688c92bf9c22f0cd9db1b86dff.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CA5260612
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:22 +0100 (CET)
In-Reply-To: <9cb8b4b46674b6688c92bf9c22f0cd9db1b86dff.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc_bind_dai_link() directly returns success for a bound DAI link

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

>From 49a5ba1cd9da4fb04e7ce1e0d94f6a5a9b7be48e Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 2 Dec 2015 14:11:40 +0800
Subject: [PATCH] ASoC: soc_bind_dai_link() directly returns success for a
 bound DAI link

This function will return success immediately for a bound DAI link.
No need to look for the cpu/codec DAIs again.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 094856fa8cec..11d073b6ce33 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -960,6 +960,19 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	return NULL;
 }
 
+static bool soc_is_dai_link_bound(struct snd_soc_card *card,
+		struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->dai_link == dai_link)
+			return true;
+	}
+
+	return false;
+}
+
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -977,6 +990,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	if (!rtd)
 		return -ENOMEM;
 
+	if (soc_is_dai_link_bound(card, dai_link)) {
+		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
+			dai_link->name);
+		return 0;
+	}
+
 	cpu_dai_component.name = dai_link->cpu_name;
 	cpu_dai_component.of_node = dai_link->cpu_of_node;
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-- 
2.6.2
