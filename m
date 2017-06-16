From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: sai: Add H7 support
Date: Fri, 16 Jun 2017 14:16:22 +0200
Message-ID: <1497615384-7407-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set adds support of the Serial Audio Interface (SAI) IP on H7 STM32 platform family.

olivier moysan (2):
  dt-bindings: stm32: add h7 support for sai
  ASoC: stm32: sai: add h7 support

 .../devicetree/bindings/sound/st,stm32-sai.txt     | 18 ++---
 sound/soc/stm/stm32_sai.c                          | 13 ++-
 sound/soc/stm/stm32_sai.h                          | 72 +++++++++++++++--
 sound/soc/stm/stm32_sai_sub.c                      | 92 ++++++++++++++++++----
 4 files changed, 164 insertions(+), 31 deletions(-)

-- 
1.9.1
