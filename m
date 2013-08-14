From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/2] add sysfs for acpi interfaces of thinkpad hardware
 mute
Date: Wed, 14 Aug 2013 22:36:34 +0200
Message-ID: <520BEA52.5030705@canonical.com>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com>  <1376458937.30031.1.camel@x230>  <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com>  <1376459647.30031.2.camel@x230>  <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com>  <1376460872.30031.4.camel@x230>  <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com>  <1376463610.30031.6.camel@x230>  <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>  <520B3511.7020604@canonical.com> <1376466691.30031.14.camel@x230>  <520B4D71.6070109@canonical.com> <1376492217.28002.1.camel@x230.lan>  <520BE01F.9090402@canonical.com> <1376510744.28002.6.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1376510744.28002.6.camel@x230.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Alex Hung <alex.hung@canonical.com>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 08/14/2013 10:05 PM, Matthew Garrett wrote:
> On Wed, 2013-08-14 at 21:53 +0200, David Henningsson wrote:
>> On 08/14/2013 04:57 PM, Matthew Garrett wrote:
>>> On Wed, 2013-08-14 at 11:27 +0200, David Henningsson wrote:
>>>
>>>> The privacy issue is interesting, but I don't see a practical way of
>>>> implementing things that would protect us against compromised userspaces.
>>>
>>> That's pretty easy - just tie the LED control to the HDA device in-kernel.
>>>
>>
>> Well, my point was that the compromised userspace could still record
>> from other possibly connected microphones (such as USB or bluetooth
>> headsets).
> 
> Ok, true. It'd need to be at a higher level than HDA to make this
> consistent. But in theory, this is something that could be tied to the
> full set of input sources.

In theory perhaps, but in practice, I doubt it. USB audio perhaps,
because that's at least ALSA. Bluetooth uses its own stack (it's not
even ALSA), and I'm not sure how much of that stack is in the kernel.

And then we haven't considered other oddities such as FFADO, network
connected devices and what not...but perhaps we could leave those out?

>> But I guess one compromise could be to refuse userspace turn the mic
>> mute LED on, if the internal mic is unmuted.
>> Userspace would still be able to turn the mic mute LED off, to indicate
>> that recording can happen from other sources. It will be slightly more
>> complex for userspace though.
> 
> Like I said, I don't think there's any reason for this to be in
> userspace. If it's only going to represent the internal device, that's
> trivial. If it's going to represent the global state of audio devices,
> that's more complicated but doable. The only policy aspect is "What if I
> want it to track the state of the currently selected audio device",
> which just doesn't seem like a useful thing for it to do.

I say it's the *most* useful thing for it to do.

Imagine you're a non-technical user, who has never heard the words
"compromised userspace". You connect your headset where it fits (or
cordless), and then select the headset in sound settings (if it didn't
get selected for you when you plugged it in). You're on a VOIP call and
press the mic mute hotkey. Which mic did you expect to mute? The
selected one. On the mic mute hotkey button, there is also a LED. You
expect it to lit, because you muted the mic that you currently care
about, i e, the selected one.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
