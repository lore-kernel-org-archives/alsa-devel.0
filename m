From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports
	start from 1, not 0
Date: Tue, 3 Feb 2009 17:35:14 +0000
Message-ID: <20090203173513.GK23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
	<20090203164715.GH23827@sirena.org.uk>
	<74d0deb30902030913u581debd1pa31eda017a49524c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 437EE10387E
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 18:35:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30902030913u581debd1pa31eda017a49524c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 06:13:22PM +0100, pHilipp Zabel wrote:

> -       priv->dev.ssp = ssp_request(dai->id, "SoC audio");
> +       priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
>         if (priv->dev.ssp == NULL) {
>                 ret = -ENODEV;
>                 goto err_priv;

> But this isn't right either. Because if we request the correct SSP
> port here, the subsequent request of the same SSP port in ssp_init
> (called from ops->startup) fails.
> How to fix?

Hrm.  ssp_init() does a ssp_request() already.  The request on probe is
just redundant.  Eric was muttering about refactoring the API some more
but never got round to it.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
