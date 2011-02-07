From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/7] ASoC: Samsung: neo1973_gta02: Fix
	bluetooth DAI registration
Date: Mon, 07 Feb 2011 18:37:03 +0100
Message-ID: <4D502DBF.3050205@metafoo.de>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<1297033463-14577-6-git-send-email-lars@metafoo.de>
	<20110207115906.GD10564@opensource.wolfsonmicro.com>
	<4D5023A4.3020209@metafoo.de>
	<20110207170213.GP10564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D48D244B5
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 18:35:33 +0100 (CET)
In-Reply-To: <20110207170213.GP10564@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 02/07/2011 06:02 PM, Mark Brown wrote:
> Please fix your MUA to word wrap at less than 80 columns, I've reflowed
> your text so it's legible.
> 
> On Mon, Feb 07, 2011 at 05:53:56PM +0100, Lars-Peter Clausen wrote:
> 
>>> In any
>>> case, we clearly shouldn't be applying patches which bodge around the
>>> core.
> 
>> Well the alternative would be a patch looking like this:
> 
>> -	.cpu_dai_name = "bluetooth-dai",
>> +	.cpu_dai_name = "soc-core",
> 
>> Which isn't really nice either.
> 
> If you think the core isn't behaving helpfully the core should be
> changed.  This is part of how APIs evolve to be maximally useful.
> 

As I see it the problem is that we have a deviceless dai and there is not really a
way to register a dai without a device. But I have no idea right now how to change
the core to make it "behave helpfully".

And in a sense snd_soc_register_dais seems to be the right thing to use for now,
because the sound card as a whole has multiple dais they just not all registered at
the same time.

> To be honest it's not massively obvious that we shouldn't just be taking
> the name of the device here, either using a device to represent the
> modem

Seriously? I don't see how adding a dummy device wouldn't be "bodging around the
core". Especially if using snd_soc_register_dais is.

> or registering the card using snd_soc_register_machine() and using
> a more meaningful name for the card seems like a sensible approach here.

Well, if were using snd_soc_register_machine to give the card a different name the
bluetooth-dai would still be named after the card, wouldn't it? So there is no
improvement here as to giving the dai a meaningful name.

- Lars
