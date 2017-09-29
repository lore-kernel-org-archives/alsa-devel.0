From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 0/2] Fix first detection issue with headset
Date: Fri, 29 Sep 2017 13:42:44 -0400
Message-ID: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

This series fix an issue with headset being misidentified on the very
first time a device is plugged in by calling the function that
configures the bias when the MBHC is setup.

I've split this series into two patches because pm8916_wcd_setup_mbhc
needs to be moved a few lines below to avoid forward declaring it. It is
overkill but that was not part of the code snippet that Srinivas acked,
and I wanted to be extra sure not to misattribute an Acked-by.

Damien Riegel (2):
  ASoC: codecs: msm8916-wcd-analog: move pm8916_wcd_setup_mbhc
  ASoC: codecs: msm8916-wcd-analog: configure micbias in mbhc setup

 sound/soc/codecs/msm8916-wcd-analog.c | 94 +++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 44 deletions(-)

-- 
2.14.1
