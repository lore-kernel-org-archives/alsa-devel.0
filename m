From: Randolph Chung <rchung42@gmail.com>
Subject: [PATCH] tlv320aic3x symmetric rates
Date: Wed, 18 Aug 2010 17:09:45 +0800
Message-ID: <AANLkTimG1yR48_hZiKJrG_kuXK0d5EHXA8DnCun4Eq2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 145FE2446B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 11:09:46 +0200 (CEST)
Received: by iwn34 with SMTP id 34so2365iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 02:09:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The tlv320aic3x codec driver only supports symmetric rates for
capture/playback. Set the flag in the DAI accordingly.

Signed-off-by: Randolph Chung <tausq@parisc-linux.org>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 71a6990..63cad43 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1116,6 +1116,7 @@ struct snd_soc_dai aic3x_dai = {
                .rates = AIC3X_RATES,
                .formats = AIC3X_FORMATS,},
        .ops = &aic3x_dai_ops,
+       .symmetric_rates = 1,
 };
 EXPORT_SYMBOL_GPL(aic3x_dai);
