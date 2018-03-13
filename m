From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: sai: add support of iec958
	controls
Date: Tue, 13 Mar 2018 17:27:05 +0100
Message-ID: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DD91267172
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 17:27:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: jsarha@ti.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

This patchset adds support of iec958 controls to STM32 SAI driver.

The patch makes use of iec958 control status helpers previously proposed
and discussed through the following threads:
https://patchwork.kernel.org/patch/8062601/
https://patchwork.kernel.org/patch/8091551/ (v2)
https://patchwork.kernel.org/patch/8462961/ (v3)
https://patchwork.kernel.org/patch/8533731/ (v4)

Olivier Moysan (3):
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: stm32: sai: add iec958 controls support
  ASoC: dmaengine_pcm: document process callback

 include/sound/dmaengine_pcm.h |   2 +
 include/sound/pcm_iec958.h    |  19 +++++++
 sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
 5 files changed, 225 insertions(+), 12 deletions(-)

-- 
1.9.1
