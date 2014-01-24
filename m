From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 0/7] simple card
Date: Fri, 24 Jan 2014 15:42:59 +0800
Message-ID: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch series has been test on VF610 Tower board.

Changed in V2:
- Revise the problem from Jean-Francois Moine.
- Add binding documentation patch.


Xiubo Li (7):
  ASoC: simple-card: fix __asoc_simple_card_dai_init
  ASoC: simple-card: simplify the daifmt code
  ASoC: simple-card: Add snd_card's name parsing from DT node support
  ASoC: simple-card: add tdm slot supports
  ASoC: add snd_soc_of_parse_audio_simple_widgets for DT
  ASoC: simple-card: add off-codec widgets supports.
  ASoC: binding: for new properties documenting and usage

 .../devicetree/bindings/sound/simple-card.txt      |  17 +++-
 include/sound/simple_card.h                        |   8 ++
 include/sound/soc.h                                |   2 +
 sound/soc/generic/simple-card.c                    | 112 +++++++++++++++++----
 sound/soc/soc-core.c                               |  87 ++++++++++++++++
 5 files changed, 204 insertions(+), 22 deletions(-)

-- 
1.8.4
