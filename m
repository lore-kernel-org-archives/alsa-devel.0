From: David Ulricht <david.ulricht434@gmail.com>
Subject: Re: Subwoofers aren't working on ALC298 (Lenovo Yoga
 C930 Laptop)
Date: Thu, 29 Nov 2018 07:00:58 +0200
Message-ID: <CALbf9MwUVM6iDRLukPRrPBa0soKg-B-zSp9gQFGkpEYaWE=jug@mail.gmail.com>
References: <871s77zw23.fsf@gmail.com>
 <32e2283a-8a5e-25a6-de95-bfb568341269@64studio.com>
 <871s75tdr9.fsf@gmail.com>
 <CALbf9MznCgTE8rTm-6WLEeYAQE5iHbVAn9_SNfHEOuRTpYNNgA@mail.gmail.com>
 <8736rkbkml.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1348E267B11
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 06:01:10 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id w13so561448oiw.9
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 21:01:10 -0800 (PST)
In-Reply-To: <8736rkbkml.fsf@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Reeve <jon.reeve@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ooops I have misleaded you with PinConfigOverride that's for all the Macs,
dont look for it anymore.

Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Bass Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 3
     0x0c 0x0d 0x06*

Looking at your alsa-info, this is your Bass Speaker Playback Switch.
It is in current Power setting=D3 and actual=D3.
It should become D0 to be turned on.

Not sure if you can do this via alsamixer -c0 ?(or whatever number is your
card).
there is also a way with hda-verb (make sure you have hda-verb installed
(from <ftp://ftp.alsa-project.org/pub/tools/alsa-tools-1.1.7.tar.bz2>
alsa-tools <ftp://ftp.alsa-project.org/pub/tools/alsa-tools-1.1.7.tar.bz2>
?))

According to https://www.kernel.org/doc/html/v4.16/sound/hd-audio/notes.html

power_save_node (bool) advanced power management for each widget,
controlling the power sate (D0/D3) of each widget node depending on the
actual pin and stream states
could be a permanent more elegant solution in a hda-jack-retask.fw patch,
but no idea how it should look for that widget exactly, Takashi can suggest.

You can try for now enabling that Power: setting=D0, actual=D0
if that will help you probably:

Documentation is at:
https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/high-definition-audio-specification.pdf
Page 153 is of your interest.
0x705 is the SET verb, 0x00 should be fully on D0 state
# sudo hda-verb /dev/snd/hwC0D0 0x17 0x705 0x00
you can get the value from the codec back:
# sudo hda-verb /dev/snd/hwC0D0 0x17 0xf05 0x00

Hope that helps, if that solves the solution as a dirty thing you can put
that hda-verb command in your /etc/rc.local (depending on the distro
rc.local maybe deadend).




On Thu, Nov 29, 2018 at 5:58 AM Jonathan Reeve <jon.reeve@gmail.com> wrote:

>
> Hi David,
>
> Thanks very much for helping me look into this.
>
> > Have you tried any other distribution, something more normal
> > like latest
> > Fedora or Ubuntu ? Does the subwoofers work there ?
>
> I just tried an Ubuntu live USB disk. I can't get subwoofers to
> work
> there, either.
>
> > If you run Ubuntu/Fedora you can check the sound settings and
> > pavucontrol
> > there is selection of speakers usually 2.1 5.1... try those ?
>
> I don't see any option for that in pavucontrol on Ubuntu.
>
> > And you have to make sure those [pincfgs] match with your
> > Windows10
> > registry of the driver's PinConfigOverride.
>
> Awesome. How can I find these settings? I checked in regedit and
> searched
> for `pinconfigoverride` and `pincfg`, but nothing's coming up. I
> also
> grepped all the driver files for those expressions, but nothing's
> coming
> up there, either. Do you know if these settings are called
> something
> else?
>
> > You happen to have Windows running on that machine and can
> > extract the
> > pinconfigoverride or have .ini of the driver? I can help you
> > compare
> > those.
>
> Yep, I have the Windows 10 driver files, but there is no .ini
> file, as far as
> I can tell. There are lots of text files that look like they could
> be
> configuration files of some sort. Which one(s) should I be looking
> for?
>
> Best,
>
> Jonathan
>
