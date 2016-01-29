From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Call clk_set_rate in
	pcm3168a_set_dai_sysclk" to the asoc tree
Date: Fri, 29 Jan 2016 01:16:50 +0100
Message-ID: <E1aOwk6-0005ZI-DA@finisterre>
References: <1454000060-8407-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B92A3265A39
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:17:02 +0100 (CET)
In-Reply-To: <1454000060-8407-1-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Damien.Horsley" <Damien.Horsley@imgtec.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Call clk_set_rate in pcm3168a_set_dai_sysclk

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

>From f1188b898ec5aa2e94da8fb998648a2738f4fb3b Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Thu, 28 Jan 2016 16:54:20 +0000
Subject: [PATCH] ASoC: pcm3168a: Call clk_set_rate in pcm3168a_set_dai_sysclk

Call clk_set_rate in pcm3168a_set_dai_sysclk

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 44b268a..0c7248a 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -299,10 +299,15 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(dai->codec);
+	int ret;
 
 	if (freq > PCM1368A_MAX_SYSCLK)
 		return -EINVAL;
 
+	ret = clk_set_rate(pcm3168a->scki, freq);
+	if (ret)
+		return ret;
+
 	pcm3168a->sysclk = freq;
 
 	return 0;
-- 
2.6.4
