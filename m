From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: remove unnecessary selection in
	Kconfig
Date: Mon, 31 Oct 2016 17:19:54 +0800
Message-ID: <1477905594-12081-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B708F2668C0
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 10:20:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

SND_SOC_RT5663 is not required for SND_SOC_RT286.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667b..22aaf63 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -672,7 +672,6 @@ config SND_SOC_RL6347A
 
 config SND_SOC_RT286
 	tristate
-	select SND_SOC_RT5663
 	depends on I2C
 
 config SND_SOC_RT298
-- 
1.8.1.1.439.g50a6b54
