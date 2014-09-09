From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: sgtl5000: Cleanup bias level
	transitions
Date: Tue, 9 Sep 2014 17:11:56 -0300
Message-ID: <CAOMZO5AD=8ERj0-JvV4DdjDug0yVBXATeK8icbEh9XVXsA9+2Q@mail.gmail.com>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
 <1410006575-499-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id E22D02652F4
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 22:11:56 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id b17so19901597lan.8
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 13:11:56 -0700 (PDT)
In-Reply-To: <1410006575-499-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 6, 2014 at 9:29 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.
>
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.
>
> The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
> can also be removed as the core will automatically do this after the CODEC
> has been probed.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
