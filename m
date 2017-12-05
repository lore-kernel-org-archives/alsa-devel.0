From: "Andrew F. Davis" <afd@ti.com>
Subject: [RFC PATCH 0/3] Add ASoC platforms directory
Date: Tue, 5 Dec 2017 12:14:45 -0600
Message-ID: <20171205181448.18513-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello all,

The first patch, I think, sums up well what I'm trying to do
here with this series. The last two are a couple examples
of what the moving would look like.

The very end result would look something like:

soc/
|_codecs/
  |_codecs*.c
|_platforms/
  |_adi/
    |_adi_i2s.c
    |_...
  |_amd/
  |_.../
|_machines/
  |_amd/
    |_acp-rt5645.c
    |_...
  |_atmel/
  |_.../
|_core_files*.c

I would like to think the churn is minimal for this as git
seems to handles renaming like this rather well, but I guess that
is up to the maintainers. :)

Thanks for your comments,
Andrew

Andrew F. Davis (3):
  ASoC: Add platforms directory
  ASoC: Platforms: Move Davinci platform drivers into platforms
    directory
  ASoC: Platforms: Move OMAP platform drivers into platforms directory

 MAINTAINERS                                       |  1 +
 sound/soc/Kconfig                                 |  3 ++
 sound/soc/Makefile                                |  1 +
 sound/soc/davinci/Kconfig                         | 37 -----------------------
 sound/soc/davinci/Makefile                        | 21 +++----------
 sound/soc/omap/Kconfig                            | 29 ------------------
 sound/soc/omap/Makefile                           | 13 --------
 sound/soc/omap/am3517evm.c                        |  2 +-
 sound/soc/omap/ams-delta.c                        |  2 +-
 sound/soc/omap/n810.c                             |  2 +-
 sound/soc/omap/omap-abe-twl6040.c                 |  4 +--
 sound/soc/omap/omap-twl4030.c                     |  2 +-
 sound/soc/omap/omap3pandora.c                     |  2 +-
 sound/soc/omap/osk5912.c                          |  2 +-
 sound/soc/omap/rx51.c                             |  2 +-
 sound/soc/platforms/Kconfig                       | 10 ++++++
 sound/soc/platforms/Makefile                      |  4 +++
 sound/soc/platforms/davinci/Kconfig               | 36 ++++++++++++++++++++++
 sound/soc/{ => platforms}/davinci/Makefile        |  5 ---
 sound/soc/{ => platforms}/davinci/davinci-i2s.c   |  0
 sound/soc/{ => platforms}/davinci/davinci-i2s.h   |  0
 sound/soc/{ => platforms}/davinci/davinci-mcasp.c |  0
 sound/soc/{ => platforms}/davinci/davinci-mcasp.h |  0
 sound/soc/{ => platforms}/davinci/davinci-vcif.c  |  0
 sound/soc/{ => platforms}/davinci/edma-pcm.c      |  0
 sound/soc/{ => platforms}/davinci/edma-pcm.h      |  0
 sound/soc/platforms/omap/Kconfig                  | 28 +++++++++++++++++
 sound/soc/platforms/omap/Makefile                 | 13 ++++++++
 sound/soc/{ => platforms}/omap/mcbsp.c            |  0
 sound/soc/{ => platforms}/omap/mcbsp.h            |  0
 sound/soc/{ => platforms}/omap/omap-dmic.c        |  0
 sound/soc/{ => platforms}/omap/omap-dmic.h        |  0
 sound/soc/{ => platforms}/omap/omap-hdmi-audio.c  |  0
 sound/soc/{ => platforms}/omap/omap-mcbsp.c       |  0
 sound/soc/{ => platforms}/omap/omap-mcbsp.h       |  0
 sound/soc/{ => platforms}/omap/omap-mcpdm.c       |  0
 sound/soc/{ => platforms}/omap/omap-mcpdm.h       |  0
 sound/soc/{ => platforms}/omap/omap-pcm.c         |  0
 38 files changed, 110 insertions(+), 109 deletions(-)
 rewrite sound/soc/davinci/Makefile (71%)
 create mode 100644 sound/soc/platforms/Kconfig
 create mode 100644 sound/soc/platforms/Makefile
 create mode 100644 sound/soc/platforms/davinci/Kconfig
 copy sound/soc/{ => platforms}/davinci/Makefile (76%)
 rename sound/soc/{ => platforms}/davinci/davinci-i2s.c (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-i2s.h (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-mcasp.c (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-mcasp.h (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-vcif.c (100%)
 rename sound/soc/{ => platforms}/davinci/edma-pcm.c (100%)
 rename sound/soc/{ => platforms}/davinci/edma-pcm.h (100%)
 create mode 100644 sound/soc/platforms/omap/Kconfig
 create mode 100644 sound/soc/platforms/omap/Makefile
 rename sound/soc/{ => platforms}/omap/mcbsp.c (100%)
 rename sound/soc/{ => platforms}/omap/mcbsp.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-dmic.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-dmic.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-hdmi-audio.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcbsp.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcbsp.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcpdm.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcpdm.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-pcm.c (100%)

-- 
2.15.0
