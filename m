From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/12] ASoC: SSM2602: Do not power the codec up
	in probe
Date: Thu,  5 May 2011 16:59:15 +0200
Message-ID: <1304607560-15083-7-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 4B108103A0B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:46 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

It is not required to have the codec powered at this stage and DAPM will power
the ADC and DAC down again after probe has run anyway.
Thus we avoid some unnecessary writes by this change.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 40d3474..9ce792b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -61,7 +61,7 @@ struct ssm2602_priv {
  */
 static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	0x0017, 0x0017, 0x0079, 0x0079,
-	0x0000, 0x0000, 0x0000, 0x000a,
+	0x0000, 0x0000, 0x009f, 0x000a,
 	0x0000, 0x0000
 };
 
@@ -509,8 +509,6 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/*power on device*/
-	snd_soc_write(codec, SSM2602_ACTIVE, 0);
 	/* set the update bits */
 	reg = snd_soc_read(codec, SSM2602_LINVOL);
 	snd_soc_write(codec, SSM2602_LINVOL, reg | LINVOL_LRIN_BOTH);
@@ -523,7 +521,6 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 	/*select Line in as default input*/
 	snd_soc_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
 			APANA_ENABLE_MIC_BOOST);
-	snd_soc_write(codec, SSM2602_PWR, 0);
 
 	snd_soc_add_controls(codec, ssm2602_snd_controls,
 				ARRAY_SIZE(ssm2602_snd_controls));
-- 
1.7.2.5
