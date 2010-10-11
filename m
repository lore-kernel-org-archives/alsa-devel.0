From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 3/4] ARM: ep93xx: add AC97 platform support
Date: Mon, 11 Oct 2010 10:47:31 +0300
Message-ID: <20101011074731.GD27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<d63475d15634d7ffa4c4167cbead782a5aa1cfc9.1286707213.git.mika.westerberg@iki.fi>
	<4CB2166D.5080706@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 80D9D243EB
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 09:47:35 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1932326bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 00:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB2166D.5080706@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 08:39:25AM +1300, Ryan Mallon wrote:
> On 10/10/2010 11:54 PM, Mika Westerberg wrote:
> > +
> > +void __init ep93xx_register_ac97(void)
> > +{
> > +	/*
> > +	 * Make sure that the AC97 pins are not used by I2S.
> > +	 */
> > +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
> > +	platform_device_register(&ep93xx_ac97_device);
> > +}
> 
> The other ep93xx device support functions do this with acquire/release
> functions. However, it is quite unlikely that a board will ever need to
> switch from i2s to ac97 audio at runtime. Will see what Hartley thinks.

There is really no other option where to connect the AC97 codec.
In cases where both are needed, one needs to mux I2S to the SSP
pins. So not sure whether it makes sense to make the switch work
at runtime.

Thanks,
MW
