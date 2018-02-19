From: Olivier Moysan <olivier.moysan@st.com>
Subject: [RFC PATCH 0/3] ASoC: stm32: add S/PDIF support to SAI
Date: Mon, 19 Feb 2018 16:00:34 +0100
Message-ID: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 75CE1267396
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 16:00:42 +0100 (CET)
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

This patch-set adds S/PDIF IEC6958 protocol support to STM32 SAI.
Only S/PDIF playback is supported here, as SAI peripheral does not support S/PDIF capture.

SAI peripheral does not take as input full IEC60958 frames as it generates preamble and parity bit.
However, it cannot handle raw PCM data, as it is not designed to insert channel status and user data
in the generated IEC frames.

Moreover, SAI data register format does not match exactly IEC60958 subframe format.
(see figure below). Channel status (C) and User data (U) are at 26-25 bits position,
in data register, instead of 30-29 bits position.
    
IEC60958 subframe bits:
31-28                       27-4                         3-0
P    C    U    V            data (16|24 bits)            preamble

SAI data register format:
27-24                        23-0						
P     C    U    V            data (16|24 bits)

The impact in software is that the data have to be processed before DMA transfer.
These constraints should be managed at driver level to minimize the impact on application.
This means that a callback is necessary to perform data processing (shift and channel status insertion)

This patch-set introduces a callback to allow processing on samples.
The implementation is based on previous discussions available here:
https://patchwork.kernel.org/patch/9570255/

BRs
Olivier

Olivier Moysan (3):
  ASoC: stm32: Add S/PDIF to SAI bindings
  ASoC: dmaengine_pcm: add processing support
  ASoC: stm32: sai: Add support of S/PDIF playback

 .../devicetree/bindings/sound/st,stm32-sai.txt     |   6 +
 include/sound/dmaengine_pcm.h                      |   3 +
 sound/soc/soc-generic-dmaengine-pcm.c              |  62 ++++++++-
 sound/soc/stm/stm32_sai.c                          |   2 +
 sound/soc/stm/stm32_sai.h                          |   2 +
 sound/soc/stm/stm32_sai_sub.c                      | 153 +++++++++++++++++----
 6 files changed, 202 insertions(+), 26 deletions(-)

-- 
1.9.1
