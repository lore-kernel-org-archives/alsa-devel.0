From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Sat, 17 Nov 2012 01:48:47 +0100
Message-ID: <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 010E2261981
 for <Alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 01:48:55 +0100 (CET)
In-Reply-To: <s5hmwyhh6vg.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Fri, 16 Nov 2012 17:04:03 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 16 Nov 2012 15:23:06 +0100, Tomas Pospisek wrote:
>> 
>> The kernel of the upcoming Debian release and some
>> recent kernels of Ubuntu seem to be suffering from HDA
>> running at full force upon wakeup and producing
>> a lot of heat (keeping the fan spinning loudly).
> 
> What do you mean "wakeup"?

Waking up from suspend to RAM.

>  Which kernel are you using?

3.2.0-4-amd64 from Debian wheezy:
  http://packages.debian.org/wheezy/linux-image-3.2.0-4-amd64

> Which codec and HD-audio controller chips?

Wrt codec - I don't know. Before suspending I am not playing any sound.
And the
system (say the desktop system or the bell in a terminal) isn't producing
any sound either.

Powertop says "Audio codec hwC0D0: IDT". Other People in the launchpad
bugtracker seem to be reporting either "hwC0D0: IDT", "hwC0D0: Conexant" or
"hwC0D1: Conexant". 

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560

Here's the chip:

Audio:
00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)

>  Please elaborate a bit more instead of a bug track URL.  This will save
lots of time for other people.

Powertop v2.0 shows:
in the Overview tab:
                Usage       Events/s    Category       Description
            100.0%                      Device         Audio codec hwC0D0:
IDT

in Tunable tab:
   Good          Runtime PM for PCI Device Intel Corporation 6 Series/C200
Series Chipset Family High Definition Audio Controller

Top shows:
top - 01:12:28 up 4 days,  4:10,  3 users,  load average: 0.04, 0.14, 0.21
Tasks: 181 total,   2 running, 179 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us,  0.3 sy,  0.0 ni, 99.5 id,  0.0 wa,  0.0 hi,  0.0 si, 
0.0 st
KiB Mem:   4007896 total,  3773420 used,   234476 free,   266220 buffers
KiB Swap:  8280060 total,      272 used,  8279788 free,  2096072 cached

If I start alsamixer and press "F5" (nothing else!), the previous number
in powertop will go down to:

                Usage       Events/s    Category       Description
              0.0%        Audio codec hwC0D0: IDT

after about 5 seconds.

I have tried also tried the following workaround:

  echo 1 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
  echo Y | sudo tee
/sys/module/snd_hda_intel/parameters/power_save_controller

mentioned in Ubuntu's Launchpad:
  
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560/comments/37

but that had no visible impact.

The bug is a regression, since I did not have the problem under the
previous Ubuntu
Precise installation. However I *think* I was running a non-standard
kernel there (my HD crashed, so I can't verify this assertion).

> If it's really a CPU usage, try to run perf and check what is spinning
> around.

I ran "perf top", but I can't find anything interesting there:

Events: 8K cycles

 15.69%  libxul.so                      [.] 0x9c31ae
 12.49%  libmozjs.so.10d                [.] 0xd4f72
  7.38%  [kernel]                       [k] intel_idle
  3.15%  powertop                       [.] 0x283ae
  2.40%  Xorg (deleted)                 [.] 0xc3894
  2.26%  libc-2.13.so                   [.] 0x786ea
  1.41%  libQtCore.so.4.8.2             [.] 0xbc8fb
  ...

Thanks,
*t

>> The bug tracking can be found here:
>> 
>>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/877560
>> 
>> is there anything known about this problem? What the root of
>> the problem is? How to solve it? Are there patches? Are there
>> kernels that have fixed the problem? Are there workarounds?
>> 
>> The problem seems to be impacting quite a few users.
>> *t
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
