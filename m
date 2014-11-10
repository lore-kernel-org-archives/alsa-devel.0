From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v4 0/4] ASoC: simple-card: Add multi-CODEC support
Date: Mon, 10 Nov 2014 08:48:36 +0100
Message-ID: <cover.1415605716.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch set adds multi-CODEC support to the simple card.

v4: (Mark Brown)
	- document the new core function
	- calculation of the number of codecs moved to the core function
	- split the patch about simple-card.c
	- less code changes
	- remove the cast of pointers
	- less changes in the DT binding example 2
v3: rebase on broonie git 2014/11/03
v2: accept list of CODECs in 'sound-dais' (Benoit Cousson)

Jean-Francois Moine (4):
  ASoC: core: add multi-codec support in DT
  ASoC: simple-card: Remove useless function argument
  ASoC: simple-card: add multi-CODECs in DT
  ASoC: simple-card: Remove useless check

 .../devicetree/bindings/sound/simple-card.txt      |  20 ++--
 include/sound/soc.h                                |   3 +
 sound/soc/generic/simple-card.c                    |  87 ++++++++--------
 sound/soc/soc-core.c                               | 113 ++++++++++++++++++---
 4 files changed, 154 insertions(+), 69 deletions(-)

-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
