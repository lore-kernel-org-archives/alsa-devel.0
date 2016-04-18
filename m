From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/3] Add support simple-card parse jack detection via external codec
Date: Mon, 18 Apr 2016 16:17:29 +0800
Message-ID: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


Hi,
    In most cases, many codecs already supports jack detection,
previouslly, we need to create a customized machine driver every time.

    Hence, the simple-card need to support use them dynamically via
parse dts file for better flexibility.


Xing Zheng (3):
  ASoC: jack: Add a jack detect callback via codec
  ASoC: simple-card: Add support jack detection via codec
  ASoC: da7219: Add detect_jack callback in the snd_soc_codec_driver

 .../devicetree/bindings/sound/simple-card.txt      |   17 +++
 include/sound/soc.h                                |    6 +
 sound/soc/codecs/da7219.c                          |    2 +
 sound/soc/generic/simple-card.c                    |  126 +++++++++++++++++++-
 sound/soc/soc-jack.c                               |    8 ++
 5 files changed, 156 insertions(+), 3 deletions(-)

-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
