From: Pietro <pxpert@gmail.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
	driver" to the asoc tree
Date: Wed, 01 Jun 2016 10:38:58 +0200
Message-ID: <4617455.AlsP6hqDsl@wks-pdc-gentoo>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <2387755.MGqpljUrLg@wks-pdc-gentoo>
 <cba64f0e-9ca2-e4a6-5436-ea68cc1e9fcc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE232652D7
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 10:39:00 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id a20so16656095wma.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Jun 2016 01:39:00 -0700 (PDT)
In-Reply-To: <cba64f0e-9ca2-e4a6-5436-ea68cc1e9fcc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The Kernel error messages should be related to the Intel DRM graphics, so I don't care about them (at least for now).

Anyway I don't know if tese warning can in some way be related to my problem:

[    9.565990] rt5651 i2c-10EC5651:00: ASoC: mux INL1 Mux has no paths
[    9.586586] rt5651 i2c-10EC5651:00: ASoC: mux INR1 Mux has no paths
[    9.586596] rt5651 i2c-10EC5651:00: ASoC: mux INL2 Mux has no paths
[    9.586601] rt5651 i2c-10EC5651:00: ASoC: mux INR2 Mux has no paths
[   12.646035] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[   12.649356] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[   12.652673] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[   12.656323] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[   12.659868] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[   12.663456] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!

-------------


For your convenience I've extracted the DSDT from Android and Linux, because they seem to differ. Here they are:

DSDT Linux: http://paste.ubuntu.com/16885538/
DSDT Android: http://paste.ubuntu.com/16885557/

And this is the dmesg from android: http://pastebin.com/nY5mtW76


Here are the Firmware Blobs I'm currently using:
	http://pastebin.com/UKN0c0as (Fw listing)
	https://drive.google.com/file/d/0By5f76WVVa0Eb3RacGZRbzNGeFU/view?usp=sharing (Fw blobs)

When I'll return home I'll try to record and play and let you know.

Thanks,
Pietro

On Tuesday 31 May 2016 17:26:30 Pierre-Louis Bossart wrote:
> On 5/31/16 3:56 PM, Pietro wrote:
> > Hi,
> > Here are the answers:
> >
> > - tracing to make sure you are actually on a CHT device
> >   The device should be CHT (The processor is an Atom X3-Z8300). Can it be that the processor is an X3 series, but the platform is BT and not a CHT? I know many manifacturers simply upgraded their notebooks series from BT to CHT by changing the CPU and mantaining all the other components the same (For example the Audio codec).
> >   How can I trace this?
> 
> you see a lot of references to cherrytrail-cr and 22A8, the right ID.
> >
> > - pastebin dmesg somewhere
> >   Here is it: http://pastebin.com/FnpAD1kg
> 
> You have lots of errors or warnings in there. Not sure why, i have 
> machines that don't behave as badly.
> 
> I am not sure why using the CHT firmware leads to an error, somehow you 
> probably have a combination of issues. I would really start there, if 
> the regular firmware doesn't work for you something is very wrong.
> 
> > - sudo cat /sys/bus/acpi/devices/10EC5651:01/status
> >   Here are the results:
> >   /sys/bus/acpi/devices/10EC5651:00/status
> >     Returns 15
> 
> this matches what the machine driver expects so that's good.
> >
> >   /sys/bus/acpi/devices/10EC5651:01/status
> >     Returns 0
> >
> > - enabling DSP loopbacks to see if the DSP consumes data at the right  rate. look at the UCM file and change cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on if you record and loopback on USB output this should play at the right speed.
> >   I've changed the value in the HiFi file, but no changes.
> >   How can i enable DSP loopbacks? I'm not an alsa developer so I need some help here :)
> 
> you need to record to enable the loopback while you play...
> >
> > Please let me know if you need other informations.
> 
> can you extract the DSDT and pastebin it as well?
> 
> >
> > On Tuesday 31 May 2016 15:27:45 Pierre-Louis Bossart wrote:
> >> the changes look ok
> >>>
> >>> But I still have the same problem: Audio plays slowly.
> >>>
> >>>
> >>>
> >>> It seems the DSP is clocked at 19.2, but the system is still clocked for
> >>> 25, and these changes doesn't seem to have effects...
> >>
> >> no, CHT doesn't have a 25 MHz clock at all so that's just not physically
> >> possible.
> >>
> >> Can you try:
> >> - tracing to make sure you are actually on a CHT device
> >> - pastebin dmesg somewhere
> >> - sudo cat /sys/bus/acpi/devices/10EC5651:01/status
> >> - enabling DSP loopbacks to see if the DSP consumes data at the right
> >> rate. look at the UCM file and change
> >> cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on
> >> if you record and loopback on USB output this should play at the right
> >> speed.
> >>
> >>
> >>
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
