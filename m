From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] ASoC: Make set_tdm_slot() semantics
	consistent
Date: Sat, 10 Jan 2015 11:52:33 +0100
Message-ID: <1420887157-18593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-105.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id CA7C2260698
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 11:52:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This is something we shortly discussed during the ALSA mini conference in
Duesseldorf last year. We want to do more useful stuff with the
snd_soc_set_tdm_slot() API and build generic infrastructure on top of it.
But there are currently two different incompatible semantics of how the
tx_mask and rx_mask parameters of snd_soc_dai_set_tdm_slot() are used. If we
want to be able to use the API in a generic way we need to fix this
inconsistency. Both interpretations agree that the slot masks should be
represented as bitmasks which bit 0 representing the first slot, bit 1 the
second slot and so on. But where they differ is in the meaning of value of
the bit. Some implementations assume that if a bit is set the channel is
enabled and if the bit is cleared the channel is disabled, others have
inverse semantics, they assume that if a bit is cleared the channel is
enabled and if the bit is set the channel is disabled.

The former is used by most drivers and later is only used by some the
Freescale DAI drivers and the MC13783 CODEC driver. This appears to be a
result of Freescale DAI drivers directly passing the masks through to the
registers which expect the inverted semantics. And the MC13783 appears to
have picked up the same meaning since it is used on a board which has a
Freescale DAI on the CPU side of the DAI link.

This series updates the MC13783 and Freescale DAI drivers to use the same
semantics as other drivers and also updates the documentation of the
snd_soc_dai_set_tdm_slot() function to be more specific on the intended
semantics.

- Lars

Lars-Peter Clausen (4):
  ASoC: mc13783: Update set_tdm_slot() semantics
  ASoC: fsl: Update set_tdm_slot() semantics
  ASoC: fsl: Remove fsl_asoc_xlate_tdm_slot_mask()
  ASoC: Update snd_soc_dai_set_tdm_slot() documentation

 sound/soc/codecs/mc13783.c    | 10 +++++-----
 sound/soc/fsl/eukrea-tlv320.c |  2 +-
 sound/soc/fsl/fsl_esai.c      |  3 +++
 sound/soc/fsl/fsl_ssi.c       |  4 ++--
 sound/soc/fsl/fsl_utils.c     | 27 ---------------------------
 sound/soc/fsl/fsl_utils.h     |  3 ---
 sound/soc/fsl/imx-mc13783.c   |  5 ++---
 sound/soc/fsl/imx-ssi.c       |  5 ++---
 sound/soc/fsl/wm1133-ev1.c    |  4 ++--
 sound/soc/soc-core.c          | 20 ++++++++++++++++----
 10 files changed, 33 insertions(+), 50 deletions(-)

-- 
1.8.0
