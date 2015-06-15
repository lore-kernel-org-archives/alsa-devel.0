From: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/3] ASoC: Mediatek: Add support for MT8173 SOC
Date: Mon, 15 Jun 2015 22:38:01 +0800
Message-ID: <1434379084-26026-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This adds basic support for the Mediatek AFE (Audio Front End) unit of MT8173.
This patch is based on Linux 4.1-rc1 and Sascha's SCPSYS power patch [1].

The AFE unit comprises several memory interfaces that communicate with CPU, 
a multi input multi output digital audio interconnect, 
and several external interfaces (e.g. I2S).

[1] https://lkml.org/lkml/2015/6/9/172

changes since v1:
- change Kconfig to tristate
- remove unnecessary !! in the platform driver
- let MODULE_DEVICE_TABLE follow the table
- remove regulators from machine drivers

changes since RFC:
- Use DPCM to model AFE
  AFE memory interfaces such as DL1, VUL are modeled as frontend DAIs,
  and AFE IOs such as I2S, HDMI are backend DAIs.
  Which memif and IO to be used can be set in the machine driver.
  There is no need to indicate this in dts anymore so
  include/dt-bindings/sound/mtk-afe.h is removed.
  AFE connections are represented by DAPM widgets and routes, and
  set connection APIs/tables are no longer required.
  (mtk-afe-connection.c and mtk-afe-connection.h are removed)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
