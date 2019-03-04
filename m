From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: dfsdm: fixes
Date: Mon, 4 Mar 2019 15:52:42 +0100
Message-ID: <1551711165-28684-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set provides the following fixes for STM32 DFSDM:
- manage multiple prepare
- fix debugfs warnings on entry creation
- add mmap support

Olivier Moysan (3):
  ASoC: stm32: dfsdm: manage multiple prepare
  ASoC: stm32: dfsdm: fix debugfs warnings on entry creation
  ASoC: stm32: dfsdm: add mmap support

 sound/soc/stm/stm32_adfsdm.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.7.4
