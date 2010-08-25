From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: Re: [PATCH 1/6] ASoC: ad1980: Stay in 20bit mode for
	architectures other than blackfin
Date: Wed, 25 Aug 2010 11:28:48 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA06C36392@chinexm1.ad.analog.com>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 43F9C10380B
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 05:27:30 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

The ad1980 from ADI is obsolete. We have no plan to maintain this driver an=
y more.


Thanks


Sonic

>-----Original Message-----
>From: u.kleine-koenig@pengutronix.de =

>[mailto:u.kleine-koenig@pengutronix.de] =

>Sent: Tuesday, August 24, 2010 9:10 PM
>To: alsa-devel@alsa-project.org; Zhang, Sonic
>Cc: Sascha Hauer
>Subject: [PATCH 1/6] ASoC: ad1980: Stay in 20bit mode for =

>architectures other than blackfin
>
>From: Sascha Hauer <s.hauer@pengutronix.de>
>
>Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>---
> sound/soc/codecs/ad1980.c |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)
>
>diff --git a/sound/soc/codecs/ad1980.c =

>b/sound/soc/codecs/ad1980.c index 70cfaec..35c0580 100644
>--- a/sound/soc/codecs/ad1980.c
>+++ b/sound/soc/codecs/ad1980.c
>@@ -168,13 +168,21 @@ retry:
> 	}
> =

> 	soc_ac97_ops.reset(codec->ac97);
>+
>+#ifdef SND_BF5XX_SOC_AD1980
> 	/* Set bit 16slot in register 74h, then every slot will =

>has only 16
> 	 * bits. This command is sent out in 20bit mode, in =

>which case the
>-	 * first nibble of data is eaten by the addr. (Tag is =

>always 16 bit)*/
>+	 * first nibble of data is eaten by the addr. (Tag is =

>always 16 bit).
>+	 *
>+	 * This seems to be blackfin specific. On other systems =

>we want 20bit
>+	 * mode.
>+	 */
> 	ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
>+#endif
> =

> 	if (ac97_read(codec, AC97_RESET)  !=3D 0x0090)
> 		goto err;
>+
> 	return 0;
> =

> err:
>--
>1.7.1
>
>
