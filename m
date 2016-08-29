From: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
Date: Mon, 29 Aug 2016 18:51:53 +0800
Message-ID: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

These patches support sgtl5000 to be attached to other non-ssi cpu-dais like SAI.

Winter Wang (2):
  ASoC: imx-sgtl5000: Support non-ssi cpu-dai
  ARM: dts: modify sgtl5000 property to support non-ssi cpu-dai

 .../bindings/sound/imx-audio-sgtl5000.txt          |  4 +--
 arch/arm/boot/dts/imx25-pdk.dts                    |  2 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  2 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |  2 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |  2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  2 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |  2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  2 +-
 arch/arm/boot/dts/imx6q-h100.dts                   |  2 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |  2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |  2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |  2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  2 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |  2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  2 +-
 sound/soc/fsl/imx-sgtl5000.c                       | 41 ++++++++++++++--------
 28 files changed, 55 insertions(+), 42 deletions(-)

--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
