From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/4] pxa-ssp: don't touch ssp registers when
	stream is running
Date: Wed,  4 Mar 2009 21:16:59 +0100
Message-ID: <1236197820-21022-3-git-send-email-daniel@caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F0510391D
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:17:13 +0100 (CET)
In-Reply-To: <1236197820-21022-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

In pxa_ssp_set_dai_fmt(), don't modify the SSP registers in case the
stream is already running. With that patch applied, loop-thru tests like
'acrecord -f cd | aplay -f cd' succeed.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Tim Ruetz <tim@caiaq.de>
---
 sound/soc/pxa/pxa-ssp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7fc13f0..45fb600 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -521,6 +521,10 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	u32 sscr0;
 	u32 sscr1;
 	u32 sspsp;
+	
+	/* we can only change the settings if the port is not in use */
+	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+		return 0;
 
 	/* reset port settings */
 	sscr0 = ssp_read_reg(ssp, SSCR0) &
-- 
1.6.1.3
