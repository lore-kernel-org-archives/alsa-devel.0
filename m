From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Wed, 21 Nov 2012 15:44:18 +0100
Message-ID: <786252e931c4155bc48b42a49865bf21@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
 <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
 <50AB3A39.1090604@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C28F2650A8
 for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 15:44:32 +0100 (CET)
In-Reply-To: <50AB3A39.1090604@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Nov 2012 09:07:21 +0100, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 11/20/2012 07:54 AM, Tomas Pospisek wrote:
>> On Sat, 17 Nov 2012 11:53:49 +0100, Takashi Iwai wrote:
>>> At Sat, 17 Nov 2012 01:48:47 +0100, Tomas Pospisek wrote:
>>>
>>>> On Fri, 16 Nov 2012 17:04:03 +0100, Takashi Iwai wrote:
>>>>> At Fri, 16 Nov 2012 15:23:06 +0100, Tomas Pospisek wrote:
>>>>>>
>>>>>> The kernel of the upcoming Debian release and some
>>>>>> recent kernels of Ubuntu seem to be suffering from HDA
>>>>>> running at full force upon wakeup and producing
>>>>>> a lot of heat (keeping the fan spinning loudly).
>>>>>
>>>>> What do you mean "wakeup"?
>>>>
>>>> Waking up from suspend to RAM.
>>>
>>> And does the same issue occur on hibernation, too?
>>> Basically both S2RAM and S2DISK use the same suspend/resume path
>>> regarding the sound driver, so the behavior should be consistent in
>>> both cases.
>>
>> s2disk doesn't work here / isn't configured properly so I can't tell
>> ad hoc.
>>
>>>>>   Which kernel are you using?
>>>>
>>>> 3.2.0-4-amd64 from Debian wheezy:
>>>>    http://packages.debian.org/wheezy/linux-image-3.2.0-4-amd64
>>>
>>> OK, could you check the latest Linus tree (at least 3.7-rc5) whether
>>> the problem is still present?  If it is, please keep using it for the
>>> further testing instead of 3.2.0.  3.2.0 is way too old to debug
>>> primarily.
>>
>> I'm running 3.7.0-rc6 now, with configuration from the "original"
Debian
>> kernel, make oldconfig and all choices to default.
> 
> The Ubuntu kernel team does mainline builds - 
> https://wiki.ubuntu.com/Kernel/MainlineBuilds - which provide the latest

> upstream kernels.
> 
>>> Also, try the latest alsa-lib from git tree, too.  I thought David
>>> provides some packages built from the latest repo?
>>
>> I've found this repository by David:
>>
>>    https://launchpad.net/~diwic/+archive/dkms
>>
>> however it seems to be deprecated and points to this:
>>
>>    https://code.launchpad.net/~ubuntu-audio-dev/+archive/alsa-dailyvvv
>>
>> which however only contains "dkms-hda" packages. I'm not sure what
>> those packages contain, or rather whether they contain the latest alsa
>> and utils. It seems that they "only" contain an out of tree hda
>> build, but I'm not sure.
>>
>> I'll try to compile latest alsa "the Debian way" and see if that
changes
>> anything.
> 
> The thing I currently compile and maintain are DKMS packages for the HDA

> driver. We're never daily built alsa-lib, and the full sound tree builds

> have been discontinued since almost everyone used the DKMS packages (or 
> the full mainline kernel). See 
> https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS for how to install
them.

Thanks for both of your pointers!

> I haven't followed this thread in total, and I hadn't seen the bug 
> report before it was reported here, but I find it a little strange that 
> a headphone amp, even at full power, would give out so much heat that 
> your fan would spin up (I mean, this doesn't happen when you normally 
> listen to music through headphones, right?).

Now that I'm running the 3.7.0-rc6 kernel my laptop is staying rather
cool and the fan is mostly off. 

However with Debian's 3.2.0-4-amd64 kernel it's the contrary, the latop
is blowin hot air. The laptop has got a discrete Radeon card, but that
card is off and is not showing in powertop. And in powertop's CPU view,
the "package" is being shown as being <4% in "Turbo" mode. With
3.7.0-rc6 it's never in "Turbo" mode.

Also, with 3.7.0-rc6 after wake from suspend to RAM the Codecs show first
on the top in powertops "Overview" but after a few minutes drop out of
sight. They are still shown at 100% in powertop however they are shown
to use 0mW.

So back to your question "this doesn't happen when you normally listen
to music through headphones, right?": what I'm doing on the laptop
under the 3.2.0-4-amd64 kernel doesn't influence much the output of
hot air. I notice however that when I wake up, the laptop starts
blowing hot air immediately. And it doesn't stop until I go into
alsamixer and press F5. I hear a slight click (as in speakers getting
dis/connected) and then "Audio codec hwC0D0: IDT" drops to 0% and the
laptop stops blowing.

If you go to the original Ubuntu bugreport:

   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

you'll notice that many users are reporting very similar problems
there.

> I could be wrong, but 
> AFAIK, a codec chip just doesn't cause that much heat in /any/ 
> situation. So it's probably something else?

I don't understand why you are saying that it would be the
headphones amplyfier. Is "IDT" the amplifier for the headphones
only? I.e. not for the laptop's standard speakers?

So now that with the 3.7.0-rc6 kernel my laptop runs cool again,
I could stop at this point and go on with my own private ways.
However it'd be nice if it'd be possible to find out what exactly
was causing the problem in Debian's 3.2.0-4-amd64 kernel. It will
be Debian's stable kernel for the next 3 years and some of the
users will be swearing a lot due to the fan noise and the short
battery life. Same for Ubuntu Precise's kernel it seems.

Thanks,
*t
