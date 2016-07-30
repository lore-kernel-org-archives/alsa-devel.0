From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 0/2] ASoC: Extended SPDIF support to
 Allwinner A31 SoCs
Date: Sat, 30 Jul 2016 17:56:36 +0200
Message-ID: <20160730155638.24455-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBOM46O6AKGQEVP4WHDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch set extends the current support of the Allwinner SPDIF
transceiver to include the A31 SoC.

For now just the SPDIF transmitter has been tested on the Mele I7.

In order for this patch set to be functional then we require changes
to the clocks and the device tree. For those that are interested I've
pushed all the required patches here

https://github.com/codekipper/linux-sunxi/commits/a31-spdif

Thanks in advance,
CK

---
Changes since v1:
 - Corrected mistake in bindings documentation

Marcus Cooper (2):
  ASoC: sunxi: Add bindings for sun6i to SPDIF
  ASoC: sunxi: compatibility for sun6i to SPDIF

 .../devicetree/bindings/sound/sunxi,sun4i-spdif.txt     |  3 +++
 sound/soc/sunxi/sun4i-spdif.c                           | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.9.2
