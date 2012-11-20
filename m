From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Tue, 20 Nov 2012 07:54:10 +0100
Message-ID: <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 2662C26524A
 for <Alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 07:54:26 +0100 (CET)
In-Reply-To: <s5h1ufsa4aq.wl%tiwai@suse.de>
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

On Sat, 17 Nov 2012 11:53:49 +0100, Takashi Iwai wrote:
> At Sat, 17 Nov 2012 01:48:47 +0100, Tomas Pospisek wrote:
>
>> On Fri, 16 Nov 2012 17:04:03 +0100, Takashi Iwai wrote:
>> > At Fri, 16 Nov 2012 15:23:06 +0100, Tomas Pospisek wrote:
>> >> 
>> >> The kernel of the upcoming Debian release and some
>> >> recent kernels of Ubuntu seem to be suffering from HDA
>> >> running at full force upon wakeup and producing
>> >> a lot of heat (keeping the fan spinning loudly).
>> > 
>> > What do you mean "wakeup"?
>> 
>> Waking up from suspend to RAM.
> 
> And does the same issue occur on hibernation, too?
> Basically both S2RAM and S2DISK use the same suspend/resume path
> regarding the sound driver, so the behavior should be consistent in
> both cases.

s2disk doesn't work here / isn't configured properly so I can't tell
ad hoc.

>> >  Which kernel are you using?
>> 
>> 3.2.0-4-amd64 from Debian wheezy:
>>   http://packages.debian.org/wheezy/linux-image-3.2.0-4-amd64
> 
> OK, could you check the latest Linus tree (at least 3.7-rc5) whether
> the problem is still present?  If it is, please keep using it for the
> further testing instead of 3.2.0.  3.2.0 is way too old to debug
> primarily.

I'm running 3.7.0-rc6 now, with configuration from the "original" Debian
kernel, make oldconfig and all choices to default.

> Also, try the latest alsa-lib from git tree, too.  I thought David
> provides some packages built from the latest repo?

I've found this repository by David:

  https://launchpad.net/~diwic/+archive/dkms

however it seems to be deprecated and points to this:

  https://code.launchpad.net/~ubuntu-audio-dev/+archive/alsa-dailyvvv

which however only contains "dkms-hda" packages. I'm not sure what
those packages contain, or rather whether they contain the latest alsa
and utils. It seems that they "only" contain an out of tree hda
build, but I'm not sure.

I'll try to compile latest alsa "the Debian way" and see if that changes
anything.

>> > Which codec and HD-audio controller chips?
>> 
>> Wrt codec - I don't know. Before suspending I am not playing any sound.
> 
> Well, I meant the audio codec chip, not the codec format :)
> But in the text below, you showed a conexant codec.
> 
> Also, it's important to know what h/w vendor and model are.
> I guess it's a Lenovo machine?

It's not Conexant. It's:

            100.0%                      Device         Audio codec hwC0D0:
IDT
            100.0%                      Device         Audio codec hwC0D3:
Intel

Note that with Debian's 3.2.0-4-amd64 kernel only the IDT codec would show
up
on the top of powertop's list. Now there's the Intel codec as well.

>> And the
>> system (say the desktop system or the bell in a terminal) isn't
producing
>> any sound either.
> 
> OK.
> 
>> Powertop says "Audio codec hwC0D0: IDT". Other People in the launchpad
>> bugtracker seem to be reporting either "hwC0D0: IDT", "hwC0D0:
Conexant"
>> or
>> "hwC0D1: Conexant". 
>> 
>>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560
>> 
>> Here's the chip:
>> 
>> Audio:
>> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
>> Family High Definition Audio Controller (rev 05)
>> 
>> >  Please elaborate a bit more instead of a bug track URL.  This will
>> >  save lots of time for other people.
>> 
>> Powertop v2.0 shows:
>> in the Overview tab:
>>                 Usage       Events/s    Category       Description
>>             100.0%                      Device         Audio codec
>>             hwC0D0:
>> IDT
> 
> The usage in powertop doesn't mean what actually consuming the power
> in 100%.  It's a completely different statistics from the CPU usage.
> 
> It shows that the sound driver hasn't gone into the power-saving
> mode, a sort of partial suspend of the device.  It can happen by
> various reasons: e.g. when your system doesn't set up the power_save
> option properly, or your mixer setup blocks it.
> 
> First off, check the value in
> /sys/module/snd_hda_intel/parameters/power_save.  If it shows 0, it
> means the power-saving feature is turned off.  If it's a positive
> value, it means the power-saving may be turned on after the specified
> seconds after closing all usages of sound devices.

Upon boot the value is 0. I can set it to 1 and it stays 1 while running,
however if I suspend to ram and resume, the value gets reset to 0 again.

> Then check "fuser /dev/snd/pcm*" (run as root).  If this shows
> something, the PCM device is still being used, so the power-saving
> can't be activated.

It doesn't show anything.

> If nothing is using the PCM device, but still no power-saving is
> activated, check the mixer setup.  Check "amixer -c0 contents", and
> see whether any element with "Playback Switch" string is turned on.
> If anything else than "Speaker", "Headphone", "Master" (or sometimes
> "Front" or "Surround", too) is turned on, this is likely an analog
> loopback control, which constantly blocks the power-saving feature.
> Turn them off.

Here's all instances of "Playback Switch":

numid=13,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=2,iface=MIXER,name='Front Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=4,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=25,iface=MIXER,name='IEC958 Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=6,iface=MIXER,name='Beep Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off

> If nothing still helps, give alsa-info.sh output at this state.

http://www.alsa-project.org/db/?f=54ea874f43f12c1572aff3ee3113dc4b0ad0b398

Thanks,
*t

>> in Tunable tab:
>>    Good          Runtime PM for PCI Device Intel Corporation 6
>>    Series/C200
>> Series Chipset Family High Definition Audio Controller
>> 
>> Top shows:
>> top - 01:12:28 up 4 days,  4:10,  3 users,  load average: 0.04, 0.14,
>> 0.21
>> Tasks: 181 total,   2 running, 179 sleeping,   0 stopped,   0 zombie
>> %Cpu(s):  0.2 us,  0.3 sy,  0.0 ni, 99.5 id,  0.0 wa,  0.0 hi,  0.0 si,

>> 0.0 st
>> KiB Mem:   4007896 total,  3773420 used,   234476 free,   266220
buffers
>> KiB Swap:  8280060 total,      272 used,  8279788 free,  2096072 cached
>> 
>> If I start alsamixer and press "F5" (nothing else!), the previous
number
>> in powertop will go down to:
>> 
>>                 Usage       Events/s    Category       Description
>>               0.0%        Audio codec hwC0D0: IDT
>> 
>> after about 5 seconds.
> 
> Again, this doesn't mean that your machine is consuming too much
> power.  But please check the behavior at first with the latest 3.7-rc5
> kernel.
> 
>> I have tried also tried the following workaround:
>> 
>>   echo 1 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
>>   echo Y | sudo tee
>> /sys/module/snd_hda_intel/parameters/power_save_controller
>> 
>> mentioned in Ubuntu's Launchpad:
>>   
>>  
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/37
>> 
>> but that had no visible impact.
> 
> In the earlier kernel before 3.7, setting the power_save option alone
> doesn't trigger the power-saving mode.  It's activated after the first
> use of the device.  But this was improved in 3.7 kernel so that the
> power-saving is kicked off immediately.
> 
> 
> Takashi
> 
>> The bug is a regression, since I did not have the problem under the
>> previous Ubuntu
>> Precise installation. However I *think* I was running a non-standard
>> kernel there (my HD crashed, so I can't verify this assertion).
>> 
>> > If it's really a CPU usage, try to run perf and check what is
spinning
>> > around.
>> 
>> I ran "perf top", but I can't find anything interesting there:
>> 
>> Events: 8K cycles
>> 
>>  15.69%  libxul.so                      [.] 0x9c31ae
>>  12.49%  libmozjs.so.10d                [.] 0xd4f72
>>   7.38%  [kernel]                       [k] intel_idle
>>   3.15%  powertop                       [.] 0x283ae
>>   2.40%  Xorg (deleted)                 [.] 0xc3894
>>   2.26%  libc-2.13.so                   [.] 0x786ea
>>   1.41%  libQtCore.so.4.8.2             [.] 0xbc8fb
>>   ...
>> 
>> Thanks,
>> *t
>> 
>> >> The bug tracking can be found here:
>> >> 
>> >>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560
>> >> 
>> >> is there anything known about this problem? What the root of
>> >> the problem is? How to solve it? Are there patches? Are there
>> >> kernels that have fixed the problem? Are there workarounds?
>> >> 
>> >> The problem seems to be impacting quite a few users.
>> >> *t
>> >> _______________________________________________
>> >> Alsa-devel mailing list
>> >> Alsa-devel@alsa-project.org
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>
>>
