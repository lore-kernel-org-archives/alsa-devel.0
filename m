From: John Frankish <john.frankish@outlook.com>
Subject: Re: Intel alsa sound request for Laptops
Date: Sun, 29 Jan 2017 13:06:43 +0000
Message-ID: <DBXPR04MB3340B7837734E0527D14872F3480@DBXPR04MB334.eurprd04.prod.outlook.com>
References: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hwpdf9nzt.wl-tiwai@suse.de>
 <DBXPR04MB334D7AB20A0F4C15ADD0CB2F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5htw8j9bsu.wl-tiwai@suse.de>
 <DBXPR04MB334707A6AE3893371F3297DF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hr33m9ugc.wl-tiwai@suse.de>
 <DBXPR04MB334ED59C445FC8FA14DC8EEF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hmvea9sbm.wl-tiwai@suse.de>
 <DBXPR04MB3345B50F2D5C5CED7B57554F3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hefzm9hp4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BAY004-OMC4S22.hotmail.com (bay004-omc4s22.hotmail.com
 [65.54.190.224])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F3D266B88
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 14:06:54 +0100 (CET)
In-Reply-To: <s5hefzm9hp4.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > > > > > > > > > For two or three kernel versions of alsa divers now, 
> > > > > > > > > > HDMI has been the default alsa device on my laptop (Dell Latitude E7240) - this does not make logical sense.
> > > > > > > > > >
> > > > > > > > > > In the latest kernel version I use, 4.2.9, alsa sound 
> > > > > > > > > > will not work at all unless I load the i915 kernel 
> > > > > > > > > > driver
> > > > > > > > > > - this does not make logical sense and means that I cannot use Xvesa.
> > > > > > > > > > 
> > > > > > > > > > Is it possible to make an alsa feature request for 
> > > > > > > > > > analogue sound to be the default alsa device on laptops and for alsa sound to work without the need
> > > > > > > > > > to load the i915 kernel driver?
> > > > > > > > > >
> > > > > > > > > It's a configuration issue.  Pass the module option if you prefer the secondary device:
> > > > > > > > > 
> > > > > > > > > options snd-hda-intel index=1,0
> > > > > > > > > 
> > > > > > > > Sure, I realise I can do that, but it's not the point and it's awkward to do so with the "live CD-type" distro I use (tinycorelinux).
> > > > > > > >
> > > > > > > > Laptop sound should work in standalone mode by default - i.e. 
> > > > > > > > if laptop uses analogue sound for its built-in speakers then the alsa default should be analogue sound.
> > > > > > > > 
> > > > > > > > The above notwithstanding, analogue sound should work without needing to load the i915 kernel driver.
> > > > > > > > 
> > > > > > > For a smart automation, use PulseAudio.  It's exactly for such a purpose.
> > > > > > > 
> > > > > > > The kernel driver assigns each device just in the order how they are enumerated.
> > > > > > > In the case of HD-audio, it's the order of PCI devices.
> > > > > > > It's nothing different from any other PCI drivers.
> > > > > > >
> > > > > > OK, but I should not have to add bloat like pulseaudio in order to have basic sound functionality.
> > > > > > 
> > > > > For getting the basic sound functionality, you have to set up something.
> > > > > You're asking the high-level automation, hence you need something like PA.
> > > > > 
> > > > I'm not asking for high level automation, I'm asking that when I 
> > > > boot my laptop with alsa the built-in speakers work by default
> > > 
> > > Your machine has multiple audio devices, thus you have to prioritize the device to pick up.
> > > It's already a high level decision that the kernel doesn't care as 
> > > default, thus it requires either a high-level automation or some manual adjustment in user-space.
> > > 
> > > You're asking a simple thing, but it's not simple as you think.
> > > 
> > I don't say that it's simple, but I believe it is a reasonably expectation.
> > 
> And this expectation is already a high-level; i.e. it's more than the kernel level.
> So a reasonably expected answer is: use PA if you do want everything working without the manual adjustment.
> 
> > > > > > Of course, you're free to reimplement a wheel if you don't like PA.
> > > > > > A similar thing can be achieved just by delaying the sound 
> > > > > > driver module loading at udev level, or dynamically evaluating 
> > > > > > the priority per PCI ID, at udev and assigning the index appropriately there.
> > > > > > (Just an idea, though.)
> > > > > >
> > > > > > You also don't mention why I should have to load a graphics driver (i915) in order to get analogue sound? That makes no sense at all...
> > > > > >
> > > > > The lack of i915 influences on the index assignment since the HDMI codec driver probe fails without i915.
> > > > > It's the reason why the secondary HD-audio codec appears as the first, eventually it's the analog audio output in your case.
> > > > >
> > > > I do not use the i915 driver at all - as far as I know, it still 
> > > > has the "pipe state doesn't match" bug - Xvesa doesn't require it 
> > > > and I use the modesetting driver with Xorg (since after more than a year we're still waiting for a stable xf86-video-intel).
> > > > 
> > > How do you run modesetting X driver without i915 driver?
> > > 
> > > > You appear to be saying that, even if I work from the console 
> > > > prompt, I need to load the unneeded (and buggy) i915 driver in order to have analogue sound.
> > > > 
> > > No, you seem to be mixing up the cause and the result.
> > > 
> > > You really should check why the audio doesn't work when you don't use i915.
> > > As already mentioned, it influences the probe order, as HDMI audio device probe fails without i915.
> > > At least, it works as is, if you're using the latest kernel.
> > > 
> > > If it still doesn't work, report it properly with certain logs.
> > > 
> > snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002) 
> > snd_hda_intel 0000:00:03.0: failed to add i915 component master (-19) 
> > snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3226: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
> > snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
> > snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> > snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> > snd_hda_codec_realtek hdaudioC1D0:    inputs:
> > snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=0x19
> > snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x1a
> > snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
> > input: HDA Intel PCH Dock Mic as 
> > /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
> > input: HDA Intel PCH Dock Line Out as 
> > /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
> > input: HDA Intel PCH Front Headphone as 
> > /devices/pci0000:00/0000:00:1b.0/sound/card1/input13
> > 
> > $ aplay -l
> > **** List of PLAYBACK Hardware Devices **** card 1: PCH [HDA Intel 
> > PCH], device 0: ALC3226 Analog [ALC3226 Analog]
> >   Subdevices: 1/1
> > 
> > $ alsamixer
> > cannot open mixer: No such file or directory
> >  
> I guess you still leave index=1,0 option even if you boot without i915, right?  Then it breaks.
> The option means that it swaps the primary and the secondary cards.  As already mentioned, without i915,
> the primary device, HDMI output is disabled, thus there will be only device.  Still by specifying index=1,0,
> you set the non-existing secondary card as card#0, thus you get such an error, as the apps expect card#0
> to be the default.  See the output above showing "card 1", not "card 0".
> 
> That said, if you boot without i915, drop the index option.
>
I booted without i915 and did not set any index options (the default behaviour of tinycorelinux is to boot clean like a live-CD distro)

> BTW, instead of index option, you can define the default PCM and the control via ~/.asoundrc.
> There you can pass the id name string instead of the card number, so that it's persistent no matter
> which card number is assigned depending on the boot condition.
>
Thanks, but I think I'll leave things here:

My opinion is that the laptop speakers should work by default and that I should not have to load unwanted (and buggy) graphics drivers in order to get sound to work.

Your opinion is otherwise.

The beauty of Linux is that we can agree to disagree :)
