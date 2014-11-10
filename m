From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/6] ASoC: davinci-mcasp: Symmetric sample bits
	for IIS mode
Date: Mon, 10 Nov 2014 12:32:18 +0200
Message-ID: <1415615540-28981-5-git-send-email-peter.ujfalusi@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 57E272614C2
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:35 +0100 (CET)
In-Reply-To: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

In IIS mode the tx and rx configuration is symmetric, the BCLK and FSYNC is
shared.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a9822c7bbb0b..40cf4bc447e6 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1033,6 +1033,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		},
 		.ops 		= &davinci_mcasp_dai_ops,
 
+		.symmetric_samplebits	= 1,
 	},
 	{
 		.name		= "davinci-mcasp.1",
-- 
2.1.3
