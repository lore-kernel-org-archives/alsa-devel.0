From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH asoc] IIO: ADC: stm32_dfsdm_stop_filter() can be static
Date: Wed, 10 Jan 2018 23:23:05 +0800
Message-ID: <20180110152305.GA83560@lkp-sb05>
References: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201801102320.fKoiIrHz%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 stm32-dfsdm-adc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f..e628d04 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -254,7 +254,7 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSWSTART(1));
 }
 
-void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
+static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
 {
 	/* Disable conversion */
 	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
@@ -296,9 +296,9 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSYNC(fl->sync_mode));
 }
 
-int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
-				 struct iio_dev *indio_dev,
-				 struct iio_chan_spec *ch)
+static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
+					struct iio_dev *indio_dev,
+					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
 	const char *of_str;
