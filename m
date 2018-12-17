From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Mon, 17 Dec 2018 08:53:59 +0100
Message-ID: <612ffd6d-92aa-dfe8-61a8-cd85e2014355@redhat.com>
References: <20181216185429.GA20408@gerhold.net>
 <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
 <20181216230350.a4138c5ceb9330b2a0b2872f@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D21BA2678D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 08:54:01 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id o10so9867196edt.13
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:54:01 -0800 (PST)
In-Reply-To: <20181216230350.a4138c5ceb9330b2a0b2872f@ao2.it>
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
To: Antonio Ospite <ao2@ao2.it>
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 16-12-18 23:03, Antonio Ospite wrote:
> On Sun, 16 Dec 2018 20:07:30 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 16-12-18 19:54, Stephan Gerhold wrote:
> [...]
>>> Unlike many of the other DSDT dumps I've looked at, there is only one
>>> interrupt listed. Full ACPI DSDT table is at [1].
>>>
>>> Since there is no IRQ at index 5, platform_get_irq will return -ENXIO.
>>> Couldn't we fall back to index 0 in this case? I would say that if the
>>> seemingly "correct" IRQ at index 5 does not even exist, we still have
>>> a better chance of picking the right one if we try the one at index 0.
>>> Or we could check the number of interrupts that are actually available.
>>
>> If I'm not mistaken then you already mentioned in another thread
>> (the "tusb1210 probe of dwc3.0.auto.ulpi fails with EBUSY on 4.19+")
>> thread that the DSTD of this Andriod only device has several bugs in
>> there such as wrong GPIOs in some places, etc. and you need to do a
>> DSDT override anyways to get some things to work, right ?
>>
>> In that case I believe it would be best to just also patch up this
>> part of the DSDT in your override and leave the current kernel code
>> as is.
>>
> 
> FWIW that is what I did when playing with a Teclast X98 Air 3G some
> years ago, see:
> https://git.ao2.it/Teclast-X98-Air-3G_C6J6_custom_DSDT.git/
> 
> In my case I just had to fix the ordering:
> https://git.ao2.it/Teclast-X98-Air-3G_C6J6_custom_DSDT.git/commitdiff/f718ea7d184cf266d7b5453124139b1c627221e6
> 
> It's been a while tho, I just committed and pushed the change now
> because I had forgotten back in the day.
> 
> The Makefile in the repository contains some pointers about how to build
> a DSDT override, what is missing is that you still have to manually
> append the original initrd to the file created by the Makefile.

If that is the only issue the DSTD of the Teclast-X98-Air-3G has, then this
seems like a case where a DMI quirk might be a good solution, so that it
will work out of the box for users trying to put Linux on there.

Regards,

Hans
