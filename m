From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ASoC: Use snd_pcm_stop_xrun() helper
Date: Wed,  4 Jul 2018 16:01:42 +0200
Message-ID: <20180704140146.6768-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4742676E7
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:01:49 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Alexandre Torgue <alexandre.torgue@st.com>, Patrick Lai <plai@codeaurora.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of trivial fixes to replace some open codes with the
standard snd_pcm_stop_xrun() helper.  Functionally same, but it
addresses the potential stream lock issues automagically, too.


Takashi

===

Takashi Iwai (4):
  ASoC: davinci: Use snd_pcm_stop_xrun() helper
  ASoC: qcom: Use snd_pcm_stop_xrun() helper
  ASoC: sti: Use snd_pcm_stop_xrun() helper
  ASoC: stm32: Use snd_pcm_stop_xrun() helper

 sound/soc/davinci/davinci-mcasp.c | 16 ++++------------
 sound/soc/qcom/lpass-platform.c   |  2 +-
 sound/soc/sti/uniperif_player.c   |  6 +++---
 sound/soc/sti/uniperif_reader.c   |  2 +-
 sound/soc/stm/stm32_sai_sub.c     |  7 ++-----
 5 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.18.0
