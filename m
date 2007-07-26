From: "Steven King" <steven.king.80@gmail.com>
Subject: Re: Intel HDA Driver - Bug
Date: Thu, 26 Jul 2007 18:14:03 +0100
Message-ID: <af8dbbad0707261014i5aef678exa5626c888f348406@mail.gmail.com>
References: <af8dbbad0707260832t6d6d2182kbac2a6ff2ad8a88a@mail.gmail.com>
	<s5hhcnrtbz0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F191037F7
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 19:14:04 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so560634ugf
	for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2007 10:14:03 -0700 (PDT)
In-Reply-To: <s5hhcnrtbz0.wl%tiwai@suse.de>
Content-Disposition: inline
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

Hi Takashi,

I have grabbed the source tree: hg clone
http://hg.alsa-project.org/alsa-kernel, hg clone
http://hg.alsa-project.org/alsa-driver

I compiled the module and reloaded it. The main speaker and headphones work
(with HP jack detect), however the mic is still not working (a mic jack).
In alsamixer I get: ADCMux, InMux and InVol, I turned these all up to full
and tried using gnome-sound-recorder to record sound, no luck. With Digital
Input Source ->

What can I do to work out the correct input device? I think that no mic
input is detected during autoconfiguration.

Thanks for your help,

Steve

On 7/26/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Thu, 26 Jul 2007 16:32:00 +0100,
> Steven King wrote:
> >
> > Hi,
> >
> > I have been trying to get the sound on my Dell Inspiron 1720 laptop
> > running under Debian Etch (STAC 9205). Originally, I could only get
> > sound through the main speakers, there was no headphone sound or mic.
> >
> > I downloaded the latest alsa-drivers package (1.0.14), compiled it and
> > installed it. I received the following messages (and the device would
> > not register itself):
> >
> > hda_intel: azx_get_response timeout, switching to polling mode...
> > hda_intel: azx_get_response timeout, switching to single_cmd mode...
> >
> > I started digging into the driver code and found an issue with one of
> > the routines going outside an array.
> >
> > The offending code is (all in patch_sigmatel):
> > static void stac92xx_set_config_regs(struct hda_codec *codec)
> > {
> > // ...
> > for (i = 0; i < spec->num_pins; i++) {
> > // ...
> > }
> >
> > And in:
> > static int patch_stac9205(struct hda_codec *codec)
> > {
> > // ..
> > spec->num_pins = 14 ; //ERROR
> > // ..
> > }
> >
> > However, there are only 12 pins with 12 corresponding NIDs and default
> > configuration so in stac92xx_set_config_regs it accesses
> > spec->pin_configs[i] and spec->pin_nids[i] outside of bounds.
> >
> > Fix: Add a define (STAC_9205_MAX_PINS = 12) and use for array defines
> > and num_pins.
>
> It's a known problem and was fixed on HG repo weeks ago.
>
> BTW, it seems that hg-mirror.alsa-project.org is out of sync.  Try
> hg.alsa-project.org instead.
>
>
> thanks,
>
> Takashi
>
