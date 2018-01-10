From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [asoc:topic/iio 9/11] drivers/iio/adc/stm32-dfsdm-adc.c:241:6:
 sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
 static?
Date: Wed, 10 Jan 2018 23:23:05 +0800
Message-ID: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/iio
head:   16cbca06fa8288a4f58426fc898b141e12ee8008
commit: e2e6771c646251657fafb2a78db566d5c2c70635 [9/11] IIO: ADC: add STM32 DFSDM sigma delta ADC support
reproduce:
        # apt-get install sparse
        git checkout e2e6771c646251657fafb2a78db566d5c2c70635
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/adc/stm32-dfsdm-adc.c:241:6: sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
>> drivers/iio/adc/stm32-dfsdm-adc.c:283:5: sparse: symbol 'stm32_dfsdm_channel_parse_of' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
