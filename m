From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V3 0/4] tas571x amplifier driver
Date: Sun,  3 May 2015 17:00:15 -0700
Message-ID: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

V2->V3:

Revert earlier changes to the regcache APIs.

Change regcache_sync() so that regcache_mark_dirty() is used to indicate
that the HW was reset.  This allows tas571x (which does NOT call
regcache_mark_dirty()) to use regcache_sync() to write back any register
changes that occurred while in cache_only (tas571x pdn) mode.

One assumption here is that regcache_sync() will be called once on
resume, before any other writes.  If it fails, the no_sync_defaults flag
will be cleared and the next sync attempt, if any, will try to write
out all contents of the cache.


Kevin Cernekee (4):
  regmap: Use regcache_mark_dirty() to indicate power loss or reset
  ASoC: tas571x: Add DT binding document
  ASoC: tas571x: New driver for TI TAS571x power amplifiers
  MAINTAINERS: Add entry for tas571x ASoC codec driver

 .../devicetree/bindings/sound/tas571x.txt          |  41 ++
 MAINTAINERS                                        |   6 +
 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regcache.c                     |  61 ++-
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas571x.c                         | 520 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  33 ++
 8 files changed, 651 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt
 create mode 100644 sound/soc/codecs/tas571x.c
 create mode 100644 sound/soc/codecs/tas571x.h

-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
