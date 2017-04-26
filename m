From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ASoC: simple-card: Fine-tuning for three
 function implementations
Date: Wed, 26 Apr 2017 15:02:03 +0200
Message-ID: <8b5e37d1-17c5-4551-801f-ca7939d5efd7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id B429B266FEC
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 15:02:49 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 14:54:32 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use devm_kcalloc() in asoc_simple_card_parse_aux_devs()
  Use devm_kcalloc() in asoc_simple_card_probe()
  SCU: Use devm_kcalloc() in asoc_simple_card_probe()

 sound/soc/generic/simple-card.c     | 8 ++++----
 sound/soc/generic/simple-scu-card.c | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.12.2
