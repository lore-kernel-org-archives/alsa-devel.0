From: Olivier Moysan <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH 0/7] ASoC: stm32: Add SAI
	synchronization support
Date: Thu, 19 Oct 2017 15:03:16 +0200
Message-ID: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B0B54266DB1
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 15:03:31 +0200 (CEST)
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
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set adds support of synchronization features for SAI interface.
It also adds minor fixes and improvements.

Olivier Moysan (7):
  ASoC: stm32: Add synchronization to SAI bindings
  ASoC: stm32: sai: Move static settings to DAI init
  ASoC: stm32: sai: Fix DMA burst size
  ASoC: stm32: sai: fix stop management in isr
  ASoC: stm32: sai: Remove spurious IRQs on stop
  ASoC: stm32: sai: Fix get reset controller
  ASoC: stm32: sai: Add synchronization support

 .../devicetree/bindings/sound/st,stm32-sai.txt     |  14 +-
 sound/soc/stm/stm32_sai.c                          | 162 ++++++++++++++++++++-
 sound/soc/stm/stm32_sai.h                          |  22 ++-
 sound/soc/stm/stm32_sai_sub.c                      | 156 +++++++++++++++++---
 4 files changed, 318 insertions(+), 36 deletions(-)

-- 
1.9.1
