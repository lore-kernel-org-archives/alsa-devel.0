From: Daniel Mack <zonque@gmail.com>
Subject: Re: Lynx HiLo USB DAC issues
Date: Thu, 12 Sep 2013 19:07:16 +0200
Message-ID: <5231F4C4.6030708@gmail.com>
References: <CAAmECqTLRKu8uEpX9YHY3=W5bB0ydys2oQ2pAgHs2WjsjCqUFQ@mail.gmail.com>
 <CAAmECqRAJy=j+16Yp8kjb==905SMRhguL01CMqvMG8AP4A7QeA@mail.gmail.com>
 <CAAmECqTyhg0vPrTQzmthpjXFC_mtzO0WAs=WWbbzQ8CdkP6HzA@mail.gmail.com>
 <CAAmECqRfMqgVXSjuouqVzBX1FOGt79c+ueSQ1xLVFQAJ4QE6tw@mail.gmail.com>
 <5231EECA.1030600@gmail.com>
 <CAAmECqT5kR=d=HYjWrNUahN5kDdw3ez+YxKqQGoykTVcduy==w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9882654D6
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 19:07:20 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so34285bkb.32
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 10:07:18 -0700 (PDT)
In-Reply-To: <CAAmECqT5kR=d=HYjWrNUahN5kDdw3ez+YxKqQGoykTVcduy==w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Radoslaw Szkodzinski <astralstorm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12.09.2013 19:00, Radoslaw Szkodzinski wrote:
> On Thu, Sep 12, 2013 at 6:41 PM, Daniel Mack <zonque@gmail.com> wrote:
>> On 12.09.2013 02:43, Radoslaw Szkodzinski wrote:
>>> Never mind, I see the issue now. (It is late here.)
>>> The CLOCK_SELECTOR is read-only according to lsusb output.
>>>
>>> Apparently uac_clock_selector_get_val fails to work, returning invalid
>>> pin number.
>>> That should not happen, but it shouldn't be called either in this
>>> case, as the selector is irrelevant.
>>
>> Sorry, I don't follow. Given that you successfully dug into the driver
>> sources already, can you share a patch that makes things work for you?
> 
> The patch is not complete yet; I've done the selector fix, but it
> uncovered an issue where the device doesn't report any sample rates
> (CUR 0, RANGE 0) and ALSA is unable to handle this.
> I'll add some probing - this, unlike the broken selector, is
> technically allowed by UAC2 but a bit silly.
> (The device can handle anything 1 Hz to 384kHz. And DSD.)

We have SNDRV_PCM_RATE_CONTINUOUS which should be used in such cases,
but how should the driver get to know about this feature if the device
doesn't report it in any way?

>> The problem with the clocking framework in UAC2 is that it's quite
>> powerful (there are multipliers, dividers, switches etc), but I haven't
>> yet seen a system that actually makes uses it in more complex
>> applications. Hence it's not exactly easy to come up with a generic
>> approach of how to handle all the possible cases correctly, and how to
>> react on clock validity loss for instance.
> 
> I've decided in that case (readonly invalid selector) to count the
> valid sources and if there's only one valid, use that.

Yep, that certainly makes sense. I'm looking forward to your patches.


Thanks for your help,
Daniel
