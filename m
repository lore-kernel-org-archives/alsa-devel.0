From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 0/7 linux-next] sound: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:55 +0100
Message-ID: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This small patchset adds const to of_device_id arrays in
sound branch.

Fabian Frederick (7):
  ALSA: aoa: constify of_device_id array
  ASoC: fsl: constify of_device_id array
  ASoC: kirkwood: constify of_device_id array
  ASoC: rt5631: constify of_device_id array
  ASoC: ak4554: constify of_device_id array
  ASoC: fsi: constify of_device_id array
  ASoC: rsnd: constify of_device_id array

 sound/aoa/soundbus/i2sbus/core.c    | 2 +-
 sound/soc/codecs/ak4554.c           | 2 +-
 sound/soc/codecs/rt5631.c           | 2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c    | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c     | 2 +-
 sound/soc/fsl/pcm030-audio-fabric.c | 2 +-
 sound/soc/kirkwood/kirkwood-i2s.c   | 2 +-
 sound/soc/sh/fsi.c                  | 4 ++--
 sound/soc/sh/rcar/core.c            | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1
