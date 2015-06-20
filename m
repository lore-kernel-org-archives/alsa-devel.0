From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: wm8731: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 15:55:52 -0300
Message-ID: <1434826553-11484-3-git-send-email-festevam@gmail.com>
References: <1434826553-11484-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 446A426071B
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 20:56:19 +0200 (CEST)
Received: by qkhu186 with SMTP id u186so78587954qkh.0
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:56:18 -0700 (PDT)
In-Reply-To: <1434826553-11484-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8731.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 915ea11..3f87e7d 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -496,8 +496,11 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		if (wm8731->mclk)
-			clk_prepare_enable(wm8731->mclk);
+		if (wm8731->mclk) {
+			ret = clk_prepare_enable(wm8731->mclk);
+			if (ret)
+				return ret;
+		}
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
-- 
1.9.1
