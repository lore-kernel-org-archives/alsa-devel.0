From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 4/4] ASoC: rockchip: Enable 192khz in hw_params
	operation
Date: Fri, 24 Feb 2017 17:01:04 +0100
Message-ID: <20170224160104.29354-5-romain.perier@collabora.com>
References: <20170224160104.29354-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id B5FE12669EA
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 17:01:20 +0100 (CET)
In-Reply-To: <20170224160104.29354-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

As the sampling frequency is supported by es8328 in slave mode,
add support for it in the corresponding operation.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index b60abf3..dbc53e4 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -93,6 +93,9 @@ static int rk_hw_params(struct snd_pcm_substream *substream,
 	case 96000:
 		mclk = 12288000;
 		break;
+	case 192000:
+		mclk = 24576000;
+		break;
 	case 11025:
 	case 22050:
 	case 44100:
-- 
2.9.3
