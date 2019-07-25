From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/6] ASoC: improve codec to codec link support
Date: Thu, 25 Jul 2019 18:59:43 +0200
Message-ID: <20190725165949.29699-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

As explained in this previous series [0], on Amlogic, we are using codec to
codec links to deal with the glue which is between the i2s backends and the
synopsys hdmi controller.

This worked well until I tried to .get_eld() support in the dw-hdmi-i2s
driver.  Doing so adds channel mapping controls to the codec. This shown
several problem

1) .pcm_new() is not called on codec to codec links.
   struct snd_soc_pcm_runtime do not even have a valid .pcm
2) struct snd_pcm_substream and struct snd_pcm_runtime are ephemeral
   This is a problem if a control needs to access them

The goal of this patchset is to resolve the above issues and improve the
codec to codec link support enough to correctly handle the hdmi-codec

The support of these codec to codec links could probably be improved in the
future to behave like any other link and use soc_pcm_open(),
soc_pcm_hw_params(), etc...

The challenge lies in the dapm mutex. The soc_pcm call dapm function locking
this mutex but the dapm mutex is already held in snd_soc_dai_link_event()

Changes since v1 [1]:
* Fix rebase on Murimoto-san's patches
* Allocate params dynamically again and refactor the pre_pmu code to
  simplify the error handling and rollback a bit

[0]: https://lkml.kernel.org/r/20190515131858.32130-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20190724162405.6574-1-jbrunet@baylibre.com

Jerome Brunet (6):
  ASoC: codec2codec: run callbacks in order
  ASoC: codec2codec: name link using stream direction
  ASoC: codec2codec: deal with params when necessary
  ASoC: create pcm for codec2codec links as well
  ASoC: codec2codec: remove ephemeral variables
  ASoC: codec2codec: fill some of the runtime stream parameters

 sound/soc/soc-core.c |  42 +++------
 sound/soc/soc-dapm.c | 220 +++++++++++++++++++++++++++----------------
 sound/soc/soc-pcm.c  |  35 ++++++-
 3 files changed, 182 insertions(+), 115 deletions(-)

-- 
2.21.0
