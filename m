From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: ab8500-codec: Add missing ad_to_slot
 definitions
Date: Wed, 8 May 2013 08:53:28 +0100
Message-ID: <20130508075328.GF3102@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-2-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1367997261-32048-2-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

I'm sure this is just me, but:

>    0 to  7 corresponds to AD_OUTx slots
> char * const enum_ad_to_slot_map[] =3D {"AD_OUT1",    0
                                                      1..5 ???
>  					"AD_OUT7",    6
>  					"AD_OUT8",    7
>    8 to 11 corresponds to zero output
>  					"zeroes",     8
> +					"zeroes",     9
> +					"zeroes",     10
> +					"zeroes",     11
>   12 to 15 sets the output in tristate mode
> +					"tristate",   12
> +					"tristate",   13
> +					"tristate",   14
>  					"tristate"};  15


--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
