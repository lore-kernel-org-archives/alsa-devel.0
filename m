From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 0/2] ASoC: simple-card: Fix bug about DT node's refcount
Date: Mon, 1 Sep 2014 09:35:25 +0800
Message-ID: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Change for v2:
- Just rebased to the next branch newest head.


Xiubo Li (2):
  ASoC: simple-card: Fix bug of forgetting decrement DT node's refcount
  ASoC: simple-card: Fix bug of wrong decrement DT node's refcount

 sound/soc/generic/simple-card.c | 53 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

-- 
1.8.4
