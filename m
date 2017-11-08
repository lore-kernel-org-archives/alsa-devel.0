From: Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] ASoC: bcm2835: Enforce full symmetry
Date: Wed,  8 Nov 2017 21:03:32 +0100
Message-ID: <20171108200332.28949-5-hias@horus.com>
References: <20171108200332.28949-1-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20171108200332.28949-1-hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

bcm2835's configuration registers can't be changed when a stream
is running, which means asymmetric configurations aren't supported.

Channel and rate symmetry are already enforced by constraints
but samplebits had been missed.

As hw_params doesn't check for symmetry constraints by itself
and just returns success if a stream is running this led to
situations where asymmetric configurations were seeming to
succeed but of course didn't work because the hardware wasn't
configured at all.

Fix this by adding the missing samplerate symmetry constraint.

Signed-off-by: Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 43f5715a0d5d..2e449d7173fc 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -783,7 +783,8 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 				| SNDRV_PCM_FMTBIT_S32_LE
 		},
 	.ops = &bcm2835_i2s_dai_ops,
-	.symmetric_rates = 1
+	.symmetric_rates = 1,
+	.symmetric_samplebits = 1,
 };
 
 static bool bcm2835_i2s_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.11.0
