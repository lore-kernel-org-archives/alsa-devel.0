From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH v2 0/2] ASoC: dwc: Add support for record mode
Date: Mon,  9 Jan 2017 13:43:26 +0000
Message-ID: <cover.1483969112.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset adds support for record mode in I2S PIO pcm
and enables 24bit transaction.

With this patchset we now have PIO support for playback and
record using only two channels, at sample rate 32k, 44.1k and
48k and sample width 16/24 and 32 bit.

Tested in a x86_64 platform and in ARC AXS101 SDP platform.

Jose Abreu (2):
  ASoC: dwc: Add record capability in PIO mode
  ASoC: dwc: Enable 24 bit sample size in PIO mode

 sound/soc/dwc/designware_i2s.c |  9 +++-
 sound/soc/dwc/designware_pcm.c | 99 +++++++++++++++++++++++++++++++++---------
 sound/soc/dwc/local.h          |  9 +++-
 3 files changed, 94 insertions(+), 23 deletions(-)

-- 
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

v2:
- Added missing cover letter

1.9.1
