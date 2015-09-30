From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 0/4] Add SPDIF support for Allwinner SoCs
Date: Wed, 30 Sep 2015 19:50:54 +0200
Message-ID: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBBWCWCYAKGQEDYSRLOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch set adds support for the Allwinner SPDIF transceiver as present
on the A10, A20 and A31 SoC boards.

For now just the SPDIF transmitter has been tested on a Mele A2000.

In order for this patch set to be functional we require audio clock patches
which will be delivered separately. For those that are interested I've pushed
the patches here with all the required changes to get SPDIF audio out of the
device.

https://github.com/codekipper/linux-sunxi/commits/spdif_delivery

This is version 2 of the patch series. After Mark's initial comments I realised
that I shouldn't of blindly copied the register set-up from the original SDK
that was released. It doesn't help also that the datasheet that finally emerged
lacked a serious amount of detail. If anybody does recognise the IP used for the
block then please speak out.

In short, much of the code that was in the first release is no longer here. 

I'm still unsure about the machine driver setup. Simple card seems a bit overkill
and what I've added is pretty much a copy of what is done in imx-spdif. I'm not
planning on arguing the case for my method so if you can advise then I'm all
ears.

Thanks in advance,
CK

---
Changes since v1:
- Moved sunxi-machine-spdif.c to seperate patch
- replaced sunxi in naming scheme with sun4i in the sun4i-spdif driver.
- split tx controller into seperate enable/disable functions
- moved setclk and setfmt functionality into hw params
- added support for mono signals.
- cleaned up probe clock set up.
- removed all writes to transmit status registers.
- removed of_id
- removed power management code.
- Added support for more rates.
---
Marcus Cooper (4):
  dt-bindings: add sunxi SPDIF transceiver bindings
  dt-binding: Add sunxi S/PDIF machine driver
  ASoC: sunxi: Add S/PDIF machine driver.
  ASOC: sunxi: Add support for the spdif block

 .../devicetree/bindings/sound/sunxi,spdif.txt      |  49 ++
 .../bindings/sound/sunxi-audio-spdif.txt           |  36 ++
 sound/soc/sunxi/Kconfig                            |  12 +
 sound/soc/sunxi/Makefile                           |   4 +
 sound/soc/sunxi/sun4i-spdif.c                      | 612 +++++++++++++++++++++
 sound/soc/sunxi/sunxi-machine-spdif.c              | 108 ++++
 6 files changed, 821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
 create mode 100644 sound/soc/sunxi/sun4i-spdif.c
 create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c

-- 
1.9.1
