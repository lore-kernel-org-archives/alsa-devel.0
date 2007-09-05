From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (3rd version)
Date: Wed, 05 Sep 2007 14:14:48 +0200
Message-ID: <46DE9DB8.9050400@gmail.com>
References: <20070904211122.dfeed6d7.krzysztof.h1@wp.pl>	<46DDE48E.4000508@gmail.com>
	<20070905064241.321972d5.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A7F00244F5
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 14:21:15 +0200 (CEST)
In-Reply-To: <20070905064241.321972d5.krzysztof.h1@wp.pl>
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

On 09/05/2007 06:42 AM, Krzysztof Helt wrote:

>> But also -- please no inlines. There's no point to them. Kernel policy is 
>> basically "no inlines other than for things that would definitely be macros 
>> if we weren't fond of the typesafety inline functions give". GCC will figure 
>> things out on its own...
>>
> 
> These things were actually macros in the 2.4 driver.

Okay, but while I myself don't terribly mind the inline keyword or anything, 
the kernel as a whole does -- the general meme is "inline is always wrong, 
unless...", where "unless" includes exceedingly trivial and on a fastpath. 
Opinions as to the "exceedingly" may vary, but this is one-time setup code, 
so dropping the inlines is suggested -- otherwise you'd just saddle up the 
next bunch of kernel janitors with more instances of inline removals ;-)

>> So what happens if now someone starts poking at port[dev]? You probably want 
>> to keep these requested no?
>>
> 
> Sgalaxy dejavu.

Absolutely. The existing sgalaxy driver blows donkeys. In the replacement 
driver I have it's kept reserved (in fact, it keeps the entire SB part live, 
but I may want to revisit that -- I believe some testing is showing that no, 
the SB and WSS part really cannot be simultaneously active on any model; a 
forum post somewhere said they could, so I've been trying that)

>>> +	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
>>> +	    (mpu_port[dev] & ~0x30l) != 0x300) {
>> Eh, what?
>>
> 
> Checking if mpu_port[dev] is one 0x3X0 where X is from 0 to 3

That ain't working. -0x301 = 0xcff and ((foo & 0xcff) != 0x300) for all foo. 
I'd suggest to simply introduce another one of those switch() helpers for 
this -- it's again one-time code and it only pays to optimise for 
readability -- open-source code is read many more times that it's written.

>> In the above, IRQ 5 also seems to be allowed. This is all rather massive 
>> sgalaxy deja-vu...
>>
> 
> Do you think that this card can be handled by sgalaxy driver (with
> minimal changes to sgalaxy)?

sgalaxy itself is on its way out as far as I'm concerned, but yes, if you 
can give me a bit to look at whether or not the sound galaxy driver can be 
handling this card, great. Generally, I don't have anything against more 
top-level drivers (as they're mostly just wrappers around lib functionality 
anyway) though, so if it gets clumsy and/or ugly the seperate driver is fine 
by me at least.

I'll step up getting snd-galaxy into shape...

Rene.
