From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 10:04:30 +0100
Message-ID: <5633329E.8040003@canonical.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <20151030023618.GR28319@sirena.org.uk> <56332C17.4010303@canonical.com>
 <20151030085302.GE7311@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F33422604BE
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 10:04:28 +0100 (CET)
In-Reply-To: <20151030085302.GE7311@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 2015-10-30 09:53, James Cameron wrote:
> On Fri, Oct 30, 2015 at 09:36:39AM +0100, David Henningsson wrote:
>>
>>
>> On 2015-10-30 03:36, Mark Brown wrote:
>>> On Tue, Oct 13, 2015 at 09:07:20AM +0200, David Henningsson wrote:
>>>> On 2015-10-12 22:59, James Cameron wrote:
>>>
>>> James, please don't drop CCs (this is the convention for kernel lists).
>>>
>>>> I personally believe that if the physical hardware can be set to state where
>>>> it's bricked, the hardware itself is buggy.
>>>
>>>> If the hardware is buggy, this should be worked around in BIOS or whatever
>>>> firmware is present on the machine. Otherwise there is a bug in BIOS.
>>>
>>> This is just not possible for most systems, there is no BIOS only a
>>> bootoloader which hands off control to the kernel and stops running at
>>> that point.
>>
>> The BIOS can poke the hardware, set registers in such ways that
>> volumes are limited. Registers that the kernel never touches.
>
> I'm not sure how that would work.  The BIOS developers and the kernel
> developers would have to agree on what registers are to be touched by
> the BIOS only.  In my case, with the rt5631, the registers could not
> be easily isolated in that fashion.  And if the kernel hit the reset
> bit in one of the registers, whatever the BIOS had set would be lost.
>
> Oh, and power management.  The codec can be powered down by suspend,
> with the BIOS uninvolved in resume.

The way it has come to work on HDA is that the codec vendor has a number 
of "secret" registers, which they only tell the BIOS developers about, 
and (to our frustration) are quite reluctant to tell us about.

And certainly the BIOS is involved in setting these registers on S3 
resume, too.

One could imagine having ACPI calls for putting a codec in 
suspend/resume, but as I said, in many cases (such as yours) this just 
makes things more complicated. It's better dealt with in the kernel 
codec driver instead.

>> From
>> my knowledge, this is more common than not on modern laptops with
>> HDA codecs. A bootloader could potentially do the same - but in many
>> embedded setups I suspect it makes just as much sense to do that
>> during driver initialization instead.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
