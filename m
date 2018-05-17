From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Only disable inactive
	serializer" to the asoc tree
Date: Thu, 17 May 2018 17:38:45 +0100 (BST)
Message-ID: <20180517163845.D21E744007E@finisterre.ee.mobilebroadband>
References: <20180227145104.5868-2-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 622742671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:38:49 +0200 (CEST)
In-Reply-To: <20180227145104.5868-2-vishalthanki@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, Mark Brown <broonie@kernel.org>, christophe.jaillet@wanadoo.fr, arvind.yadav.cs@gmail.com, elfring@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Only disable inactive serializer

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

>From 096a8f835e7d19f0402386353586d285566eee06 Mon Sep 17 00:00:00 2001
From: Vishal Thanki <vishalthanki@gmail.com>
Date: Fri, 11 May 2018 14:33:37 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Only disable inactive serializer

As a side effect of the following commit, the active TX
serializer may get disabled which may result in distorted
audio output.

ASoC: davinci-mcasp: Add support for multichannel playback
(2952b27e2e463b28d5c0f04000f96b968137ca42)

For example, if a 4 channel I2S playback with two TX serializers
is activated. Later on, if a recording of 2 channels, with only 1 RX
serializer is started, which will also disable one of the TX
serializer because max_active_serializers is only calculated for
RX (recording) stream. This patch fixes this issue.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 79fc4aa2fa29..1f96c9dbe9c4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -789,7 +789,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 					rx_ser < max_active_serializers) {
 			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
 			rx_ser++;
-		} else {
+		} else if (mcasp->serial_dir[i] == INACTIVE_MODE) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       SRMOD_INACTIVE, SRMOD_MASK);
 		}
-- 
2.17.0
