From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv2 0/5] Convert to use regmap framework's endianness method.
Date: Tue, 19 Aug 2014 12:14:48 +0800
Message-ID: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Changes in V2:
- Modified the regmap config to const type.
- Added ASRC patch.
- Followed Rutland's advice.


Xiubo Li (5):
  ASoC: fsl-asrc: Convert to use regmap framework's endianness method.
  ASoC: fsl-esai: Convert to use regmap framework's endianness method.
  ASoC: fsl-spdif: Convert to use regmap framework's endianness method.
  ASoC: fsl-sai: Convert to use regmap framework's endianness method.
  ASoC: fsl-sai: rename big_endian_data to is_msb_first.

 Documentation/devicetree/bindings/sound/fsl-sai.txt | 15 +++++++--------
 sound/soc/fsl/fsl_asrc.c                            |  6 +-----
 sound/soc/fsl/fsl_esai.c                            |  5 +----
 sound/soc/fsl/fsl_sai.c                             | 12 ++++--------
 sound/soc/fsl/fsl_sai.h                             |  3 +--
 sound/soc/fsl/fsl_spdif.c                           |  5 +----
 6 files changed, 15 insertions(+), 31 deletions(-)

-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
