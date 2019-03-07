From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 0/2] misc fix in src.c
Date: Thu, 7 Mar 2019 15:15:52 +0900
Message-ID: <20190307061554.26486-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

two issues were found due to linux-next commit
7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
this patch-set address these two issues

---
v2: Update rsnd_of_match table instead of set priv->flags in probe

v1: initial version

Jiada Wang (2):
  ASoC: rsnd: src: Avoid a potential deadlock
  ASoC: rsnd: src: fix compiler warnings

 sound/soc/sh/rcar/core.c |  3 +++
 sound/soc/sh/rcar/rsnd.h |  5 +++++
 sound/soc/sh/rcar/src.c  | 21 +++++++--------------
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.19.2
