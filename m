From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/2] sgtl5000: Add controls for MicBias in DT
Date: Tue, 14 Oct 2014 08:43:10 +0200
Message-ID: <1413268992-15248-1-git-send-email-jean-michel.hautbois@vodalys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This serie adds two simple controls on resistor and voltage for MicBias.

Jean-Michel Hautbois (2):
  audio: sgtl5000: Add MicBias resistor support in DT
  audio: sgtl5000: Add MicBias voltage support

 .../devicetree/bindings/sound/sgtl5000.txt         | 13 +++++
 sound/soc/codecs/sgtl5000.c                        | 68 ++++++++++++++++++++--
 2 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
