From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 1/3] ASoC: rockchip: Fix dai_name for HDMI codec
Date: Tue, 20 Mar 2018 13:03:30 -0300
Message-ID: <20180320160332.13212-2-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3600A2671F9
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:04:26 +0100 (CET)
Received: by mail-qt0-f194.google.com with SMTP id i8so2139779qtj.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 09:04:26 -0700 (PDT)
In-Reply-To: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Commit 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
changed the dai_name for the HDMI Codec, breaking the rk3288_hdmi_analog
driver, which fails to register with a:

  rk3288-snd-hdmi-analog sound: ASoC: CODEC DAI hdmi-hifi.0 not registered

This commit fixes the dai_name, fixing the issue.

Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Fixes: 24069b589b02 ("ASoC: hdmi-codec: remove multi detection support")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index fa44e3901336..929b3fe289b0 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -155,7 +155,7 @@ static struct snd_soc_dai_link_component rk_codecs[] = {
 	{ },
 	{
 		.name = "hdmi-audio-codec.2.auto",
-		.dai_name = "hdmi-hifi.0",
+		.dai_name = "i2s-hifi",
 	},
 };
 
-- 
2.16.2
