From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core: Fix card RTD count for deferred
	probe.
Date: Tue, 17 Apr 2012 18:00:11 +0100
Message-ID: <1334682011-29411-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
	[74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EF44104382
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 19:00:25 +0200 (CEST)
Received: by wgbge7 with SMTP id ge7so5338923wgb.28
	for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2012 10:00:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently we increment the number of RTD's per card during the DAI link
bind. This can cause an incorrect RTD count when we cannot find a component
and defer the probe (and hence perform the DAI link bind for the card again).

Fix the count so that it is cleared before every card registration
and bind attempt.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5d308e9..20e55531 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3155,6 +3155,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 				 GFP_KERNEL);
 	if (card->rtd == NULL)
 		return -ENOMEM;
+	card->num_rtd = 0;
 	card->rtd_aux = &card->rtd[card->num_links];
 
 	for (i = 0; i < card->num_links; i++)
-- 
1.7.5.4
