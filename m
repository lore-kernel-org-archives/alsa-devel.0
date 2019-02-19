From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] ASoC: Fix of-node refcount unbalance
Date: Tue, 19 Feb 2019 16:46:46 +0100
Message-ID: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 23FAC26552B
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:46:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset covering the OF-node refcount problem on a few ASoC
drivers.


thanks,

Takashi

===

Takashi Iwai (6):
  ASoC: fsl: Fix of-node refcount unbalance in fsl_ssi_probe_from_dt()
  ASoC: simple-card: Fix missing of_node_put() at simple_dai_link_of()
  ASoC: simple-card: Fix of-node refcount unbalance in DAI-link parser
  ASoC: qcom: Fix of-node refcount unbalance in apq8016_sbc_parse_of()
  ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()
  ASoC: samsung: Fix of-node refcount unbalance in odroid_audio_probe()

 sound/soc/fsl/fsl_ssi.c         |  6 ++++--
 sound/soc/generic/simple-card.c | 19 +++++++++++++------
 sound/soc/qcom/apq8016_sbc.c    | 21 ++++++++++++++++-----
 sound/soc/qcom/common.c         | 10 ++++++++--
 sound/soc/samsung/odroid.c      |  5 +++--
 5 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.16.4
