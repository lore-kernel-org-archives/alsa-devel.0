From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: remove wrong error message" to the
	asoc tree
Date: Thu, 19 Nov 2015 19:56:43 +0000
Message-ID: <E1ZzVJz-0006U1-Mp@debutante>
References: <1447941250-344-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7F942614D3
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 20:56:51 +0100 (CET)
In-Reply-To: <1447941250-344-2-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: remove wrong error message

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

>From cd3ed08a86e8b5022f107aa72a1929b6417c1f42 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 19 Nov 2015 14:54:07 +0100
Subject: [PATCH] ASoC: sti: remove wrong error message

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_reader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index f791239a3087..819eeafdf6b4 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -346,7 +346,6 @@ int uni_reader_init(struct platform_device *pdev,
 	reader->hw = &uni_reader_pcm_hw;
 	reader->dai_ops = &uni_reader_dai_ops;
 
-	dev_err(reader->dev, "%s: enter\n", __func__);
 	ret = uni_reader_parse_dt(pdev, reader);
 	if (ret < 0) {
 		dev_err(reader->dev, "Failed to parse DeviceTree");
-- 
2.6.2
