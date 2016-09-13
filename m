From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [[alsa-devel][Patch] 0/2] ASoC sti: suppress inappropriate DT fields
Date: Tue, 13 Sep 2016 09:58:22 +0200
Message-ID: <1473753504-20179-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Aim of this patchset is to clean some "dirty" fields in devicetree. 
As Values are linked to the chip version and the IP usage, 
they can be handled by device data associated to the compatibility string.


Arnaud Pouliquen (2):
  ASoC: sti: suppress inappropriate DT fields
  Documentation: dt-bindings: suppress inappropriate fields for sti
    sound card

 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  52 +++------
 sound/soc/sti/sti_uniperif.c                       | 130 +++++++++++++++++----
 sound/soc/sti/uniperif.h                           |  28 ++---
 sound/soc/sti/uniperif_player.c                    |  79 +++----------
 sound/soc/sti/uniperif_reader.c                    |  46 +-------
 5 files changed, 156 insertions(+), 179 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
