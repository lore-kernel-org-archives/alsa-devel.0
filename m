From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/3] ASoC: jack: Add an export of a function that calls the
 codec jack detection
Date: Mon, 18 Apr 2016 19:20:01 +0800
Message-ID: <1460978403-4754-2-git-send-email-zhengxing@rock-chips.com>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch add an export of a function. We can fill the detect_jack
function in the struct snd_soc_codec_driver, and to tell sound machine
driver (simple-card) that the codec supports the jack detection feature.

Then, the machine driver (simple-card) call the export function of the
sound framework to initialize jack detection via the codec.

Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v1:
- clean up the commit message and notes

 include/sound/soc.h  |    7 +++++++
 sound/soc/soc-jack.c |   17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..64e3f4a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -547,6 +547,10 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 #endif
 
+/* call and init jack detect via the codec */
+void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack);
+
 /* codec register bit access */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
@@ -920,6 +924,9 @@ struct snd_soc_codec_driver {
 			     enum snd_soc_dapm_type, int);
 
 	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
+
+	/* fill this function if the codec supports jack detection */
+	void (*detect_jack)(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
 };
 
 /* SoC platform interface */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fbaa1bb..ccaf546 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -436,3 +436,20 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_free_gpios);
 #endif	/* CONFIG_GPIOLIB */
+
+/**
+ * snd_soc_jack_codec_detect - Call and init jack detection if the codec support it
+ *
+ * @codec: ASoC codec
+ * @jack:  ASoC jack
+ *
+ * Call and initialize the codec jack detection if the codec supports it and fills
+ * the detect_jack function in the struct snd_soc_codec_driver.
+ */
+void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack)
+{
+	if (codec && codec->driver && codec->driver->detect_jack)
+		codec->driver->detect_jack(codec, jack);
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_codec_detect);
-- 
1.7.9.5
