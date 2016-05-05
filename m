From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 4/7] ASoC: rockchip-max98090: Fix the Headset Mic route.
Date: Thu,  5 May 2016 10:03:38 +0200
Message-ID: <1462435421-21205-5-git-send-email-enric.balletbo@collabora.com>
References: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462435421-21205-1-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget
sanity checks") the following error is seen:

 rockchip-snd-max98090 sound: HiFi <-> ff890000.i2s mapping ok
 rockchip-snd-max98090 sound: Connecting non-supply widget to supply widget is not supported (Headset Mic -> MICBIAS)
 rockchip-snd-max98090 sound: ASoC: no dapm match for Headset Mic --> (null) --> MICBIAS
 rockchip-snd-max98090 sound: ASoC: Failed to add route Headset Mic -> direct -> MICBIAS
 input: ROCKCHIP-I2S Headset Jack as /devices/platform/sound/sound/card0/input3

Invert the route between the Headset Mic and the bias in order to fix it.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index abb64a5..3da7891 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -53,7 +53,7 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
 	{"IN34", NULL, "MICBIAS"},
-	{"MICBIAS", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
 	{"Headphone", NULL, "HPR"},
-- 
2.1.0
