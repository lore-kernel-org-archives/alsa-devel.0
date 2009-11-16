From: "Wael Nasreddine (a.k.a eMxyzptlk)" <mla@nasreddine.com>
Subject: Re: HDA Intel IDT 92HD71B7X - HP Pavilion DV7-1299EF -
	Only the left speaker is working
Date: Mon, 16 Nov 2009 18:07:40 +0100
Message-ID: <d3328e7b0911160907g600fda62jc7022e980d98419f@mail.gmail.com>
References: <d3328e7b0911110722l27597a8bl523052b035e9ec9d@mail.gmail.com>
	<s5hd43o6fp6.wl%tiwai@suse.de>
	<d3328e7b0911111115t3e2201c7r35302f6f7c66b88f@mail.gmail.com>
	<d3328e7b0911120146o317cd32fnc3282a2809aa908f@mail.gmail.com>
	<s5htyx0cak5.wl%tiwai@suse.de>
	<d3328e7b0911140446j6edf0646x5ca7c825ae780a0a@mail.gmail.com>
	<s5htywxmf7d.wl%tiwai@suse.de>
	<d3328e7b0911140625u745f08cdsd0f673c1482bf364@mail.gmail.com>
	<d3328e7b0911150826l6b6fffd6kdad8fb1692445b20@mail.gmail.com>
	<s5hmy2migde.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 4360B1038F6
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 18:08:02 +0100 (CET)
Received: by fxm1 with SMTP id 1so16096222fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 09:08:02 -0800 (PST)
In-Reply-To: <s5hmy2migde.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, julien.cynober@free.fr
List-Id: alsa-devel@alsa-project.org

2009/11/16 Takashi Iwai <tiwai@suse.de>

> At Sun, 15 Nov 2009 17:26:00 +0100,
> Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> >
> > On Sat, Nov 14, 2009 at 15:25, Wael Nasreddine (a.k.a eMxyzptlk) <
> > mla@nasreddine.com> wrote:
> >
> > > On Sat, Nov 14, 2009 at 14:03, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > At Sat, 14 Nov 2009 13:46:37 +0100,
> > > > Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> > > > >
> > > > > [1  <multipart/alternative (7bit)>]
> > > > > [1.1  <text/plain; UTF-8 (7bit)>]
> > > > > On Thu, Nov 12, 2009 at 11:16, Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > > At Thu, 12 Nov 2009 10:46:24 +0100,
> > > > > > Wael Nasreddine (a.k.a eMxyzptlk) wrote:
> > > > > > >
> > > > > > > Takashi,
> > > > > > >
> > > > > > > I tried the snapshot from
> > > > > > >
> > > > > >
> > >
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> > > > > > > last night with and without options still no go, the options
> I've
> > > > > > > tried:
> > > > > > >
> > > > > > > - options snd-hda-intel enable_msi=
> > > > > > > - options snd-hda-intel enable_msi=1 single_cmd=0
> > > > > > > power_save_controller=0 power_save=0 model=hp-dv5
> > > > > >
> > > > > > power_save should be irrelevant.  And model=hp-dv5 and
> enable_msi=1
> > > > > > are already turned on as default in the recent version.
> > > > > >
> > > > > > The next would be model=auto to avoid hp-dv5 quirk.
> > > > > >
> > > > > > Also, it's helpful if you give a summary of your problems again.
> > > > > >
> > > > > >
> > > > > > Takashi
> > > > > >
> > > > >
> > > > > Takashi,
> > > > >
> > > > > I just tried 'options snd-hda-intel enable_msi=1 model=auto' Didn't
> > > > > have much effect, the same problem (sound only from left speaker),
> > > > > always the same result with 'speaker-test -c6 -twav' I can only
> hear
> > > > > 'Front Left'
> > > >
> > > > OK.  But the headphone works, right?
> > > >
> > > Yes Headphones works, even mics works
> > >
> > > >
> > > > > Summary:
> > > > > =======
> > > > >
> > > > > I have an HP DV7-1299EF, BIOS (Version F.2C, F.2A and F.23) , Due
> to a
> > > BIOS
> > > > > BUG, the
> > > > > BIOS report only one speaker as an output so the driver does not
> know
> > > > > how to use pins in order to have a stereo output ( at least that's
> > > > > what you told me last month when you analysed the alsa-info
> output)...
> > > And
> > > > > so one speaker, the left speaker is the only speaker currently
> working
> > > under
> > > > > Linux.
> > > > >
> > > > >
> > > > > First I suspected a hardware problem so 2 days ago I restored
> Windows,
> > > > > tried the sound it works, and I updated my BIOS (it was version
> F.2A
> > > > > before) but sadly it has the same BUG, I also tried reverting back
> to
> > > F.2A
> > > > > and further back to F.23 same result...
> > > > >
> > > > > Attached to this mail, my alsa-info.txt
> > > >
> > > > The codec registers look OK through a quick look.
> > > >
> > > > You can try GPIO pin up/down for each pin.  Also each pin has two
> > > > directions, so you'll have 8 x 2 x 2 trials.
> > > > For example, to test GPIO 3, pass 0x08 (= 1 << 3), try the commands
> > > > below and check aplay at each.  (the lines '//' are just my comments)
> > > >
> > > >        // dir = 0, data = 1
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x00
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x08
> > > >
> > > >        // dir = 0, data = 0
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x00
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
> > > >
> > > >        // dir = 1, data = 0
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
> > > >
> > > >        // dir = 1, data = 1
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x08
> > > >        hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x08
> > > >
> > > > Repeat these for each GPIO pin, from 0 to 7.
> > > >
> > > > One another possibility is to use the output pin NID 0x0f.
> > > > For testing this, build with the reconfig feature (usually enabled),
> > > > then change the pin 0x0f default config, such as
> > > >
> > > >        echo 0x0f 0x90171111 >
> /sys/class/sound/hwC0D0/user_pin_configs
> > > >
> > > > then quit all sound apps and reconfigure
> > > >
> > > >        echo 1 > /sys/class/sound/hwC0D0/reconfig
> > > >
> > > > Restore the mixer setup once via alsactl
> > > >
> > > >        alsactl restore
> > > >
> > > > Then check the mixer volumes again, try aplay.  With this setup,
> > > > try GPIO procedures above, too.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > >
> > > For the tests I've created a little script (attached for review if I
> > > done something wrong), Here's the results
> > >
> > > 0x01:
> > > -------> dir = 0, data = 1  =====> Front Left
> > > -------> dir = 0, data = 0  =====> Front Left
> > > -------> dir = 1, data = 1  =====> Front Left
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x02:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> No Sound
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x04:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> No Sound
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x16:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> No Sound
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x32:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> LFE
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x64:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> LFE
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > > 0x128:
> > > -------> dir = 0, data = 1  =====> No Sound
> > > -------> dir = 0, data = 0  =====> No Sound
> > > -------> dir = 1, data = 1  =====> LFE
> > > -------> dir = 1, data = 0  =====> No Sound
> > >
> > >
> > > I've got the same results with the NID 0x0f
> > >
> > >
> > Hey Takashi,
> >
> > I forgot the
> >
> > 0x08:
> > -------> dir = 0, data = 1  =====> No Sound
> > -------> dir = 0, data = 0  =====> No Sound
> > -------> dir = 1, data = 1  =====> No Sound
> > -------> dir = 1, data = 0  =====> No Sound
> >
> >
> > Looking at the results above, how can I get both the Front Left and LFE
> to
> > output sound? and hopefully we get the right speaker later to work
>
> The LFE could be enabled by the patch below.  Give it a try.
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_sigmatel.c
> b/sound/pci/hda/patch_sigmatel.c
> index 7f76a97..57a561d 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -5468,6 +5468,18 @@ again:
>                break;
>        }
>
> +       /* enable LFE on HP dv7 if available */
> +       if (spec->board_config == STAC_HP_DV5) {
> +               unsigned int cap;
> +               cap = snd_hda_param_read(codec, 0x1, AC_PAR_GPIO_CAP);
> +               cap &= AC_GPIO_IO_COUNT;
> +               if (cap >= 6) {
> +                       spec->gpio_mask |= 0x20;
> +                       spec->gpio_dir |= 0x20;
> +                       spec->gpio_data |= 0x20;
> +               }
> +       }
> +
>        if (hp_bseries_system(codec->subsystem_id)) {
>                pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
>                if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
>
>
Takashi,

Thank you that actually worked, I have now both Front Left and LFE working,
but it's very hard to tell coz the LFE is louder than both front speakers I
even put my ear directly on the speaker and it still can't be 100% sure, but
I think that for now what is working is 'Front Left + LFE', I can't hear
anything from the right speaker.. but it's already an improvement to what I
had.

Do you have any suggestion on how to enable the right speaker?

Thanks


-- 
Wael Nasreddine

Weem Chief-Development Officer - http://www.weem.com

Blog    : http://wael.nasreddine.com
E-mail  : wael.nasreddine@weem.com
gTalk   : wael.nasreddine@gmail.com
Tel     : +33.6.32.94.70.13
Skype   : eMxyzptlk
Twitter : @eMxyzptlk

PGP: 1024D/C8DD18A2 06F6 1622 4BC8 4CEB D724  DE12 5565 3945 C8DD 18A2

.: An infinite number of monkeys typing into GNU emacs,
  would never make a good program. (L. Torvalds 1995) :.
