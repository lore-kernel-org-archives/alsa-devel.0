From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v3 0/6] VAG power control improvement for sgtl5000 codec
Date: Fri, 12 Jul 2019 14:55:58 +0000
Message-ID: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


VAG power control is improved to fit the manual [1]. This patchset fixes as
minimum one bug: if customer muxes Headphone to Line-In right after boot,
the VAG power remains off that leads to poor sound quality from line-in.

I.e. after boot:
- Connect sound source to Line-In jack;
- Connect headphone to HP jack;
- Run following commands:
$ amixer set 'Headphone' 80%
$ amixer set 'Headphone Mux' LINE_IN

Also this series includes fixes of non-important bugs in sgtl5000 codec
driver.

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message
- Fix multi-line comment format
- Add the reference to NXP SGTL5000 data sheet to commit message

Changes in v2:
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting

Oleksandr Suvorov (6):
  ASoC: sgtl5000: Fix definition of VAG Ramp Control
  ASoC: sgtl5000: add ADC mute control
  ASoC: sgtl5000: Fix of unmute outputs on probe
  ASoC: sgtl5000: Fix charge pump source assignment
  ASoC: Define a set of DAPM pre/post-up events
  ASoC: sgtl5000: Improve VAG power and mute control

 include/sound/soc-dapm.h    |   2 +
 sound/soc/codecs/sgtl5000.c | 251 ++++++++++++++++++++++++++++++------
 sound/soc/codecs/sgtl5000.h |   2 +-
 3 files changed, 213 insertions(+), 42 deletions(-)

--=20
2.20.1
