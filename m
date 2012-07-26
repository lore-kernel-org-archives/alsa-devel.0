From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash when probing imx_mc13783
Date: Thu, 26 Jul 2012 14:16:43 -0300
Message-ID: <CAOMZO5AFifTGBt1=Z87pqp9Go9PkS_a5Mcu2+MMLCzFGrzqANA@mail.gmail.com>
References: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
 <3192997.N5KLupAYnr@laptop>
 <CAOMZO5BsOV3X09DKc-uexe9mqhYhkbmKZg2vh_h2-hBB=X1A7Q@mail.gmail.com>
 <50116D38.6050001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DAED9265B97
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 19:16:42 +0200 (CEST)
Received: by qcse14 with SMTP id e14so1358679qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 10:16:43 -0700 (PDT)
In-Reply-To: <50116D38.6050001@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Philippe_R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

On Thu, Jul 26, 2012 at 1:15 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The patch is apparently not correct (although, I do see a place for it). The
> problem is that unless your code populates codec->control_data, SoC Core
> will assume you haven't set-up any I/O for yourself, even if you have. I'm

Thanks for the advice. I did the following:

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 6276e35..c8251af 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -581,6 +581,8 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);

+	codec->control_data = priv;
+
 	mc13xxx_lock(priv->mc13xxx);

 	/* these are the reset values */

,and now audio can be probed again.

Will submit this patch shortly.

Thanks,

Fabio Estevam
