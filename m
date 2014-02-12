From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 0/3] Add tdm slot support
Date: Wed, 12 Feb 2014 15:45:09 +0800
Message-ID: <1392191112-27028-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, perex@perex.cz, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


Xiubo Li (3):
  ASoC: binding: add tdm-slot.txt
  ASoC: core: add slot information parsing supports
  ASoC: simple-card: add slot information parsing supports

 .../devicetree/bindings/sound/simple-card.txt      |  1 +
 .../devicetree/bindings/sound/tdm-slot.txt         | 17 +++++++++++
 include/sound/simple_card.h                        |  1 +
 include/sound/soc.h                                | 10 +++++++
 sound/soc/generic/simple-card.c                    | 35 ++++++++++++++++++++--
 sound/soc/soc-core.c                               | 23 ++++++++++++++
 6 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt

-- 
1.8.4
