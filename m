From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 1/5] ASoC: rt5645: Prevent the pop sound of
	the headphone while rebooting or shutdowning
Date: Wed, 26 Aug 2015 02:17:40 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F90D70@RTITMBSV03.realtek.com.tw>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
 <20150825175726.GJ12878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A812652E7
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 04:17:46 +0200 (CEST)
In-Reply-To: <20150825175726.GJ12878@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "woojoo.lee@samsung.com" <woojoo.lee@samsung.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, August 26, 2015 1:57 AM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao; John Lin;
> woojoo.lee@samsung.com
> Subject: Re: [PATCH 1/5] ASoC: rt5645: Prevent the pop sound of the headphone
> while rebooting or shutdowning
> 
> On Mon, Aug 24, 2015 at 08:32:55PM +0800, Oder Chiou wrote:
> > Add i2c shutdown function to prevent the pop sound of the headphone
> > while the system is rebooting or shutdowning
> 
> > +	regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3, 0x0020, 0x0020);
> > +	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000, 0x1000);
> > +	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
> > +0x0000);
> 
> Yay, magic numbers!  What is the issue this is fixing?  The core is supposed to
> power everything down to _BIAS_OFF before exiting, are we missing something
> here?
> 
It de-initialed our jack detection function, and it cannot be turned off in
_BIAS_OFF. If we didn't de-initial it, we will hear the pop sound in the
situation of powering off, thanks.
