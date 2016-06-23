From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/6] Sound support for Exynos5433 TM2(E) boards
Date: Thu, 23 Jun 2016 12:45:09 +0200
Message-ID: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds sound supoort for the Exynos 5433 based TM2 and
TM2E board.  It includes minimal drivers for the Low Power Audio Subsystem
(LPASS) and the MAX98504 class D speaker amplifier as well as the actual
asoc machine driver.
The changes are listed in individual patches, there were only v1 3/6,
4/6 patches (max98504), for others I skipped from RFC to v2.

Inha Song (2):
  ASoC: samsung: Add Samsung Low Power Audio Subsystem driver
  ASoC: samsung: Add machine driver for Exynos5433 based TM2 board

Sylwester Nawrocki (4):
  ASoC: samsung: Add DT bindings documentation for LPASS
  ASoC: Add DT bindings documentation for max98504 amplifier
  ASoC: max98504: Add max98504 speaker amplifier driver
  ASoC: samsung: Add DT bindings documentation for TM2 sound subsystem

 .../devicetree/bindings/sound/max98504.txt         |  26 +
 .../bindings/sound/samsung,exynos5433-lpass.txt    |   8 +
 .../bindings/sound/samsung,tm2-audio.txt           |  36 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max98504.c                        | 356 +++++++++++++
 sound/soc/codecs/max98504.h                        |  76 +++
 sound/soc/samsung/Kconfig                          |  13 +
 sound/soc/samsung/Makefile                         |   4 +
 sound/soc/samsung/lpass.c                          | 162 ++++++
 sound/soc/samsung/lpass.h                          |  47 ++
 sound/soc/samsung/tm2_wm5110.c                     | 579 +++++++++++++++++++++
 12 files changed, 1313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98504.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,exynos5433-lpass.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
 create mode 100644 sound/soc/codecs/max98504.c
 create mode 100644 sound/soc/codecs/max98504.h
 create mode 100644 sound/soc/samsung/lpass.c
 create mode 100644 sound/soc/samsung/lpass.h
 create mode 100644 sound/soc/samsung/tm2_wm5110.c

--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
