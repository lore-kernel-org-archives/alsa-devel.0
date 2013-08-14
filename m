From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/2] add sysfs for acpi interfaces of thinkpad hardware
 mute
Date: Wed, 14 Aug 2013 22:59:48 +0200
Message-ID: <520BEFC4.4030203@canonical.com>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com>  <1376458937.30031.1.camel@x230>  <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com>  <1376459647.30031.2.camel@x230>  <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com>  <1376460872.30031.4.camel@x230>  <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com>  <1376463610.30031.6.camel@x230>  <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>  <520B3511.7020604@canonical.com> <1376466691.30031.14.camel@x230>  <520B4D71.6070109@canonical.com> <1376492217.28002.1.camel@x230.lan>  <520BE01F.9090402@canonical.com> <1376510744.28002.6.camel@x230.lan>  <520BEA52.5030705@canonical.com> <1376512731.28002.8.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1376512731.28002.8.camel@x230.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Alex Hung <alex.hung@canonical.com>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 08/14/2013 10:38 PM, Matthew Garrett wrote:
> On Wed, 2013-08-14 at 22:36 +0200, David Henningsson wrote:
> 
>> Imagine you're a non-technical user, who has never heard the words
>> "compromised userspace". You connect your headset where it fits (or
>> cordless), and then select the headset in sound settings (if it didn't
>> get selected for you when you plugged it in). You're on a VOIP call and
>> press the mic mute hotkey. Which mic did you expect to mute? The
>> selected one. On the mic mute hotkey button, there is also a LED. You
>> expect it to lit, because you muted the mic that you currently care
>> about, i e, the selected one.
> 
> The user hit the mute key. Why would they expect *anything* to be
> unmuted?
> 

Why should the userspace application, who just wants to lit a LED, have
to care about a lot of other sound cards and interfaces and mute them,
when the user does not care?

And what about multiseat setups? If a multiseat keyboard has a mic mute
LED, do you think another user's mic mute state should influence the LED
of your keyboard?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
