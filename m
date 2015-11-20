From: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 0/3] add spba clock for fsl audio IP
Date: Fri, 20 Nov 2015 14:17:50 +0800
Message-ID: <cover.1447997800.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

add spba clock for fsl audio IP

Changes in v2
- spba is a optional clock, compatible with previous devicetree.
- change the name from "dma" to "spba"

Shengjiu Wang (3):
  ASoC: fsl_esai: spba clock is needed by esai device
  ASoC: fsl_spdif: spba clk is needed by spdif device
  ASoC: fsl_asrc: spba clock is needed by asrc device

 Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 sound/soc/fsl/fsl_asrc.c                              | 10 ++++++++++
 sound/soc/fsl/fsl_asrc.h                              |  1 +
 sound/soc/fsl/fsl_esai.c                              | 12 ++++++++++++
 sound/soc/fsl/fsl_spdif.c                             | 14 ++++++++++++++
 7 files changed, 43 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
