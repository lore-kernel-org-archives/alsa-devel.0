From: Tim <tedon@rogers.com>
Subject: Re: HR timer 1000Hz limit since kernel 4.4.0-77
Date: Tue, 23 May 2017 16:49:35 -0400
Message-ID: <04225a83-48c8-3935-b77f-85e792d6423d@rogers.com>
References: <990803c6-b19a-a694-d28f-abfd8b19582e@rogers.com>
 <s5h60gsqfgc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm11-vm1.bullet.mail.bf1.yahoo.com
 (nm11-vm1.bullet.mail.bf1.yahoo.com [98.139.213.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E8DF267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 22:49:37 +0200 (CEST)
In-Reply-To: <s5h60gsqfgc.wl-tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 05/23/2017 02:01 AM, Takashi Iwai wrote:
> On Mon, 22 May 2017 18:30:27 +0200,
> Tim wrote:
>> Hello, ever since kernel 4.4.0-77, there seems to be
>>   a limit on the ALSA HR timer, I can't set it above 1000Hz
>>   (snd_timer_params() fails with -22 invalid argument).
>> I used to be able to set the rate much higher than that.
>> Been observed in two completely different distros, one with
>>   a much newer kernel. How can I overcome this limit?
> It's a recently introduced limit to avoid the too condensed spinlocks
> that may lead to a kernel lockup (the commit 71321eb3f2d0).
> If sub-ms timer is really required, we may introduce some module
> option to allow it, but it's the last-resort.
>
> What's the exact use case?
>
>
> thanks,
>
> Takashi
It's the MusE Sequencer Project. We use the timer to drive
  our ALSA playback.

A limited 'high resolution' timer with no way to change it.
Sounds a bit... drastic. But I can understand why a limit
  had to be done. I often wondered if the HR timer could
  really be used reliably at high frequencies. A dream?

We can live with 1000Hz. But I need to know: Where can
  we find and read this limiting value? Because we need
  to set the 'autostart' member in the timer params structure,
  and the structure wants a valid 'tick' value, so we first need
  to know about that limiting value.
Also, shouldn't the reported HR timer resolution be more
  in line with this new limit? It reports 1ns resolution.
This confused our app, thinking it was OK to go ahead
  and use this timer at a high rate, yet it failed.
We need the limiting value so that we may skip this timer
  if a better one is found (rtc hpet etc.)
And I need to ask, under what conditions might
  snd_timer_params_set_ticks() subsequently cause
  snd_timer_params_get_ticks() to report < 1 ?
The example test timer.c uses this, and we do to, but we're
  not sure why it's needed - since it did not fail when we
  asked the HR timer for > 1000Hz (shouldn't it fail with < 1?).

Thank you for great support for a non-member over 10 years.
Nice talking with you again. Tim.
