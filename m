From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] ASoC: msm8916-wcd: license and documentation fixes
Date: Fri,  8 Feb 2019 16:16:54 +0100
Message-ID: <20190208151656.26735-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series adds the missing license information to the
msm8916-wcd-analog driver and converts it's digital counterpart to SPDX.

Johan

v2
 - drop the now applied binding doc update
 - switch to c++ comments also for the copyright headers for consistency
   with the ASoC style


Johan Hovold (2):
  ASoC: msm8916-wcd-analog: add missing license information
  ASoC: msm8916-wcd-digital: convert license header to SPDX

 sound/soc/codecs/msm8916-wcd-analog.c  |  3 +++
 sound/soc/codecs/msm8916-wcd-digital.c | 13 ++-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.20.1
