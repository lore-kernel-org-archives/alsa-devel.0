From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
 After 2nd Run
Date: Fri, 19 Jun 2015 00:32:23 -0400
Message-ID: <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de> <1434531934.2471.9.camel@loki>
 <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F4A02604D5
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 06:32:24 +0200 (CEST)
Received: by obctg8 with SMTP id tg8so67658475obc.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 21:32:23 -0700 (PDT)
In-Reply-To: <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

I discovered one thing which lead me to believe something is wrong in my
*.pointer* callback. I would like to share it for expert suggestions.

So when a audio playback starts I initialize the buffer pointer to "0" in
the *.prepare* function. During my 1st playback the audio driver works
great, I see the *.pointer* function getting called a lot of times.

I update the buffer pointer  in the URB completion function. Here goes a
code segment from my URB completion function:

https://gist.github.com/azizulhakim/d24a36ef753f9a1536fa



And this is my *.pointer* function:

https://gist.github.com/azizulhakim/b15b002f74e77f88cd5a


Now during the 2nd playback, the driver initializes the buffer pointer to
"0" again inside the *.prepare* function. And then I see it calls the
*.pointer* function only once and afterwards stop with the error message *ALSA
sound/core/pcm_lib.c:1910 playback write error (DMA or IRQ trouble?)*


So I stopped initializing the buffer pointer to "0" during the second
playback assuming that the buffer pointer should stay at the place it
stopped from previous playback. But that also didn't work for me. I get the
same error message. Note that same driver works on Ubuntu without any
problem and as many times as I want.


It would be really helpful if I get some suggestion from the given code. In
case you wonder, the full code is available here
<https://github.com/azizulhakim/beagleusb/blob/master/beagle-audio.c>

Thanks
Azizul


On Wed, Jun 17, 2015 at 10:53 AM, Azizul Hakim <azizulfahim2002@gmail.com>
wrote:

> Okay, its good to learn something new on every day. So how do I configure
> McBSP port clocking? I'm very new on these things and was unable to find
> any useful link on this point. :(
>
> On Wed, Jun 17, 2015 at 5:05 AM, Liam Girdwood <
> liam.r.girdwood@linux.intel.com> wrote:
>
>> + Peter for Beaglebone
>>
>> On Wed, 2015-06-17 at 10:01 +0200, Clemens Ladisch wrote:
>> > Azizul Hakim wrote:
>> > > Driver didn't start the DMA: Not sure how to track on this point. Any
>> suggestion?
>> > > Interrupt do not arrive correctly: Is this the hardware issue or ALSA
>> issue?
>> >
>> > These would imply that some your driver, or some code used by your
>> driver,
>> > did not configure the DMA/interrupt correctly.
>>
>> On beaglebone it may also be that the McBSP port clocking is not
>> configured correctly.
>>
>> Liam
>>
>>
>
