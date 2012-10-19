From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 17:09:04 +0200
Message-ID: <1350659344.5494.11.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
 <5081539E.40705@gmail.com> <1350654327.8310.4.camel@didier-laptop>
 <50815B51.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 22B6C265B6C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 17:09:09 +0200 (CEST)
In-Reply-To: <50815B51.3090402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On ven., 2012-10-19 at 15:53 +0200, Daniel Mack wrote:
> [Please do not drop the mailing list address]

Oups my bad... Sorry!

> On 19.10.2012 15:45, Didier 'Ptitjes' Villevalois wrote:
> > On ven., 2012-10-19 at 15:20 +0200, Daniel Mack wrote:
> >> On 19.10.2012 15:09, Didier 'Ptitjes' Villevalois wrote:
> >>> Hello,
> >>>
> >>> I've bought a Reloop Play usb soundcard and I'd like to make it work
> >>> with ALSA.
> >>>
> >>> It is a 4-channels USB soundcard. It is currently correctly recognized
> >>> by ALSA as a 4-channels soundcard and I can correctly open the channels
> >>> and feed them with audio. However, no audio is output by the box.
> >>
> >> You're most probably affected by a regression in the driver that was
> >> fixes in 3.6.0 and 3.5.5 (and all later kernels). Could you please try
> >> one of these and tell us if that works?
> > 
> > Sure, I'll do that now (I'm currently using 3.5.4 + mbp8,3 patches).
> > I guess 3.5.7 is OK ? I'm building it now and will reboot on that.
> 
> Any kernel >= 3.6.0 and 3.5.5 should be ok.

So there was no change after rebooting with 3.5.7 kernel.

> >>> It seems to contain a Texas Instrument TUSB3200AC chipset (same chipset
> >>> as the Maya44 USB and Hercules DJ console). I guess the problem is a
> >>> firmware problem but I don't know what to do about it.
> >>>
> >>> I've got a MacOS X driver that works correctly, if that of any help. (I
> >>> suppose the Windows driver works too but I don't have any Windows at
> >>> hand.)
> >>
> >> Did you install any vendor driver on OS X or does it just work with the
> >> one that ships with the OS?
> > 
> > Yep, I had to install the Vendor-provided driver.
> 
> What was the effect without that special driver? Could you see the
> device listed in the AudioMIDISetup? Could you stream audio? IOW, is the
> effect you see there comparable to how your Linux box behaves? You could
> try and remove that driver again and see what happens.

So here is what I did:

1) Removed the MacOs X driver and rebooted
2) Launched AudioMIDISetup (I did not know of this tool before :p)
3) Launched Mixxx

Now the box is outputing some crazy sound when Mixxx is not playing.
When I start playing a track some more noise adds to the existing noise.
Is this simply a PCM format error (sample rate/bit depth) ??

The fun thing (if I can say that) is that after rebooting to Linux 3.5.7
there is now the same sound when I run Mixxx/Linux!! And I can observe
the same added noise when I launch a track.

> > But it seems the
> > built-in USB soundcard support on MacOS is very poor.
> 
> No it's not. In fact, it's actually very good. Vendors who keep their
> hardware compliant to the USB audio spec don't have to ship any driver
> at all. And this is how it should be on Linux, too.

Ah ok!

> > Also the mpkg install file (inside the provided install dmg file) was
> > called something like "firmware0_and_driver.mpkg". This is why I
> > suspected a firmware problem. However I tried to look at the package
> > content and did not find any .bin file or whatever could be a standalone
> > firmware file. Maybe it is embedded in the driver install executable.
> 
> Maybe, but they could also write the firmware permanently to the device
> once with that tool. That would be perfect for Linux users.

I took some screenshots of the AudioMIDISetup app and of the content of
the driver install packages. I don't if that can be of any help. You can
see them here: http://ptitjes.free.fr/screenshots/

I don't know what step I should take know. Reinstalling drivers on OS X
to see if there is any change ?

Thanks again for your help.
Didier.
