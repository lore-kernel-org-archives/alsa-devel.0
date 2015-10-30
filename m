From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 09:36:39 +0100
Message-ID: <56332C17.4010303@canonical.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <20151030023618.GR28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A70DE2604BE
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 09:36:38 +0100 (CET)
In-Reply-To: <20151030023618.GR28319@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org



On 2015-10-30 03:36, Mark Brown wrote:
> On Tue, Oct 13, 2015 at 09:07:20AM +0200, David Henningsson wrote:
>> On 2015-10-12 22:59, James Cameron wrote:
>
> James, please don't drop CCs (this is the convention for kernel lists).
>
>> I personally believe that if the physical hardware can be set to state where
>> it's bricked, the hardware itself is buggy.
>
>> If the hardware is buggy, this should be worked around in BIOS or whatever
>> firmware is present on the machine. Otherwise there is a bug in BIOS.
>
> This is just not possible for most systems, there is no BIOS only a
> bootoloader which hands off control to the kernel and stops running at
> that point.

The BIOS can poke the hardware, set registers in such ways that volumes 
are limited. Registers that the kernel never touches. From my knowledge, 
this is more common than not on modern laptops with HDA codecs. A 
bootloader could potentially do the same - but in many embedded setups I 
suspect it makes just as much sense to do that during driver 
initialization instead.

Anyhow, we both agree on the fact that sometimes there is no hardware 
and no BIOS that protect us against hardware failure.

We currently have some kind of mechanism that protects the end user from 
unintentionally destroying the hardware. What we're arguing about is 
whether that mechanism should be in userspace (e g by having the GUI 
talk to UCM instead of amixer directly), or in the kernel.

I'm advocating having it as close to the hardware as possible - i e, in 
the kernel, because that protects additional classes of users from 
unintentionally destroying the hardware. As well as making it harder for 
malicious apps that intentionally want to do it.

There is no calculation that userspace can do, that the kernel can't do 
almost as easily, so I don't buy the argument that doing things in the 
kernel would be "unrealistically difficult".
However, it seems that we have done (IMO) such a gross mis-design that 
changing this isn't possible overnight. But can we then try to move in 
the right direction, instead of moving in the wrong one?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
