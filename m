From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/2] ASoC: sunxi: Add ADC support for A33
Date: Wed,  3 May 2017 15:56:15 +0200
Message-ID: <20170503135617.25193-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello everyone,

This is a first version of a serie to add ADC support
for Sun8i-A33.
Based on asoc/for-next branch, last commit:
20d5c84bef067b7e804a163e2abca16c47125bad.

The first patch adds the support of ADC and microphones in the digital
part (driver sun8i-codec).
The second one adds the route between analog (sun8i-codec-analog) and
digital (sun8i-codec) parts to have a functional ADC route on Sun8i-A33
device tree.

Tested on Allwinner R16 Parrot board with microphone 1 (external) and
microphone 2 (headset).

I am not sure about the bias handling so if you have any comments on it,
do not hesitate.

Thank you in advance!

Best regards,

Mylène Josserand (2):
  ASoC: sun8i-codec: Add ADC support for a33
  ARM: dts: sun8i: Add ADC routing

 arch/arm/boot/dts/sun8i-a33.dtsi | 10 ++++-
 sound/soc/sunxi/sun8i-codec.c    | 80 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
