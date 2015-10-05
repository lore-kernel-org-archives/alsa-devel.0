From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/2] ASoC: da7213: Add DT support to codec
	driver
Date: Mon, 5 Oct 2015 22:24:37 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D46082F3@SW-EX-MBX01.diasemi.com>
References: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
 <8b10191f4e14b32f831d32c66c7edebd861b70ac.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
 <20151005155543.GY12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 789C5261521
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 00:24:41 +0200 (CEST)
In-Reply-To: <20151005155543.GY12635@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On October 05, 2015 16:56, Mark Brown wrote:

> On Mon, Oct 05, 2015 at 04:40:18PM +0100, Adam Thomson wrote:
> 
> > This patch adds support for DT bindings in the codec driver.
> > As part of this support, the mclk data can now be provided and
> > used to control the mclk during codec operation.
> 
> Please split out the new MCLK configuration into a separate patch which
> describes what that configuration is, it's much easier to review that
> way.  Otherwise there's a couple of minor issues here but nothing too
> critical.

Ok, no problem. Will do.

> 
> >  	case SND_SOC_BIAS_STANDBY:
> >  		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
> > +			/* MCLK */
> > +			clk_prepare_enable(da7213->mclk);
> > +
> 
> This doesn't check the return value.

Yep, will update.

> 
> >  	.driver = {
> >  		.name = "da7213",
> > +		.of_match_table = da7213_of_match,
> 
> Please use of_match_ptr() here.

Ok, didn't know about that. Will update.
