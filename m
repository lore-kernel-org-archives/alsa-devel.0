From: Bard Liao <bardliao@realtek.com>
Subject: Re: Different reg_default for rt5650 codec
Date: Fri, 30 Oct 2015 03:40:40 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010C37D2@RTITMBSV03.realtek.com.tw>
References: <ABFD875FF5FB574BA706497D987D48D7010C3663@RTITMBSV03.realtek.com.tw>
 <20151030011932.GN28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B58265E26
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 04:40:54 +0100 (CET)
In-Reply-To: <20151030011932.GN28319@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, October 30, 2015 9:20 AM
> To: Bard Liao
> Cc: John Lin; Oder Chiou; alsa-devel@alsa-project.org; Flove; Jack Yu
> Subject: Re: Different reg_default for rt5650 codec
> 
> On Thu, Oct 29, 2015 at 11:17:26AM +0000, Bard Liao wrote:
> 
> > Something like
> > 	case RT5650_DEVICE_ID:
> > +		rt5645->regmap-> reg_defaults = rt5650_reg;
> > +		rt5645->regmap-> num_reg_defaults = ARRAY_SIZE(rt5650_reg)
> > 		rt5645->codec_type = CODEC_TYPE_RT5650;
> > 		break;
> >
> > Is that ok?
> 
> No, that's not OK - the config needs to be constant and...
> 
> > Or should I use different regmap_config? There is one question if I use
> > different regmap_config. We will know which codec it is by
> regmap_read.
> > So, regmap is init before we know which codec it is. Assume
> rt5645_regmap
> > is used and what should I do once rt5650 is detected?
> 
> ...you definitely can't change it after you registered the CODEC, regmap
> will ignore that.  What should be happening here is that the devices
> should be being registered using different identifiers so that before we
> try to create the regmap we know what device is being used.
> 
> If there are buggy BIOSs out there that don't do that what I'd recommend
> doing is creating a temporary regmap with no defaults or anything, just
> the basic I/O.  Use that to read the identification registers from the
> device and then create a second regmap with the actual configuration for
> the device.

Thanks Mark. I will follow your suggestion to create a temporary regmap
to get the codec ID.

> 
> ------Please consider the environment before printing this e-mail.
