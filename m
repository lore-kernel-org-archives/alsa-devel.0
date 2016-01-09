From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: [RFC PATCH 0/3] ASoC: pcm1792a: Add support for pcm1795 and pcm1796
Date: Sun, 10 Jan 2016 00:38:02 +0100
Message-ID: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Those patches add support for pcm1795 and pcm1796. Both are
compatible with the pcm1792a with a minor change for the
pcm1795

Michael Trimarchi (3):
  ASoC: pcm1792a: Rename internal data and function to pcm179x
  ASoC: pcm1792a: Rename pcm1792a to pcm179x
  ASoC: pcm179x: Add support for pcm1795 and pcm1796

 .../devicetree/bindings/sound/pcm1792a.txt         |  18 --
 .../devicetree/bindings/sound/pcm179x.txt          |  18 ++
 sound/soc/codecs/Kconfig                           |   6 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/pcm1792a.c                        | 271 ------------------
 sound/soc/codecs/pcm1792a.h                        |  27 --
 sound/soc/codecs/pcm179x.c                         | 314 +++++++++++++++++++++
 sound/soc/codecs/pcm179x.h                         |  31 ++
 8 files changed, 368 insertions(+), 321 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/pcm179x.txt
 delete mode 100644 sound/soc/codecs/pcm1792a.c
 delete mode 100644 sound/soc/codecs/pcm1792a.h
 create mode 100644 sound/soc/codecs/pcm179x.c
 create mode 100644 sound/soc/codecs/pcm179x.h

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
