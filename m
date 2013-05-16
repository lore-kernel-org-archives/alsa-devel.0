From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: davinci: fix sample rotation
Date: Thu, 16 May 2013 15:25:01 +0200
Message-ID: <1368710701-12159-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E185265513
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 15:24:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, broonie@kernel.org, vaibhav.bedia@ti.com, marek.belisko@streamunlimited.com, "[3.9 only]"@mail.zonque.de
List-Id: alsa-devel@alsa-project.org

McASP serial audio engine needs different rotation values on TX and RX
channels. Commit dde109fb462 ("ASoC: McASP: Fix data rotation for
playback. Enables 24bit audio playback") changed the calculation to fix
the playback format, but broke the capture stream by doing it for both
TXFMT and RXFMT.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: stable@vger.kernel.org [3.9 only]
---
 sound/soc/davinci/davinci-mcasp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 63633e9..8d805ec 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -628,7 +628,8 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int word_length)
 {
 	u32 fmt;
-	u32 rotate = (word_length / 4) & 0x7;
+	u32 tx_rotate = (word_length / 4) & 0x7;
+	u32 rx_rotate = (32 - word_length) / 4;
 	u32 mask = (1ULL << word_length) - 1;
 
 	/*
@@ -651,9 +652,9 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
 				TXSSZ(fmt), TXSSZ(0x0F));
 		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
-				TXROT(rotate), TXROT(7));
+				TXROT(tx_rotate), TXROT(7));
 		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
-				RXROT(rotate), RXROT(7));
+				RXROT(rx_rotate), RXROT(7));
 		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG,
 				mask);
 	}
-- 
1.8.1.4
