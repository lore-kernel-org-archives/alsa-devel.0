From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 00/15] ASoC: meson: add axg audio subsystem support
Date: Tue, 17 Jul 2018 17:36:24 +0200
Message-ID: <20180717153643.8806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the audio subsystem found on Amlogic's
axg SoC family. The first SoC of this family is the A113D/X targeted
at smart speaker application. The G12a SoC family, Amlogic next-gen
STB chipset, will reuse this audio subsystem with a few changes.

This patchset implements the DPCM machine driver and the different
components it made of. Several components are still missing, such
spdif input and pdm, and will submitted later on.

The fancier part of this patchset is probably around the TDM. Properly
modeling the SoC architecture and its capatilities made things a little
more complex than usual (details in the related commit descriptions)

If necessary, this patchset could broken into smaller series. For the
intial submission, I wanted to give a global view of the subsystem.
Hopefully, it will make it a bit easier to understand.

Jerome Brunet (15):
  ASoC: meson: add axg fifos DT binding documentation
  ASoC: meson: add axg fifo base driver
  ASoC: meson: add axg frddr driver
  ASoC: meson: add axg toddr driver
  ASoC: meson: add axg spdif output DT bindings documentation
  ASoC: meson: add axg spdif output
  ASoC: meson: add axg tdm formatters DT bindings documentation
  ASoC: meson: add axg tdm interface DT bindings documentation
  ASoC: meson: add tdm formatter base driver
  ASoC: meson: add tdm interface driver
  ASoC: meson: add tdm output driver
  ASoC: meson: add tdm input driver
  ASoC: export snd_soc_of_get_slot_mask
  ASoC: meson: add axg sound card DT bindings documentation
  ASoC: meson: add axg sound card support

 .../devicetree/bindings/sound/amlogic,axg-fifo.txt |  23 +
 .../bindings/sound/amlogic,axg-sound-card.txt      | 124 ++++
 .../bindings/sound/amlogic,axg-spdifout.txt        |  20 +
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  |  28 +
 .../bindings/sound/amlogic,axg-tdm-iface.txt       |  22 +
 include/sound/soc.h                                |   3 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/meson/Kconfig                            |  64 ++
 sound/soc/meson/Makefile                           |  21 +
 sound/soc/meson/axg-card.c                         | 671 +++++++++++++++++++++
 sound/soc/meson/axg-fifo.c                         | 341 +++++++++++
 sound/soc/meson/axg-fifo.h                         |  80 +++
 sound/soc/meson/axg-frddr.c                        | 141 +++++
 sound/soc/meson/axg-spdifout.c                     | 456 ++++++++++++++
 sound/soc/meson/axg-tdm-formatter.c                | 381 ++++++++++++
 sound/soc/meson/axg-tdm-formatter.h                |  39 ++
 sound/soc/meson/axg-tdm-interface.c                | 542 +++++++++++++++++
 sound/soc/meson/axg-tdm.h                          |  78 +++
 sound/soc/meson/axg-tdmin.c                        | 229 +++++++
 sound/soc/meson/axg-tdmout.c                       | 259 ++++++++
 sound/soc/meson/axg-toddr.c                        | 199 ++++++
 sound/soc/soc-core.c                               |   7 +-
 23 files changed, 3727 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 sound/soc/meson/Kconfig
 create mode 100644 sound/soc/meson/Makefile
 create mode 100644 sound/soc/meson/axg-card.c
 create mode 100644 sound/soc/meson/axg-fifo.c
 create mode 100644 sound/soc/meson/axg-fifo.h
 create mode 100644 sound/soc/meson/axg-frddr.c
 create mode 100644 sound/soc/meson/axg-spdifout.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.h
 create mode 100644 sound/soc/meson/axg-tdm-interface.c
 create mode 100644 sound/soc/meson/axg-tdm.h
 create mode 100644 sound/soc/meson/axg-tdmin.c
 create mode 100644 sound/soc/meson/axg-tdmout.c
 create mode 100644 sound/soc/meson/axg-toddr.c

-- 
2.14.4
