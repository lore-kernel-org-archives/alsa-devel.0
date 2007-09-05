From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Wed, 05 Sep 2007 23:53:37 +0200
Message-ID: <46DF2561.2070506@gmail.com>
References: <20070905222541.4b74980f.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CFAA71038B9
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 00:00:06 +0200 (CEST)
In-Reply-To: <20070905222541.4b74980f.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/05/2007 10:25 PM, Krzysztof Helt wrote:

> I have left the ISA autodetection. It makes driver usage simpler for user.
> The base port, mpu port and mss port can be read from jumper settings,
> but irq or dma is not settable. A system may figure out which one is free 
> and use it.

The problem is that this "simplification" might actually leave the non-aware 
user scratching his head for far longer than if he has to spell things out.

He could for example very well need to go into his BIOS and set the IRQ to 
"Legacy ISA" to even have that IRQ available to the ISA bus on some systems 
(such as mine, at least for some IRQs -- things tend to fail in the most 
mysterious of ways sometimes otherwise).

Even without that problem, we have the problem of IRQs that's only _appear_ 
to be free. IRQ7 for example will usually be assigned to the first parallel 
port but will only show up as taken if the parport driver is loaded. Often, 
it'll still actually work, but (again) here for example, it does not.

Non-PnP ISA is an enormous crap bus -- the more you try to make up for it by 
trying to be smart in software the bigger the problems the user has when it 
doesn't actually work since you hid the details of how it worked by trying 
to be nice.

Add in the fact that all this auto-probing is a gigantic race-by-design (the 
probe releases the resource again, so someone can come along and grab them 
then) and I really violently dislike auto-probing on ISA.

It's not like people using legacy ISA in this day and age are not normally 
nerds anyway...

> I post this driver despite my question if it can be integrated into the sgalaxy driver.
> I think that I can post it and see if it work for people and maybe contact 
> someone with SC-6600 model so the driver can be extended to handle this
> chip also. It would replace the OSS driver completely then.

Yes. I am looking at the sound galaxy driver at the moment and am in fact 
now trying to think of why I want to use the WSS part of the card and not 
just the SBP part. In DOS, the card is setup in SB Pro mode by default as 
well, and the CS42xx seems to only be present really for Windows Sound 
System compatibility for old 16-bit Windows.

I'll keep it all in since loosing the information of _how_ to switch to WSS 
mode would be a shame, but I see very little reson in fact for not simply 
using the card in SB Pro mode. I guess the same may hold for your card...

> I am getting feeling that ad1848 and cs4231 libraries could be merged (or at least
> produce some common part like mss_lib). This may allow to merge drivers using
> cs4231-lib and ad1848-lib. I'll look into this

They could. An AD1848 (== CS4248) is the basic and original model and a 
CS4231 is just a slightly more capable, and pin-compatible, version. 
cs4231_lib will actually drive an AD1848, so the "merging" could largely 
consist of throwing out ad1848_lib. The latter is sort of nicely minimal 
though..

> (I do not have the CS4231 based card but I should have it next week -
> Sound Galaxy Waverider).

Am testing on that one currently -- will post the driver before next week.

> +static __devinit unsigned char sc6000_irq_to_softcfg(int irq)
> +{
> +	unsigned char val = 0;
> +
> +	switch (irq) {
> +	case 5:
> +		val = 0x28;
> +		break;
> +	case 7:
> +		val = 0x8;
> +		break;
> +	case 9:
> +		val = 0x10;
> +		break;
> +	case 10:
> +		val = 0x18;
> +		break;
> +	case 11:
> +		val = 0x20;
> +		break;
> +	default:
> +		break;
> +	}
> +	return val;
> +}

Quite sure that 5 works by the way? On a Sound Galaxy, 5 only works for the 
SB part (and 11 only for the WSS).

(remainder only glossed over)

Rene.
