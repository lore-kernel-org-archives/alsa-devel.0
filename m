From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 3/3] ASoC: da7219: Add detect_jack callback in the
 snd_soc_codec_driver
Date: Mon, 18 Apr 2016 19:20:03 +0800
Message-ID: <1460978403-4754-4-git-send-email-zhengxing@rock-chips.com>
References: <1460978403-4754-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1460978403-4754-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch tell soc-jack that this codec supports jack detection.

Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v1: None

 sound/soc/codecs/da7219.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 81c0708..5a8ff1e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,6 +1767,8 @@ static struct snd_soc_codec_driver soc_codec_dev_da7219 = {
 	.num_dapm_widgets	= ARRAY_SIZE(da7219_dapm_widgets),
 	.dapm_routes		= da7219_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(da7219_audio_map),
+
+	.detect_jack		= da7219_aad_jack_det,
 };
 
 
-- 
1.7.9.5
