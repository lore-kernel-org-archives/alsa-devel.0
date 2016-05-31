From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
 driver" to the asoc tree
Date: Tue, 31 May 2016 17:26:30 -0500
Message-ID: <cba64f0e-9ca2-e4a6-5436-ea68cc1e9fcc@linux.intel.com>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <1680237.irs5HCh7f7@wks-pdc-gentoo>
 <b0014ea7-1f78-1a6c-0202-fde9c35ba356@linux.intel.com>
 <2387755.MGqpljUrLg@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DCB826595B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 00:26:32 +0200 (CEST)
In-Reply-To: <2387755.MGqpljUrLg@wks-pdc-gentoo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro <pxpert@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/31/16 3:56 PM, Pietro wrote:
> Hi,
> Here are the answers:
>
> - tracing to make sure you are actually on a CHT device
>   The device should be CHT (The processor is an Atom X3-Z8300). Can it be that the processor is an X3 series, but the platform is BT and not a CHT? I know many manifacturers simply upgraded their notebooks series from BT to CHT by changing the CPU and mantaining all the other components the same (For example the Audio codec).
>   How can I trace this?

you see a lot of references to cherrytrail-cr and 22A8, the right ID.
>
> - pastebin dmesg somewhere
>   Here is it: http://pastebin.com/FnpAD1kg

You have lots of errors or warnings in there. Not sure why, i have 
machines that don't behave as badly.

I am not sure why using the CHT firmware leads to an error, somehow you 
probably have a combination of issues. I would really start there, if 
the regular firmware doesn't work for you something is very wrong.

> - sudo cat /sys/bus/acpi/devices/10EC5651:01/status
>   Here are the results:
>   /sys/bus/acpi/devices/10EC5651:00/status
>     Returns 15

this matches what the machine driver expects so that's good.
>
>   /sys/bus/acpi/devices/10EC5651:01/status
>     Returns 0
>
> - enabling DSP loopbacks to see if the DSP consumes data at the right  rate. look at the UCM file and change cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on if you record and loopback on USB output this should play at the right speed.
>   I've changed the value in the HiFi file, but no changes.
>   How can i enable DSP loopbacks? I'm not an alsa developer so I need some help here :)

you need to record to enable the loopback while you play...
>
> Please let me know if you need other informations.

can you extract the DSDT and pastebin it as well?

>
> On Tuesday 31 May 2016 15:27:45 Pierre-Louis Bossart wrote:
>> the changes look ok
>>>
>>> But I still have the same problem: Audio plays slowly.
>>>
>>>
>>>
>>> It seems the DSP is clocked at 19.2, but the system is still clocked for
>>> 25, and these changes doesn't seem to have effects...
>>
>> no, CHT doesn't have a 25 MHz clock at all so that's just not physically
>> possible.
>>
>> Can you try:
>> - tracing to make sure you are actually on a CHT device
>> - pastebin dmesg somewhere
>> - sudo cat /sys/bus/acpi/devices/10EC5651:01/status
>> - enabling DSP loopbacks to see if the DSP consumes data at the right
>> rate. look at the UCM file and change
>> cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on
>> if you record and loopback on USB output this should play at the right
>> speed.
>>
>>
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
