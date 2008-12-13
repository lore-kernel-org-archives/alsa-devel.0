From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [ath5k-devel] Bugs on aspire one A150
Date: Sat, 13 Dec 2008 16:38:50 +0200
Message-ID: <1229179130.4936.22.camel@maxim-laptop>
References: <491506DB.1070000@gmail.com>
	<b6c5339f0811100851t1fd9a180pfe24312081885467@mail.gmail.com>
	<4918A8C5.3050607@gmail.com>
	<40f31dec0811101412n1a4faf86sf4b1f37bb41caef9@mail.gmail.com>
	<1229174904.4964.5.camel@maxim-laptop>
	<40f31dec0812130608x73266375n7b3367938ad687b8@mail.gmail.com>
	<1229179013.4936.20.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 79D31103807
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 15:38:57 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so920795fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 06:38:57 -0800 (PST)
In-Reply-To: <1229179013.4936.20.camel@maxim-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nick Kossifidis <mickflemm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, ath5k-devel@lists.ath5k.org, Bob Copeland <me@bobcopeland.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2008-12-13 at 16:36 +0200, Maxim Levitsky wrote:
> On Sat, 2008-12-13 at 16:08 +0200, Nick Kossifidis wrote:
> > 2008/12/13 Maxim Levitsky <maximlevitsky@gmail.com>:
> > >
> > > Hi,
> > >
> > > Indeed gpio #3 controls the led.
> > > I patched ath5k to use it, and led works now fine.
> > >
> > >
> > 
> > Please share your patch with the rest and also post an lspci -vnn for
> > your card so we can handle this in a generic way
> 
> This just a one liner hack
> 
> diff --git a/drivers/net/wireless/ath5k/base.c
> b/drivers/net/wireless/ath5k/base.c
> index 9d2c597..a447937 100644
> --- a/drivers/net/wireless/ath5k/base.c
> +++ b/drivers/net/wireless/ath5k/base.c
> @@ -2595,6 +2595,11 @@ ath5k_init_leds(struct ath5k_softc *sc)
>  		sc->led_pin = 1;
>  		sc->led_on = 1;  /* active high */
>  	}
> +
> +	__set_bit(ATH_STAT_LEDSOFT, sc->status);
> +	sc->led_pin = 3;
> +	sc->led_on = 1;
> +
>  	if (!test_bit(ATH_STAT_LEDSOFT, sc->status))
>  		goto out;
> 
> 
> 

> 
> Best regards,
> 	Maxim Levitsky
> 

Note: thus makes led to be off by default, otherwise set
sc->led_on = 0

this also works

Regards,
	Maxim Levitsky
