From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.38] ASoC: fill in
 snd_soc_pcm_runtime.card before calling snd_soc_dai_link.init()
Date: Thu, 3 Feb 2011 08:47:56 +0200
Message-ID: <20110203084756.4e5049c7.jhnikula@gmail.com>
References: <201102022111.42196.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 65C66245C5
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 07:48:04 +0100 (CET)
Received: by fxm5 with SMTP id 5so819536fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 22:48:04 -0800 (PST)
In-Reply-To: <201102022111.42196.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Feb 2011 21:11:41 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> The .card member of the snd_soc_pcm_runtime structure pointed to by the 
> snd_soc_dai_link.init() argument used to be initialized before the 
> function being called. This has changed, probably unintentionally, 
> after recent refactorings. Since the function implementations are free 
> to make use of this pointer, move its assignment back before the 
> function is called to avoid NULL pointer dereferences.
> 
> Created and tested on Amstrad Delta againts linux-2.6.38-rc2
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> Jarkko,
> I'm not sure if this change won't break anything in your dailess related 
> code path, please verify.
> 
> Thanks,
> Janusz
> 
>  sound/soc/soc-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- git/sound/soc/soc-core.c.orig	2011-01-31 19:49:29.000000000 +0100
> +++ git/sound/soc/soc-core.c	2011-02-02 20:23:10.000000000 +0100
> @@ -1449,6 +1449,7 @@ static int soc_post_component_init(struc
>  		rtd = &card->rtd_aux[num];
>  		name = aux_dev->name;
>  	}
> +	rtd->card = card;
>  
>  	/* machine controls, routes and widgets are not prefixed */
>  	temp = codec->name_prefix;
> @@ -1471,7 +1472,6 @@ static int soc_post_component_init(struc
>  
>  	/* register the rtd device */
>  	rtd->codec = codec;
> -	rtd->card = card;
>  	rtd->dev.parent = card->dev;
>  	rtd->dev.release = rtd_release;
>  	rtd->dev.init_name = name;

Thanks for spotting this Janusz. This was unintentional change done by
the commit 589c356. Yet another proof how important platform is the
Amstrad Delta :-)

rtd->codec is ok since it is set in soc_bind_dai_link prior calling the
snd_soc_dai_link.init and snd_soc_aux_dev.init doesn't need it. Would
be nice to set other rtd fields also where the rtd->card is set but
that's not as urgent change than this.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
