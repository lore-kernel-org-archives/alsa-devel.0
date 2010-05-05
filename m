From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Add platform data and
 reset gpio handling
Date: Wed, 5 May 2010 12:50:20 +0300
Message-ID: <20100505125020.7f0a2c01.jhnikula@gmail.com>
References: <1273047200-5188-1-git-send-email-jhnikula@gmail.com>
	<201005051235.55742.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 38F1F24390
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 11:49:07 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1595759ewy.17
	for <alsa-devel@alsa-project.org>; Wed, 05 May 2010 02:49:06 -0700 (PDT)
In-Reply-To: <201005051235.55742.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 May 2010 12:35:55 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> >  err_enable:
> >  	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
> >  err_get:
> > +	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
> 
> This looks suspicious (disable after free?)
> On the other hand, is there a need to disable at all in error case?
> 
Oops. How that went there. Thanks for noticing!


-- 
Jarkko
