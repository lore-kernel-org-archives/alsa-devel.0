From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] Add i.MX6q Kosagi Novena support
Date: Fri,  7 Feb 2014 13:05:14 +0800
Message-ID: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The Kosagi Novena board contains an i.MX6 Quad processor.  This patchset
adds support for this platform, along with support for its own audio codec.

The platform uses an ES8328-based codec, which is currently unsupported in
the Linux kernel.  The audio codec supports playback and recording, as well
as jack detection support for the headset.  Audio codec support is required
as an uninitialized audio codec pulls I2C2 lines down, preventing the bus
from working.

There are two known issues with this patch, and I would like some feedback
on them:

    * I'm unclear on how audio routing works.  The ES8328 has five outputs:
      LOUT1, ROUT1, LOUT2, ROUT2, and OUT3.  It also has four inputs.  The
      board maps Headphone L/R to L/ROUT2, and Speaker to L/ROUT1.  What is
      the proper way to describe this audio routing?
    * The snd-soc-imx-novena.ko module oopses when removing it.  The backtrace
      shows that it's caused by "Unable to handle kernel paging request at
      virtual address", due to snd_jack_dev_free possibly getting called twice.
      What could be causing this?  I never explicitly free the jack device:
 (snd_ctl_remove) from [<804c73d0>] (snd_jack_dev_free+0x48/0x68)
 (snd_jack_dev_free) from [<804c6ef8>] (snd_device_free+0xd0/0x148)
 (snd_device_free) from [<804c72b0>] (snd_device_free_all+0x90/0xb0)
 (snd_device_free_all) from [<804c20ac>] (snd_card_do_free+0x40/0xec)
 (snd_card_do_free) from [<804c22b4>] (snd_card_free+0x74/0x80)
 (snd_card_free) from [<804de444>] (soc_cleanup_card_resources+0xb4/0xbc)
 (soc_cleanup_card_resources) from [<804de460>] (snd_soc_unregister_card+0x14/0x1c)
 (snd_soc_unregister_card) from [<7f032014>] (imx_novena_remove+0x14/0x1c [snd_soc_imx_novena])
 (imx_novena_remove [snd_soc_imx_novena]) from [<8035c258>] (__device_release_driver+0x64/0xb0)
 (__device_release_driver) from [<8035c81c>] (driver_detach+0xa4/0xcc)
 (driver_detach) from [<8035be88>] (bus_remove_driver+0x64/0x9c)
 (bus_remove_driver) from [<8007ea44>] (SyS_delete_module+0x110/0x188)
 (SyS_delete_module) from [<8000e080>] (ret_fast_syscall+0x0/0x30)


Sean Cross (3):
  sound: soc: codecs: Add es8328 codec
  sound: soc: fsl: Add support for Novena onboard audio
  dts: imx: add kosagi novena imx6q dts file

 arch/arm/boot/dts/imx6q-novena.dts | 517 +++++++++++++++++++++++++++++++
 sound/soc/codecs/Kconfig           |   4 +
 sound/soc/codecs/Makefile          |   2 +
 sound/soc/codecs/es8328.c          | 611 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/es8328.h          | 240 +++++++++++++++
 sound/soc/fsl/Kconfig              |  13 +
 sound/soc/fsl/Makefile             |   2 +
 sound/soc/fsl/imx-novena.c         | 344 +++++++++++++++++++++
 8 files changed, 1733 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h
 create mode 100644 sound/soc/fsl/imx-novena.c

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
