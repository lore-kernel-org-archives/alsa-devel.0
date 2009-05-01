From: Ryan Dunn <oryandunn.ml@gmail.com>
Subject: Re: module snd-atiixp issue with
	suspend/hibernate/resume
Date: Thu, 30 Apr 2009 22:12:34 -0400
Message-ID: <bf4fda4a0904301912g3e4f0d86vc32e8a301ff34c19@mail.gmail.com>
References: <bf4fda4a0904282106u7fd3ed03s8d1234423abd679@mail.gmail.com>
	<75b66ecd0904291942u3b352dbj74e5de00ebdf167b@mail.gmail.com>
	<bf4fda4a0904292143s34744db8xbf0b4524567d772@mail.gmail.com>
	<s5h1vralmag.wl%tiwai@suse.de>
	<bf4fda4a0904300449v7a5db4d6vfdf2f772ce102543@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 430711037EC
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 04:12:36 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2326824bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2009 19:12:35 -0700 (PDT)
In-Reply-To: <bf4fda4a0904300449v7a5db4d6vfdf2f772ce102543@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is a diff of the registers before & after resume:
diff regs_before_suspend.txt regs_after_suspend.txt
58c58
< 0:72 = 0000
---
> 0:72 = 5000

In the ac97_codec.h file, AC97_POWERDOWN = 0x26.  Does this respond to 0:26
in the regs file?  If so, it doesn't appear that bit 0x8000 is ever set, but
the mute LED works.

On Thu, Apr 30, 2009 at 7:49 AM, Ryan Dunn <oryandunn.ml@gmail.com> wrote:

> Thanks Takashi,
>
> I did a bit more testing last night.  The LED does work after a reboot (I
> don't know what I was doing that I thought it didn't).  It also retains
> state after a reboot if I muted it before the reboot.  One thing I noticed,
> if I have it muted when I suspend, on resume, it looks like the mute led
> flashes back on for a split second, then turns off.  Maybe the resume code
> is overwriting the register?  I'll start digging through that code tonight.
>
> Ryan
>
>
> On Thu, Apr 30, 2009 at 1:53 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Thu, 30 Apr 2009 00:43:02 -0400,
>> Ryan Dunn wrote:
>> >
>> > Thanks Lee,
>> >
>> > I grabbed the kernel source from the repos and started perusing the
>> code.  It
>> > looks like when the module is installed, the call chain starts in
>> atiixp.c and
>> > moves into ac97/ac97_codec.c via a call to snd_ac97_tune_hardware()
>> which
>> > ultimately twiddles a bit in the AC97_POWERDOWN register.  I'm not sure
>> yet if
>> > the suspend method properly saves this register on suspend or not;
>>
>> It should.  snd_ac97_resume() writes the cached value.
>> Check /proc/asound/card0/codec97#0/ac97#*+regs files before and after
>> suspend.  You can change the codec register value directly via proc
>> file, e.g.
>>    # echo 0x12 0x1234 > /proc/asound/card0/codec97#0/ac97#0-0+regs
>> (only when you build with the debug option).
>>
>> The bit 0x8000 of the power-down register should correspond to LED.
>>
>>
>> Takashi
>>
>> > or if the
>> > same call chain needs to be repeated on a resume.  I appreciate your
>> quick and
>> > relevant answer.  When I get time, I'll start adding some debug
>> printouts to
>> > try this out.
>> >
>> > Also, the struct ac97_quirk ac97_quirks[] array has a couple of entries
>> in it
>> > currently (in the atiixp.c file).  How do I get the subvender/subdevice
>> id's
>> > for my system (I didn't seem to have luck with lspci, unless I'm not
>> looking
>> > in the right fields)?  Would it be possible to edit the driver so that
>> an
>> > explict module option would not be needed on my hardware?
>> >
>> > Thanks,
>> > Ryan
>> >
>> > On Wed, Apr 29, 2009 at 10:42 PM, Lee Revell <rlrevell@joe-job.com>
>> wrote:
>> >
>> >     On Wed, Apr 29, 2009 at 12:06 AM, Ryan Dunn <oryandunn.ml@gmail.com
>> >
>> >     wrote:
>> >     > I have a Compaq V2000 laptop with the ATI IXP chipset and make use
>> of
>> >     the
>> >     > snd-atiixp module.  The laptop needs to have the ac97_quirk option
>> set
>> >     to 7
>> >     > to enable the mute LED.  After setting this option in the
>> >     > /etc/modprobe.d/options.conf file, the mute LED works after a
>> reboot.
>> >     > However, after a resume from suspend or hibernate, the mute LED
>> does not
>> >     > work.  The alsa-info.sh script reports that the quirk is still set
>> with
>> >     7.
>> >     > At this point a reboot will NOT fix the problem.  The only way to
>> fix it
>> >     is
>> >     > to remove and reinsert the module with modprobe.
>> >     >
>> >     > This is on a fresh Ubuntu 9.04 install.  Any ideas?  I wasn't sure
>> if
>> >     this
>> >     > should be reported here or on the kernel list.  I saw a similar
>> issue
>> >     with
>> >     > the ac97_quirk on the kernel list and they were referred here.
>>  I'm a
>> >     > software developer, so I'd be willing to try ideas/possible
>> solutions if
>> >     you
>> >     > have them.
>> >
>> >     Get the Ubuntu source code for the package that owns that ALSA
>> driver,
>> >     find the place in the driver's initialization code where
>> ac97_quirk=7
>> >     is handled, then check the driver's suspend and resume callbacks and
>> >     make sure the suspend callback is correctly saving the LED state and
>> >     that the resume callback is re-initializing the LED from the saved
>> >     state in the same way the init code does.  grep and printk() are
>> your
>> >     friends ;-)
>> >
>> >     HTH,
>> >
>> >     Lee
>> >
>> >
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
