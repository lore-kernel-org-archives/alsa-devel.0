From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v4 0/6] VAG power control improvement for sgtl5000 codec
Date: Wed, 17 Jul 2019 16:30:38 +0000
Message-ID: <20190717163014.429-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
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

Changes in v4:
- CC the patch to kernel-stable
- Code optimization, simplify function signature
  (thanks to Cezary Rojewski <cezary.rojewski@intel.com> for an idea)
- CC the patch to kernel-stable
- Add a Fixes tag

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message
- Add the reference to NXP SGTL5000 data sheet to commit message
- Fix multi-line comment format

Changes in v2:
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting
- Fix patch formatting

Oleksandr Suvorov (6):
  ASoC: Define a set of DAPM pre/post-up events
  ASoC: sgtl5000: Improve VAG power and mute control
  ASoC: sgtl5000: Fix definition of VAG Ramp Control
  ASoC: sgtl5000: add ADC mute control
  ASoC: sgtl5000: Fix of unmute outputs on probe
  ASoC: sgtl5000: Fix charge pump source assignment

 include/sound/soc-dapm.h    |   2 +
 sound/soc/codecs/sgtl5000.c | 240 ++++++++++++++++++++++++++++++------
 sound/soc/codecs/sgtl5000.h |   2 +-
 3 files changed, 203 insertions(+), 41 deletions(-)

--=20
2.20.1
