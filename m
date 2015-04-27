From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: mc13783: Fix wrong mask value used
 in mc13xxx_reg_rmw() calls
Date: Mon, 27 Apr 2015 14:51:35 +0800
Message-ID: <1430117495.28082.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D7A260537
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 08:51:42 +0200 (CEST)
Received: by pdea3 with SMTP id a3so118658024pde.3
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 23:51:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, SaschaHauer <s.hauer@pengutronix.de>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

mc13xxx_reg_rmw() won't change any bit if passing 0 to the mask field.
Pass AUDIO_SSI_SEL instead of 0 for the mask field to set AUDIO_SSI_SEL
bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have this h/w for test, so please help review and test this patch.
Thanks.
 sound/soc/codecs/mc13783.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 2ffb9a0..3d44fc5 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -623,14 +623,14 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 				AUDIO_SSI_SEL, 0);
 	else
 		mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_CODEC,
-				0, AUDIO_SSI_SEL);
+				AUDIO_SSI_SEL, AUDIO_SSI_SEL);
 
 	if (priv->dac_ssi_port == MC13783_SSI1_PORT)
 		mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_DAC,
 				AUDIO_SSI_SEL, 0);
 	else
 		mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_DAC,
-				0, AUDIO_SSI_SEL);
+				AUDIO_SSI_SEL, AUDIO_SSI_SEL);
 
 	return 0;
 }
-- 
2.1.0
