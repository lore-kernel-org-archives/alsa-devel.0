From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 19 Feb 2010 11:47:14 +0000
Message-ID: <ad2655cb1002190347m5ae42684ic4de989f5f35eb84@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f213.google.com (mail-bw0-f213.google.com
	[209.85.218.213])
	by alsa0.perex.cz (Postfix) with ESMTP id CE279103934
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 12:47:16 +0100 (CET)
Received: by bwz5 with SMTP id 5so2254351bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 03:47:15 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On 19 February 2010 08:17, Jaroslav Kysela <perex@perex.cz> wrote:
> On Thu, 18 Feb 2010, Lennart Poettering wrote:
>
>>> For the Mic Boost +20dB case , how PA handle this +20dB switch in the "Flat
>>> Volume" model if you did not expost the Mic Boost switch to the user in the
>>> mixer control ?
>>>
>>> +20dB is quite significant in with the Capture Volume control
>>
>> We currently don't cover boost switches, simply because tehre is no dB
>> data queriable for them.
>>
>> I'd really prefer if those boost switches would be turned into binary
>> volume elements which carry normal dB information like any other
>> volume element. After all they are just a volume element, with only
>> two steps.
>
> I like this idea.
>

Seems like a good idea but what should we call it.
If we already have a mic capture gain control, what shall we call the
mic boost gain control so as not to confuse it with each other?
Would keeping its current name be OK?
