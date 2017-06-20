From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v2 0/2] ASoC: stm32: add SPDIFRX driver
Date: Tue, 20 Jun 2017 11:58:45 +0200
Message-ID: <1497952727-16720-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 68CC126680F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 11:58:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

This patch-set handles the SPDIFRX on STM32 platforms.

The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
IEC-60958 and IEC-61937 standards.

SPDIFRX uses two DMA channels:
- one DMA channel for S/PDIF data stream.
- one DMA channel for control flow (channel status and user data bits).

DMA is used for control flow instead of interrupts to get better performances,
as channel status and user data are retrieved byte per byte.

v1 -> v2:
- fix merge issue

olivier moysan (2):
  ASoC: stm32: Add DT bindings for SPDIFRX interface
  ASoC: stm32: Add SPDIFRX support

 .../devicetree/bindings/sound/st,stm32-spdifrx.txt |  56 ++
 sound/soc/stm/Kconfig                              |  10 +
 sound/soc/stm/Makefile                             |   4 +
 sound/soc/stm/stm32_spdifrx.c                      | 998 +++++++++++++++++++++
 4 files changed, 1068 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
 create mode 100644 sound/soc/stm/stm32_spdifrx.c

-- 
1.9.1
