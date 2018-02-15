From: Fabio Estevam <festevam@gmail.com>
Subject: Re: sgtl5000 fails after suspend/resume
Date: Thu, 15 Feb 2018 16:11:23 -0200
Message-ID: <CAOMZO5CH+HDDULOKw-bHoZgQ9koSNZcLS6dZbJ6+avhr06v-6g@mail.gmail.com>
References: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
 <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 49335267CD7
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 19:11:25 +0100 (CET)
Received: by mail-oi0-f50.google.com with SMTP id x21so438472oie.13
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 10:11:24 -0800 (PST)
In-Reply-To: <CAOMZO5CyE5T-H=K2Q9A=tYoY9zt0CO4YdFWK5PMS=NR2XbqPzQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Eric Nelson <eric@nelint.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>, Stefan Agner <stefan@agner.ch>, Gary Bisson <gary.bisson@boundarydevices.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 15, 2018 at 2:36 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Or if I do the change below against linux-next it also works:
>
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -880,8 +880,6 @@ static int sgtl5000_set_bias_level(struct
> snd_soc_component *component,
>                                     SGTL5000_REFTOP_POWERUP);
>                 break;
>         case SND_SOC_BIAS_OFF:
> -               snd_soc_component_update_bits(component,
> SGTL5000_CHIP_ANA_POWER,
> -                                   SGTL5000_REFTOP_POWERUP, 0);
>                 break;
>         }
>
> Any suggestions for a proper fix? Eric?

I sent a patch that that removes sgtl5000_set_bias_level() completely
and fixes the sgtl5000 suspend/resume issue.
