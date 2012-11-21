From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Wed, 21 Nov 2012 16:12:28 +0100
Message-ID: <e2f5435b05a1b4feb57fdefcca7c58fe@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
 <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
 <s5h6250rbfi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0408C2650A8
 for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 16:12:39 +0100 (CET)
In-Reply-To: <s5h6250rbfi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Nov 2012 08:16:49 +0100, Takashi Iwai wrote:
> At Tue, 20 Nov 2012 07:54:10 +0100, Tomas Pospisek wrote:
>> 
>> On Sat, 17 Nov 2012 11:53:49 +0100, Takashi Iwai wrote:
>> > At Sat, 17 Nov 2012 01:48:47 +0100, Tomas Pospisek wrote:
>> >
>> >> On Fri, 16 Nov 2012 17:04:03 +0100, Takashi Iwai wrote:
>> >> > At Fri, 16 Nov 2012 15:23:06 +0100, Tomas Pospisek wrote:
>> >> >> 
>> >> >> The kernel of the upcoming Debian release and some
>> >> >> recent kernels of Ubuntu seem to be suffering from HDA
>> >> >> running at full force upon wakeup and producing
>> >> >> a lot of heat (keeping the fan spinning loudly).
>> >> > 
>> >> > What do you mean "wakeup"?
>> >> 
>> >> Waking up from suspend to RAM.
>> > 
>> > And does the same issue occur on hibernation, too?
>> > Basically both S2RAM and S2DISK use the same suspend/resume path
>> > regarding the sound driver, so the behavior should be consistent in
>> > both cases.
>> 
>> s2disk doesn't work here / isn't configured properly so I can't tell
>> ad hoc.
>> 
>> >> >  Which kernel are you using?
>> >> 
>> >> 3.2.0-4-amd64 from Debian wheezy:
>> >>   http://packages.debian.org/wheezy/linux-image-3.2.0-4-amd64
>> > 
>> > OK, could you check the latest Linus tree (at least 3.7-rc5) whether
>> > the problem is still present?  If it is, please keep using it for the
>> > further testing instead of 3.2.0.  3.2.0 is way too old to debug
>> > primarily.
>> 
>> I'm running 3.7.0-rc6 now, with configuration from the "original"
Debian
>> kernel, make oldconfig and all choices to default.
>> 
>> > Also, try the latest alsa-lib from git tree, too.  I thought David
>> > provides some packages built from the latest repo?

Since changing the kernel from 3.2.0-4-amd64 to upsteam 3.7.0-rc6 fixed
the excessive heat production, I'm concluding that the problem is not with
alsa-lib.
 
>> >> > Which codec and HD-audio controller chips?
>> >> 
>> >> Wrt codec - I don't know. Before suspending I am not playing any
>> >> sound.
>> > 
>> > Well, I meant the audio codec chip, not the codec format :)
>> > But in the text below, you showed a conexant codec.
>> > 
>> > Also, it's important to know what h/w vendor and model are.
>> > I guess it's a Lenovo machine?
>> 
>> It's not Conexant. It's:
>> 
>>          100.0%           Device         Audio codec  hwC0D0: IDT
>>          100.0%           Device         Audio codec  hwC0D3: Intel
>> 
>> Note that with Debian's 3.2.0-4-amd64 kernel only the IDT codec would
>> show up on the top of powertop's list. Now there's the Intel codec as
well.
> 
> OK, I've read a different line for other people's machine, then.
> 
> (BTW, you can just check /proc/asound/card0/codec#0 and codec#3 files
>  for more detailed information about the codec.  powertop gives only
>  digests.)

Thanks, it's giving me much more information that I can make sense of :-)
 
>> >> And the
>> >> system (say the desktop system or the bell in a terminal) isn't
>> producing
>> >> any sound either.
>> > 
>> > OK.
>> > 
>> >> Powertop says "Audio codec hwC0D0: IDT". Other People in the
launchpad
>> >> bugtracker seem to be reporting either "hwC0D0: IDT", "hwC0D0:
>> Conexant"
>> >> or
>> >> "hwC0D1: Conexant". 
>> >> 
>> >>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560
>> >> 
>> >> Here's the chip:
>> >> 
>> >> Audio:
>> >> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
>> >> Family High Definition Audio Controller (rev 05)
>> >> 
>> >> >  Please elaborate a bit more instead of a bug track URL.  This
will
>> >> >  save lots of time for other people.
>> >> 
>> >> Powertop v2.0 shows:
>> >> in the Overview tab:
>> >>        Usage       Events/s    Category    Description
>> >>    100.0%                      Device      Audio codec  hwC0D0: IDT
>> > 
>> > The usage in powertop doesn't mean what actually consuming the power
>> > in 100%.  It's a completely different statistics from the CPU usage.
>> > 
>> > It shows that the sound driver hasn't gone into the power-saving
>> > mode, a sort of partial suspend of the device.  It can happen by
>> > various reasons: e.g. when your system doesn't set up the power_save
>> > option properly, or your mixer setup blocks it.
>> > 
>> > First off, check the value in
>> > /sys/module/snd_hda_intel/parameters/power_save.  If it shows 0, it
>> > means the power-saving feature is turned off.  If it's a positive
>> > value, it means the power-saving may be turned on after the specified
>> > seconds after closing all usages of sound devices.
>> 
>> Upon boot the value is 0. I can set it to 1 and it stays 1 while
running,
>> however if I suspend to ram and resume, the value gets reset to 0
again.
> 
> This is the system setup issue.  It has nothing to do with the driver
> itself.
> 
> So, what is the *real* problem with it?  Did you measure any real
> power consumption with it?

I don't know what is causing the excessive heat. I just know that when the
laptop wakes from suspend to ram under the 3.2.0-4-amd64 kernel it starts
blowing hot air immediately. I start powertop and see
"100%  Audio codec  hwC0D0: IDT" on top of the "Overview" list. I start
alsamixer, press F5, I hear a slight "click" (as in speakers were
dis/connected), "hwC0D0: IDT" drops to 0% and after a minute or so the
laptop stops ventilating.

The trail that lead me to this conclusion
So my conclusion was that probably the production of heat and the audio
system were connected. My conclusion might very well be wrong.

The trail that lead me to this conclusion passed through this comment
here:

  
https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631/comments/13

That person had to "mess with alsamixer settings" specifically with
"Mic feedthrough to Main".

It's noteworthy that for most people:

   https://bugs.launchpad.net/ubuntu/+source/powertop/+bug/536631
   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

setting triggering the relevant system config parameters as in:

   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/37

that is setting
/sys/module/snd_hda_intel/parameters/power_save{_controller}
resolved the problem. Not for me however.

> If the usages is turned off after playing something, it is the feature
> in your kernel version.  As mentioned, power_save option itself didn't
> trigger the power-save mode but it's activated only after closing a
> device.  This was improved with 3.7, so check with the 3.7 kernel.

As I wrote, I _am_ using 3.7-rc6, and if I:

  echo 1 > /sys/module/snd_hda_intel/parameters/power_save

it will stay 1, but after wake from suspend to RAM it will be 0 again.
*t
