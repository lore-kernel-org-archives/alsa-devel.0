From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] ASoC: max98090: add shutdown callback for max98090
Date: Wed,  8 Apr 2015 16:52:08 +0800
Message-ID: <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1428483128-23498-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Cheng-Yi Chiang <cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, zhengxing <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "jay.xu" <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Tushar Behera <tushar.b-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

To fix pop noise when shutdown,the pop noise during shutdown
is the pmic cutoff power of codec without any notice.

Signed-off-by: jay.xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: zhengxing <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Serien-cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Serien-cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Serien-cc: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org

---

 sound/soc/codecs/max98090.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index b112b1c..066954a0 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2611,6 +2611,22 @@ static int max98090_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void max98090_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
+
+	dev_info(&i2c->dev, "shut down device\n");
+
+	/* Enable volume smoothing, disable zero cross.  This will cause
+	 * a quick 40ms ramp to mute on shutdown.
+	 */
+	regmap_write(max98090->regmap,
+		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
+	regmap_write(max98090->regmap,
+		M98090_REG_DEVICE_SHUTDOWN, 0x00);
+	msleep(40);
+}
+
 #ifdef CONFIG_PM
 static int max98090_runtime_resume(struct device *dev)
 {
@@ -2697,6 +2713,7 @@ static struct i2c_driver max98090_i2c_driver = {
 	},
 	.probe  = max98090_i2c_probe,
 	.remove = max98090_i2c_remove,
+	.shutdown = max98090_i2c_shutdown,
 	.id_table = max98090_i2c_id,
 };
 
-- 
1.9.1
