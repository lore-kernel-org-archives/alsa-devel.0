From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
 wake
Date: Tue, 20 Nov 2012 09:07:21 +0100
Message-ID: <50AB3A39.1090604@canonical.com>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
 <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A84EC261603
 for <Alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 09:07:23 +0100 (CET)
In-Reply-To: <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Pospisek <tpo2@sourcepole.ch>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/20/2012 07:54 AM, Tomas Pospisek wrote:
> On Sat, 17 Nov 2012 11:53:49 +0100, Takashi Iwai wrote:
>> At Sat, 17 Nov 2012 01:48:47 +0100, Tomas Pospisek wrote:
>>
>>> On Fri, 16 Nov 2012 17:04:03 +0100, Takashi Iwai wrote:
>>>> At Fri, 16 Nov 2012 15:23:06 +0100, Tomas Pospisek wrote:
>>>>>
>>>>> The kernel of the upcoming Debian release and some
>>>>> recent kernels of Ubuntu seem to be suffering from HDA
>>>>> running at full force upon wakeup and producing
>>>>> a lot of heat (keeping the fan spinning loudly).
>>>>
>>>> What do you mean "wakeup"?
>>>
>>> Waking up from suspend to RAM.
>>
>> And does the same issue occur on hibernation, too?
>> Basically both S2RAM and S2DISK use the same suspend/resume path
>> regarding the sound driver, so the behavior should be consistent in
>> both cases.
>
> s2disk doesn't work here / isn't configured properly so I can't tell
> ad hoc.
>
>>>>   Which kernel are you using?
>>>
>>> 3.2.0-4-amd64 from Debian wheezy:
>>>    http://packages.debian.org/wheezy/linux-image-3.2.0-4-amd64
>>
>> OK, could you check the latest Linus tree (at least 3.7-rc5) whether
>> the problem is still present?  If it is, please keep using it for the
>> further testing instead of 3.2.0.  3.2.0 is way too old to debug
>> primarily.
>
> I'm running 3.7.0-rc6 now, with configuration from the "original" Debian
> kernel, make oldconfig and all choices to default.

The Ubuntu kernel team does mainline builds - 
https://wiki.ubuntu.com/Kernel/MainlineBuilds - which provide the latest 
upstream kernels.

>> Also, try the latest alsa-lib from git tree, too.  I thought David
>> provides some packages built from the latest repo?
>
> I've found this repository by David:
>
>    https://launchpad.net/~diwic/+archive/dkms
>
> however it seems to be deprecated and points to this:
>
>    https://code.launchpad.net/~ubuntu-audio-dev/+archive/alsa-dailyvvv
>
> which however only contains "dkms-hda" packages. I'm not sure what
> those packages contain, or rather whether they contain the latest alsa
> and utils. It seems that they "only" contain an out of tree hda
> build, but I'm not sure.
>
> I'll try to compile latest alsa "the Debian way" and see if that changes
> anything.

The thing I currently compile and maintain are DKMS packages for the HDA 
driver. We're never daily built alsa-lib, and the full sound tree builds 
have been discontinued since almost everyone used the DKMS packages (or 
the full mainline kernel). See 
https://wiki.ubuntu.com/Audio/UpgradingAlsa/DKMS for how to install them.

I haven't followed this thread in total, and I hadn't seen the bug 
report before it was reported here, but I find it a little strange that 
a headphone amp, even at full power, would give out so much heat that 
your fan would spin up (I mean, this doesn't happen when you normally 
listen to music through headphones, right?). I could be wrong, but 
AFAIK, a codec chip just doesn't cause that much heat in /any/ 
situation. So it's probably something else?

It does put another question - from where does powertop get its values, 
and do we have to do anything on our side to make sure / aid them being 
correct?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
