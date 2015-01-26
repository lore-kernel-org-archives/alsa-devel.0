From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH_V3 0/4] sound:soc: jz4740: DT, dynamic sampling, enable clocks
Date: Mon, 26 Jan 2015 14:53:09 +0000
Message-ID: <1422283993-53642-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

Here are a few simple patches for the jz4740.

First adds dynamic sampling support to jz4740-i2s.
Then two to add a simple binding and DT support.
Then a patch to set the clock rate for i2s.

These are in preparation for jz4780 and ci20 later on.

Patches are based on 3.19-rc6. Quite disjoint and stay within jz4740 
so should apply easily on other trees.

If you would like to have them rebased to a different tree, please tell.

Thank-you

V3 changes:
Added dma binding to example but forgot to put it in required properties.

V2 changes: 
Removed a redundant #define
Added #ifdef CONFIG_OF
Added dma in binding document
Removed a redundant call to clk_prepare_enable


Zubair Lutfullah Kakakhel (4):
  sound: soc: jz4740: Add dynamic sampling rate support to jz4740-i2s
  dt: sound: jz4740: Add binding documentation for jz4740-i2s
  sound: soc: jz4740: Add DT support to jz4740-i2s driver
  sound: jz4740: set i2s clk rate to 12MHz

 .../bindings/sound/ingenic,jz4740-i2s.txt          | 23 ++++++++++++++++++++++
 sound/soc/jz4740/jz4740-i2s.c                      | 22 ++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
