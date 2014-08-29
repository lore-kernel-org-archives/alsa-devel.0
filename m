From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/2] ASoC: simple-card: Fix bug about DT node's refcount
Date: Fri, 29 Aug 2014 17:19:31 +0800
Message-ID: <1409303973-1084-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch series hasn't any dependency with the previous one:
   "[RFC][PATCH] ASoC: simple-card: Merge single and muti DAI link code."



Xiubo Li (2):
  ASoC: simple-card: Fix bug of forgetting decrement DT node's refcount
  ASoC: simple-card: Fix bug of wrong decrement DT node's refcount

 sound/soc/generic/simple-card.c | 53 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

-- 
1.8.5
