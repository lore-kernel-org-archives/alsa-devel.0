From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] ASoC: wm8904: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 15:55:51 -0300
Message-ID: <1434826553-11484-2-git-send-email-festevam@gmail.com>
References: <1434826553-11484-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C850260713
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 20:56:16 +0200 (CEST)
Received: by qcji3 with SMTP id i3so570448qcj.1
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:56:15 -0700 (PDT)
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
 sound/soc/codecs/wm8904.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 265a4a5..07dc400 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1837,7 +1837,9 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		clk_prepare_enable(wm8904->mclk);
+		ret = clk_prepare_enable(wm8904->mclk);
+		if (ret)
+			return ret;
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-- 
1.9.1
