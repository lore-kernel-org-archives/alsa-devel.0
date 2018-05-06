From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] ASoC: davinci-mcasp: Use
	'snd_pcm_format_t' type
Date: Sun,  6 May 2018 12:47:44 -0300
Message-ID: <1525621665-11022-2-git-send-email-festevam@gmail.com>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D719267338
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 17:47:52 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id h2-v6so33324611qtp.7
 for <alsa-devel@alsa-project.org>; Sun, 06 May 2018 08:47:52 -0700 (PDT)
In-Reply-To: <1525621665-11022-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

'snd_pcm_format_t' type is better suited for iterating through the
SNDRV_PCM_FORMAT members.

Also, use SNDRV_PCM_FORMAT_FIRST for the first element.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/davinci/davinci-mcasp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 03ba218..bde2252 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1214,11 +1214,12 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	struct snd_mask nfmt;
 	int rate = params_rate(params);
 	int slots = rd->mcasp->tdm_slots;
-	int i, count = 0;
+	snd_pcm_format_t i;
+	int count = 0;
 
 	snd_mask_none(&nfmt);
 
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (snd_mask_test(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
 			int ppm;
-- 
2.7.4
