From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v2 0/2] ASoC: simple-card: Add multi-CODEC support
Date: Wed, 22 Oct 2014 11:10:06 +0200
Message-ID: <cover.1413969006.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch set adds multi-CODEC support to the simple card.

v2: accept list of CODECs in 'sound-dais' (Benoit Cousson)

Jean-Francois Moine (2):
  ASoC: core: add multi-codec support in DT
  ASoC: simple-card: add multi-CODECs in DT

 .../devicetree/bindings/sound/simple-card.txt      |  28 +++--
 include/sound/soc.h                                |   3 +
 sound/soc/generic/simple-card.c                    | 114 +++++++++++++--------
 sound/soc/soc-core.c                               |  75 +++++++++++---
 4 files changed, 149 insertions(+), 71 deletions(-)

-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
