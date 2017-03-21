From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/2] wm8960: Relax bit clock computation
Date: Tue, 21 Mar 2017 12:09:34 +0200
Message-ID: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shengjiu.wang@freescale.com, mihai.serban@nxp.com, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

This patch series allows playing S20_3LE .wav samples with wm8960 codec.

First patch does a small refactoring of sysclk frequency search because
wm8960_configure_sysclk was getting pretty convoluted.

The second patch allows relaxing bitclock computation in the way that
if an exact bitclk couldn't be derived from sysclk it chooses the
smalles available bitclk greater than the desired bitclk.

Changes since v1:
	* dropped the RFC tag
	* comments in each individual patch
	
Daniel Baluta (2):
  ASoC: codec: wm8960: Refactor sysclk freq search
  ASoC: codec: wm8960: Relax bit clock computation

 sound/soc/codecs/wm8960.c | 119 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 97 insertions(+), 22 deletions(-)

-- 
2.7.4
