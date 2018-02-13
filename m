From: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH v3 0/3] add UniPhier audio nodes
Date: Tue, 13 Feb 2018 22:01:53 +0900
Message-ID: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This series adds device-tree nodes for Socionext audio system
for UniPhier LD11/LD20 SoCs. This one enables I2S output for
Line-In, Line-Out, S/PDIF output and compress audio output.

Katsuhiro Suzuki (3):
  arm64: dts: uniphier: add sound node for UniPhier
  arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
  arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20

 .../boot/dts/socionext/uniphier-ld11-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
 4 files changed, 312 insertions(+)

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
