From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Asynchronous audio USB chips: choppy playback
 since 3.8-rc7
Date: Wed, 03 Apr 2013 16:11:39 +0200
Message-ID: <515C389B.80506@amarulasolutions.com>
References: <515C013D.8090909@canonical.com> <515C0312.1090507@gmail.com>
 <515C34E5.3030306@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
 [74.125.82.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADB6265D4D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 16:11:43 +0200 (CEST)
Received: by mail-we0-f182.google.com with SMTP id k14so1232881wer.27
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 07:11:42 -0700 (PDT)
In-Reply-To: <515C34E5.3030306@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 1136110@bugs.launchpad.net, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Alan Stern <stern@rowland.harvard.edu>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel

On 03/04/13 15:55, Michael Trimarchi wrote:
> Hi Daniel
> 
> On 03/04/13 12:23, Daniel Mack wrote:
>> Hi David,
>>
>> On 03.04.2013 12:15, David Henningsson wrote:
>>> Just to get your attention here on what seems to be an USB audio 
>>> regression.
>>>
>>> The bug is described in detail here:
>>>
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110?comments=all
>>>
>>> Quoting the bug:
>>>
>>> "
>>> This bug seems to affect only a certain kind of hardware, which is 
>>> called "Asynchronous USB Digital Audio Codec (DAC)". It's said that such 
>>> a DAC hosts the clock itself (USB Device Host). An ordinary DAC, so 
>>> called "Synchronous USB DAC", uses the clock hosted by the mother board, 
>>> which is not affected by this bug.
>>>
>>> When this bug affects an asynchronous USB DAC, the audio played by the 
>>> DAC is constantly interrupted. The playback itself does not stop, but 
>>> the output becomes discontinous, filling with constant crackling noises, 
>>> destroying everything the DAC plays.
>>> "
>>>
>>> According to the bug reporter, which seems to have done quite a bit of 
>>> research, this started between 3.8-rc6 and 3.8-rc7 as well as stable 
>>> kernels and the bug also lists a few commits which could be the cause, 
>>> none under sound/usb though.
>>
>> There were no relevant changes for snd-usb between the two versions
>> mentioned. The only patches that come in mind in this time window are:
>>
>>  3e619d041 "USB: EHCI: fix bug in scheduling periodic split transfers"
>>  b09a61cc0 "USB: EHCI: fix for leaking isochronous data"
> 
> This last one, doesn't give me any problem, just a memory leak and not a choppy
> playback (tested on 48Khz, 96Khz, 192Khz 32bit on OMAP3 device) and I don't
> think that it can be the reason of the problem.

Sorry the comment was for a bug that is not included in this list and recently fixed.
USB: EHCI: fix bug in iTD/siTD DMA pool allocation

Michael

> 
> http://www.m2tech.biz/hiface_dac.html
> 
> Michael
> 
> 
>>
>> And they have both been back-ported to stable. Copied Alan for reference.
>>
>> Any chance some of the bug reporters could try and revert exactly those
>> for testing?
>>
>>
>> Thanks,
>> Daniel
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> 
