From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH V2 0/2] ASoC: max98090/max98095: Add master clock handing
Date: Mon, 26 May 2014 13:58:20 +0530
Message-ID: <1401092902-20525-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: tiwai@suse.de, perex@perex.cz, broonie@kernel.org, dianders@chromium.org, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

These CODECs are used on Snow/Peach-pit boards and the master clock
needs to be set at 24MHz.

Adding support in respective codec drivers so that we can update the
master clock frequency from sound card driver through set_sysclk.

Changes for V2:
1. Added PROBE_DEFER if clock driver has not yet been probed
2. Moved clk_prepare_enable from .probe to .set_bias_level
3. Moved clk_disable_unprepare from .remove to .set_bias_level

Tushar Behera (2):
  ASoC: max98090: Add master clock handling
  ASoC: max98095: Add master clock handling

 .../devicetree/bindings/sound/max98090.txt         |    6 +++++
 .../devicetree/bindings/sound/max98095.txt         |    6 +++++
 sound/soc/codecs/max98090.c                        |   23 +++++++++++++++++++
 sound/soc/codecs/max98090.h                        |    1 +
 sound/soc/codecs/max98095.c                        |   24 ++++++++++++++++++++
 5 files changed, 60 insertions(+)

-- 
1.7.9.5
