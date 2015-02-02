From: Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: Re: Digital Input on ALC3661 (from laptop HDMI IN) not
 working under Linux
Date: Mon, 02 Feb 2015 20:26:21 +0100
Message-ID: <54CFCF5D.7050500@googlemail.com>
References: <CAN8ccia2tYdtR1-ECkC74UoiROAvf3faWSZ_Da09p2C24_9YnQ@mail.gmail.com>	<CAN8ccibptPwFidyNM9TAHjqQg_-xiXEcw3oaaqZDetn-GPVZrg@mail.gmail.com>	<CAN8cciZWU6-CfKKK21L39nkOqMJtNJL3k06iHWpF_J7oq=DzCg@mail.gmail.com>	<CAN8cciZV2Z=6yck7RHpgLUK-o7rXY+i51usMgss+xH4wkZHDDA@mail.gmail.com>	<54BA8801.6080508@googlemail.com>
 <CAN8cciZi-b-tSKZ0OkhKQtGPdfMTkGyKfrMxcnrDip1jSZPQUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F072606E7
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 20:26:23 +0100 (CET)
Received: by mail-wg0-f47.google.com with SMTP id n12so40693850wgh.6
 for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2015 11:26:23 -0800 (PST)
In-Reply-To: <CAN8cciZi-b-tSKZ0OkhKQtGPdfMTkGyKfrMxcnrDip1jSZPQUg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 02.02.2015 um 08:05 schrieb Raymond Yau:
> 
>>
>> >> I have an Alienware 17 laptop (sometimes called M17RX5) which has a
>> > Realtek ALC3661.
>> >>The problem I describe here should also be valid for the Alienware 18
>> > (all the late 2013 models, which are still the most current). At least
>> > some scattered forum reports suggest so.
>> >
>> >>The card works almost perfect in Linux, but one functionality is
>> > missing: The laptop features an HDMI input, and the Realtek card is
>> > supposed to take care of the incoming digital audio.
>> > This works fine in Windows, but in Linux, I only get the video and the
>> > audio stays missing.
>> >
>> >> Here you can find my alsa-info:
>>
>>http://www.alsa-project.org/db/?f=0a0502e49212a0436a30fde9d4ee56163bbc2ebc
> <http://www.alsa-project.org/db/?f=0a0502e49212a0436a30fde9d4ee56163bbc2ebc>
>> >
>> > The only digial input is node 0x0a
>> >
>> > Try hda-jack-retask to change node 0x1f  with pin default [Jack]
> digital In
>>
>> Thanks a lot for your suggestion!
>> I tried, 0x0a stays as "not present" but I can select it in alsa-mixer
>> as expected. Sadly, I can only record silence.
>> Also setting Jack Detection to "Present" in the advanced overrides of
>> hdajackretask did not help.
> 
> http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD
> 
> You have to select "show unconnected pin" and "advanced override"
> 
> Change the pin default of node 0x1f to 0x3c61130 [Jack] SPDIF In
> 
> Set as boot default and reboot
> 
> Digital capture device 1 will be created after you fix the pin default
> of node 0x1f
> 
> Turn on iec958 capture switch and try
> 
> arecord -D IEC958:CARD=PCH -f dat -v test.wav

Thanks a lot for your continued help!

Here's what I did - the sad news, I still record only silence:
1. use hdajackretask as you explained, apply as boot default.
2. I got the following files:

/etc/modprobe.d/hda-jack-retask.conf (below the automatic comment):
options snd-hda-intel
patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw

/lib64/firmware/hda-jack-retask.fw:
[codec]
0x10ec0668 0x102805aa 0

[pincfg]
0x12 0x99a30140
0x14 0x90170110
0x15 0x0321101f
0x16 0x03211020
0x18 0x40030008
0x19 0x03a11030
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x41000001
0x1e 0x411111f0
0x1f 0x03c61130

It contains exactly the line 0x1f 0x03c61130, so I hope I clicked
correctly in the GUI.

3. After reboot, I see in dmesg (I assume this means it worked):
[    6.021374] snd_hda_intel 0000:00:1b.0: Applying patch firmware
'hda-jack-retask.fw'
[    6.021468] snd_hda_intel 0000:01:00.1: Disabling MSI
[    6.021471] snd_hda_intel 0000:01:00.1: Applying patch firmware
'hda-jack-retask.fw'
[    6.022749] snd_hda_intel 0000:00:1b.0: irq 29 for MSI/MSI-X

4. I activate S/PDIF capture in alsamixer (IEC958 is not shown there,
but S/PDIF appeared new after the change).

5. arecord -L tells me at the end:
iec958:CARD=PCH,DEV=0
    HDA Intel PCH, ALC3661 Digital
    IEC958 (S/PDIF) Digital Audio Output

6. I run, as suggested:
arecord -D iec958:CARD=PCH -f dat -v test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Hooks PCM
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
Slave: Hardware PCM card 1 'HDA Intel PCH' device 1 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
  appl_ptr     : 0
  hw_ptr       : 0

But I get only silence, I tried to first attach the HDMI + switch to the
video and start recording when everything is connected (i.e. when I
would hear audio in Windows).
I also tried to just record with the HDMI-cable connected and audio
coming in (but not switched to video - in this case, I would hear
nothing in Windows, but the audio should still arrive).

Both cases, I record just silence.

Any further ideas?

Thanks a lot for your assistance!

> 
>> >
>> > Node 0x1f [Pin Complex] wcaps 0x400681: Stereo Digital
>> >   Pincap 0x00000020: IN
>> >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>> >     Conn = 1/8, Color = Black
>> >     DefAssociation = 0xf, Sequence = 0x0
>> >     Misc = NO_PRESENCE
>> >   Pin-ctls: 0x20: IN
>> >   Unsolicited: tag=00, enabled=0
>> >   Power states:  D0 D1 D2 D3 EPSS
>> >
>> >>In Windows, I observe the HDMI-IN audio routing to the speakers is only
>> > done if the Realtek Audio Service is running. In Linux, I observe
>> > keypress-events when I either switch manually to the HDMI-in signal
> and also
>> > if a new signal is detected (something (the UEFI?) injects a keypress
>> > then).
>> > I assume the service in Windows catches these events and changes
>> > "something" in the Realtek Audio Settings. I see no special recording
>> > device in Windows, nor any explicit HDMI-input setting, nor any related
>> > setting in the driver. Dell links a standard Realtek driver in their
>> > support section.
>>
> 
