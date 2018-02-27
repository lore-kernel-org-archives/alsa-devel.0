From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH 1/1] ASoC: davinci-mcasp: Only disable inactive
	serializer
Date: Tue, 27 Feb 2018 15:51:04 +0100
Message-ID: <20180227145104.5868-2-vishalthanki@gmail.com>
References: <20180227145104.5868-1-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C622671A9
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 15:51:34 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id s206so22036825wme.0
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 06:51:34 -0800 (PST)
In-Reply-To: <20180227145104.5868-1-vishalthanki@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, christophe.jaillet@wanadoo.fr, elfring@users.sourceforge.net, arvind.yadav.cs@gmail.com
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
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 03ba218160ca..f382dd55cae0 100644
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
2.14.3
