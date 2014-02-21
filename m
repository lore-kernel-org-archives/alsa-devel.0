From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH 0/4] ASoC: simple-card: DT fix and multi DAI links extension
Date: Fri, 21 Feb 2014 16:12:46 +0100
Message-ID: <cover.1392995566.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch series fixes a small problem about node device locks and also
extends the simple card driver to handle many DAI links as this exists
in the Cubox audio subsystem.

Jean-Francois Moine (4):
  ASoC: simple-card: Fix device node locks
  ASoC: simple-card: dynamically allocate the DAI link array
  ASoC: simple-card: accept many DAI links
  ASoC: simple-card: add DT documentation for multi-DAI links

 .../devicetree/bindings/sound/simple-card.txt      |  34 ++++-
 sound/soc/generic/simple-card.c                    | 148 +++++++++++++++------
 2 files changed, 137 insertions(+), 45 deletions(-)

-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
