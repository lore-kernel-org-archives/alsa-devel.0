From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/6] ASoC: Fix sparse warnings
Date: Mon, 27 Jul 2015 10:56:22 +0200
Message-ID: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 559C32606B5
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series fixes a couple of sparse warnings that have appeared recently
in the ASoC tree. Non of them are critical mostly just missing annotations
or storage qualifiers. It still makes sense to fix those though since it
reduces the noise that has to be filtered through when checking new code
for new (potentially critical) warnings.

- Lars

Lars-Peter Clausen (6):
  ASoC: wm8804: Drop dublicate const
  ASoC: lpass-ipq806x: Staticise local symbols
  ASoC: rcar ctu: Staticise local symbols
  ASoC: uniperf: Add missing __iomem annotation
  ASoC: uniperf: Staticise local symbols
  ASoC: xtfpga-i2s: Add missing __rcu annotation

 sound/soc/codecs/wm8804.c       | 2 +-
 sound/soc/qcom/lpass-ipq806x.c  | 2 +-
 sound/soc/sh/rcar/ctu.c         | 2 +-
 sound/soc/sti/uniperif.h        | 2 +-
 sound/soc/sti/uniperif_player.c | 2 +-
 sound/soc/xtensa/xtfpga-i2s.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.1.4
