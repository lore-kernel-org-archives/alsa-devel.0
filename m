From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: si476x: Add missing break for
 SNDRV_PCM_FORMAT_S8 switch case
Date: Wed, 31 Oct 2012 16:07:43 +0800
Message-ID: <1351670863.6496.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B42A92615ED
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 09:07:52 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id t11so489808daj.38
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 01:07:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrey Smirnov <andrey.smirnov@convergeddevices.net>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/si476x.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 38145ba..dadf04d 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -159,6 +159,7 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		width = SI476X_PCM_FORMAT_S8;
+		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		width = SI476X_PCM_FORMAT_S16_LE;
 		break;
-- 
1.7.9.5
