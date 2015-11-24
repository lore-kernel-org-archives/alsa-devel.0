From: Shengjiu Wang <shengjiu.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V4 0/3] add spba clock for fsl audio IP
Date: Tue, 24 Nov 2015 17:19:31 +0800
Message-ID: <cover.1448356624.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

add spba clock for fsl audio IP

Changes in V3
- add error check for spba clock

Shengjiu Wang (3):
  ASoC: fsl_esai: spba clock is needed by esai device
  ASoC: fsl_spdif: spba clk is needed by spdif device
  ASoC: fsl_asrc: spba clock is needed by asrc device

 Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
 sound/soc/fsl/fsl_asrc.c                              | 14 ++++++++++++++
 sound/soc/fsl/fsl_asrc.h                              |  2 ++
 sound/soc/fsl/fsl_esai.c                              | 17 +++++++++++++++++
 sound/soc/fsl/fsl_spdif.c                             | 19 +++++++++++++++++++
 7 files changed, 67 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
