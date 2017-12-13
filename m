From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/2] sunxi: Add Capture support for sun8i-a33
Date: Wed, 13 Dec 2017 13:34:06 +0100
Message-ID: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
Cc: mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello everyone,

Here is a first series to add support for the capture for
Allwinner Sun8I-A33 SoC (sun8i-codec).
These patches have been tested on Sun8i-r16 parrot board and
the two microphones are working well.

Noticed that the DAPM route is not correct: "Right/Left Digital
ADC Mixer" widgets should be after the "Right ADC" (according to what I
understood from the datasheet). This is currently not the case but when
I tried to update it, I got an error about "failing to add routes".
I will investigate why in next weeks (and send a V2) but as it
can take time, I think it is better to send a V1 and got reviews
(because it is the first time I am implementing such features).

Thank you in advance,
Best regards,
Mylène

Mylène Josserand (2):
  ASoC: sun8i-codec: Add ADC support for a33
  ARM: dts: sun8i: Add ADC routing

 arch/arm/boot/dts/sun8i-a33.dtsi | 10 ++++-
 sound/soc/sunxi/sun8i-codec.c    | 82 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
