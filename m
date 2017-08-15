From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/5] constify snd_soc_dai_ops structures
Date: Tue, 15 Aug 2017 17:10:07 +0200
Message-ID: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C73267456
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 17:35:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-rockchip@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, bhumirks@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

---

 sound/soc/blackfin/bf6xx-i2s.c    |    2 +-
 sound/soc/codecs/es8316.c         |    2 +-
 sound/soc/codecs/zx_aud96p22.c    |    2 +-
 sound/soc/rockchip/rockchip_pdm.c |    2 +-
 sound/soc/spear/spdif_in.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
