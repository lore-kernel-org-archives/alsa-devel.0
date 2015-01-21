From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v2 0/3] ASoC: add audio card creation from graph of ports in DT
Date: Wed, 21 Jan 2015 20:27:06 +0100
Message-ID: <cover.1421868426.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patchset adds a way to build audio cards from the description
of a graph of ports in a devicetree.

v2:
	- move the soc-core and dt-card from the patchset
		"ASoC: tda998x: add a codec to the HDMI transmitter"
	- add DT documentation (Mark Brown)

Jean-Francois Moine (3):
  ASoC: core: export snd_soc_get_dai_name
  Documentation: of: Document audio graph bindings
  ASoC: add generic dt-card support

 .../devicetree/bindings/sound/audio-interfaces.txt | 101 ++++++++
 include/sound/soc.h                                |   2 +
 sound/soc/generic/Kconfig                          |   2 +
 sound/soc/generic/Makefile                         |   2 +
 sound/soc/generic/dt-card.c                        | 275 +++++++++++++++++++++
 sound/soc/soc-core.c                               |   5 +-
 6 files changed, 385 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-interfaces.txt
 create mode 100644 sound/soc/generic/dt-card.c

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
