From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/5] ASoC: stm32: sai: miscellaneous fixes
Date: Thu, 28 Feb 2019 14:19:20 +0100
Message-ID: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set is a collection of fixes for STM32 SAI driver.

Olivier Moysan (5):
  ASoC: stm32: sai: fix iec958 controls indexation
  ASoC: stm32: sai: fix exposed capabilities in spdif mode
  ASoC: stm32: sai: fix race condition in irq handler
  ASoC: stm32: sai: fix oversampling mode
  ASoC: stm32: sai: fix set_sync service

 sound/soc/stm/stm32_sai.c     |  7 ++++---
 sound/soc/stm/stm32_sai_sub.c | 48 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.7.4
