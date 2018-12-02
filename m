From: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 00/10] Add support for DMA and audio codec
 of F1C100s
Date: Mon,  3 Dec 2018 00:23:07 +0300
Message-ID: <cover.1543782328.git.mesihkilinc@gmail.com>
Reply-To: mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDI4VHO5SYLBBU42SHQAKGQEDT7R33Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is RFC patchset for Allwinner suniv F1C100s to support DMA and
audio codec.

Allwinner F1C100s has a audio codec that has necessary digital and
analog parts. It has r-l headphone output and microphone, line, r-l
FM inputs. ADC can capture any inputs and also output channels via mux.
Any input channels or DAC samples can feed output channels. 

Add support for this audio codec.

F1C100s utilizes DMA channels to send and receive ADC-DAC samples. So
DMA support needed. Patch 1~5 adds support for DMA. Suniv F1C100s has 
very similar DMA to sun4i. But there is some dissimilarities also. 
Suniv features a DMA reset bit in clock  control unit. It has smaller 
number of DMA channels. Several registers has different addresses. 
It's max burst size is 4 instead of 8. Also DMA endpoint numbers are 
different.

Patch 6 adds DMA max burst option to sun4i-codec.

Patch 7~8 Add support for suniv F1C100s audio codec.

Patch 9 adds audio codec to suniv-f1c100s.dtsi

Patch 10 adds audio codec support to Lichee Pi Nano board.
 
Thanks!

Mesih Kilinc (10):
  dma-engine: sun4i: Add a quirk to support different chips
  dma-engine: sun4i: Add has_reset option to quirk
  dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
  dma-engine: sun4i: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for DMA
  ASoC: sun4i-codec: Add DMA Max Burst field
  dt-bindigs: sound: Add Allwinner suniv F1C100s Audio Codec
  ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for Audio Codec
  ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano

 .../devicetree/bindings/dma/sun4i-dma.txt          |   4 +-
 .../devicetree/bindings/sound/sun4i-codec.txt      |   5 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |   8 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               |  25 ++
 drivers/dma/Kconfig                                |   4 +-
 drivers/dma/sun4i-dma.c                            | 221 ++++++++++--
 sound/soc/sunxi/sun4i-codec.c                      | 371 ++++++++++++++++++++-
 7 files changed, 601 insertions(+), 37 deletions(-)

-- 
2.7.4
