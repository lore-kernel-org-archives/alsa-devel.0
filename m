From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] ASoC: msm8916-wcd: license and documentation fixes
Date: Thu,  7 Feb 2019 17:57:52 +0100
Message-ID: <20190207165755.1548-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series adds the missing license information to the
msm8916-wcd-analog driver and converts it's digital counterpart to SPDX.

Included is also a fix of the binding example for the analog driver.

Johan


Johan Hovold (3):
  ASoC: msm8916-wcd-analog: add missing license information
  ASoC: msm8916-wcd-digital: convert license header to SPDX
  dt-bindings: sound: msm8916-wcd-analog: fix example regulator names

 .../bindings/sound/qcom,msm8916-wcd-analog.txt      |  7 ++++---
 sound/soc/codecs/msm8916-wcd-analog.c               |  5 +++++
 sound/soc/codecs/msm8916-wcd-digital.c              | 13 +++----------
 3 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.20.1
