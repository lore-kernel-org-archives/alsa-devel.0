From: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/10] Add support for img AXD audio hardware decoder
Date: Mon, 24 Aug 2015 13:39:09 +0100
Message-ID: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds AXD Alsa Compress Offload SoC driver.

AXD is an audio hardware based on MIPS architecture that supports decoding,
encoding, GEQ, resampling, mixing and synchronisation. At the moment only
decoding support is added in hope to add the rest of the functionality on
top of that once this is accepted.

I divided the files into separate patches by functionality in hope it'll
make the reviewing process easier. Worth noting that a lot of the cmd interface
helper funtions in patch 7 are not used yet but will be as support for more
functionality is added later.

At the moment this code has been tested on Pistachio SoC using gstreamer patched
with the code in this link

	https://bugzilla.gnome.org/show_bug.cgi?id=743192

Qais Yousef (10):
  irqchip: irq-mips-gic: export gic_send_ipi
  dt: add img,axd.txt device tree binding document
  ALSA: add AXD Audio Processing IP alsa driver
  ALSA: axd: add fw binary header manipulation files
  ALSA: axd: add buffers manipulation files
  ALSA: axd: add basic files for sending/receiving axd cmds
  ALSA: axd: add cmd interface helper functions
  ALSA: axd: add low level AXD platform setup files
  ALSA: axd: add alsa compress offload operations
  ALSA: axd: add Makefile

 .../devicetree/bindings/sound/img,axd.txt          |   34 +
 drivers/irqchip/irq-mips-gic.c                     |    1 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/img/Kconfig                              |   11 +
 sound/soc/img/Makefile                             |    1 +
 sound/soc/img/axd/Makefile                         |   13 +
 sound/soc/img/axd/axd_alsa_ops.c                   |  211 ++
 sound/soc/img/axd/axd_api.h                        |  649 ++++
 sound/soc/img/axd/axd_buffers.c                    |  243 ++
 sound/soc/img/axd/axd_buffers.h                    |   74 +
 sound/soc/img/axd/axd_cmds.c                       |  102 +
 sound/soc/img/axd/axd_cmds.h                       |  532 ++++
 sound/soc/img/axd/axd_cmds_config.c                | 1235 ++++++++
 sound/soc/img/axd/axd_cmds_decoder_config.c        |  422 +++
 sound/soc/img/axd/axd_cmds_info.c                  | 1249 ++++++++
 sound/soc/img/axd/axd_cmds_internal.c              | 3264 ++++++++++++++++++++
 sound/soc/img/axd/axd_cmds_internal.h              |  317 ++
 sound/soc/img/axd/axd_cmds_pipes.c                 | 1387 +++++++++
 sound/soc/img/axd/axd_hdr.c                        |   64 +
 sound/soc/img/axd/axd_hdr.h                        |   24 +
 sound/soc/img/axd/axd_module.c                     |  742 +++++
 sound/soc/img/axd/axd_module.h                     |   83 +
 sound/soc/img/axd/axd_platform.h                   |   35 +
 sound/soc/img/axd/axd_platform_mips.c              |  416 +++
 25 files changed, 11111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,axd.txt
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/axd/Makefile
 create mode 100644 sound/soc/img/axd/axd_alsa_ops.c
 create mode 100644 sound/soc/img/axd/axd_api.h
 create mode 100644 sound/soc/img/axd/axd_buffers.c
 create mode 100644 sound/soc/img/axd/axd_buffers.h
 create mode 100644 sound/soc/img/axd/axd_cmds.c
 create mode 100644 sound/soc/img/axd/axd_cmds.h
 create mode 100644 sound/soc/img/axd/axd_cmds_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_decoder_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_info.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.h
 create mode 100644 sound/soc/img/axd/axd_cmds_pipes.c
 create mode 100644 sound/soc/img/axd/axd_hdr.c
 create mode 100644 sound/soc/img/axd/axd_hdr.h
 create mode 100644 sound/soc/img/axd/axd_module.c
 create mode 100644 sound/soc/img/axd/axd_module.h
 create mode 100644 sound/soc/img/axd/axd_platform.h
 create mode 100644 sound/soc/img/axd/axd_platform_mips.c

Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
