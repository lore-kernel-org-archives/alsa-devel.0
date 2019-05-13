From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: fe_compr can be bit field" to
	the asoc tree
Date: Mon, 13 May 2019 13:30:26 +0100 (BST)
Message-ID: <20190513123026.DF79E1129236@debutante.sirena.org.uk>
References: <87pnomalri.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D17ADF8968A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87pnomalri.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc.h: fe_compr can be bit field

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7426af5010d1b4a109e5d7ee639f3c3e0e5b3cdd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:07:27 +0900
Subject: [PATCH] ASoC: soc.h: fe_compr can be bit field

fe_compr is used at soc-compress, it can be bit field.
This patch move it from int to bit field.

> grep fe_compr -r sound/soc/*
sound/soc/soc-compress.c:               rtd->fe_compr = 1;
sound/soc/soc-pcm.c:            if (!fe->dpcm[stream].runtime && !fe->fe_compr)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 482b4ea87c3c..f20785aa7b4a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1214,7 +1214,6 @@ struct snd_soc_pcm_runtime {
 
 	/* Dynamic PCM BE runtime data */
 	struct snd_soc_dpcm_runtime dpcm[2];
-	int fe_compr;
 
 	long pmdown_time;
 
@@ -1239,6 +1238,7 @@ struct snd_soc_pcm_runtime {
 	/* bit field */
 	unsigned int dev_registered:1;
 	unsigned int pop_wait:1;
+	unsigned int fe_compr:1; /* for Dynamic PCM */
 };
 #define for_each_rtd_codec_dai(rtd, i, dai)\
 	for ((i) = 0;						       \
-- 
2.20.1
