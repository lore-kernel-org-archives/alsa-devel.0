From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix oops w/
	for_each_rtd_codec_dai_rollback() macro" to the asoc tree
Date: Tue, 30 Oct 2018 15:35:16 +0000 (GMT)
Message-ID: <20181030153516.C511211239A7@debutante.sirena.org.uk>
References: <20181026215443.29081-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B510C26751A
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 16:35:19 +0100 (CET)
In-Reply-To: <20181026215443.29081-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix oops w/ for_each_rtd_codec_dai_rollback() macro

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

>From 23cb2d04db54535df65edbbebbca89f2590f08bd Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 26 Oct 2018 16:54:43 -0500
Subject: [PATCH] ASoC: fix oops w/ for_each_rtd_codec_dai_rollback() macro

A kernel oops happens on an error case (usual missing BE mixer
configuration required by Intel SST driver). Git bisect points to this
macro and an operator precedence issue.

	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)

The initial code replaced by this macro was
	while (--i >= 0) {
		codec_dai = rtd->codec_dais[i];

Fix the C operator precedence difference by reverting to pre-decrement

Fixes: 0b7990e3897 ('ASoC: add for_each_rtd_codec_dai() macro')
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1dab1f4b194..70c10a8f3e90 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1192,7 +1192,7 @@ struct snd_soc_pcm_runtime {
 	     ((i) < rtd->num_codecs) && ((dai) = rtd->codec_dais[i]); \
 	     (i)++)
 #define for_each_rtd_codec_dai_rollback(rtd, i, dai)		\
-	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)
+	for (; ((--i) >= 0) && ((dai) = rtd->codec_dais[i]);)
 
 
 /* mixer control */
-- 
2.19.0.rc2
