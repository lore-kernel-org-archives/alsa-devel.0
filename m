From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH] ASoC: davinci-mcasp: Only disable inactive
	serializer
Date: Fri, 11 May 2018 14:33:37 +0200
Message-ID: <1526042017-27389-1-git-send-email-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AD52267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 14:33:40 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so5175579wrg.11
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:33:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
Cc: Vishal Thanki <vishalthanki@gmail.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 79fc4aa..1f96c9d 100644
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
2.7.4
