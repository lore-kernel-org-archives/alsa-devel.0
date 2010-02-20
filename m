From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Sat, 20 Feb 2010 09:41:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002200938561.28127@eeebox2.perex-int.cz>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<ad2655cb1002190347m5ae42684ic4de989f5f35eb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C071103806
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 09:42:00 +0100 (CET)
In-Reply-To: <ad2655cb1002190347m5ae42684ic4de989f5f35eb84@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Feb 2010, James Courtier-Dutton wrote:

> On 19 February 2010 08:17, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Thu, 18 Feb 2010, Lennart Poettering wrote:
>>
>>>> For the Mic Boost +20dB case , how PA handle this +20dB switch in the "Flat
>>>> Volume" model if you did not expost the Mic Boost switch to the user in the
>>>> mixer control ?
>>>>
>>>> +20dB is quite significant in with the Capture Volume control
>>>
>>> We currently don't cover boost switches, simply because tehre is no dB
>>> data queriable for them.
>>>
>>> I'd really prefer if those boost switches would be turned into binary
>>> volume elements which carry normal dB information like any other
>>> volume element. After all they are just a volume element, with only
>>> two steps.
>>
>> I like this idea.
>>
>
> Seems like a good idea but what should we call it.
> If we already have a mic capture gain control, what shall we call the
> mic boost gain control so as not to confuse it with each other?
> Would keeping its current name be OK?

I would keep the Boost suffix. It's easy to understand.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
