From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Thu, 19 Mar 2015 11:55:54 +0800
Message-ID: <CAN8cciY7zPaM1kGbky3st_V5G=vg_aeLrm2QrNbpVinYOU=qyA@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D166E260536
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 04:55:55 +0100 (CET)
Received: by oigv203 with SMTP id v203so55290321oig.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 20:55:54 -0700 (PDT)
In-Reply-To: <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>, nb <nb@dagami.org>
Cc: Hui Wang <hui.wang@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> The internal mic also works.
>
> but; I am a bit puzled, because I tried to comment out 'options
snd-hda-intel model=3stack-digout' and did a powercycle (power off)...
> and now the sound still works, so it seems the soundcard was woken from
some deepsleep.
> The machine have been turned of for many (4/5) years...
>
> Anyway since the soundcard now is working with my current kernel without
the extra options, I am unsure if trying the newest vanilla kernel would
make any sense?
>
> Any recommendations?


Since your pci ssid are same as nb 's ASUS W5A, you will need to ask why
HP and mic disable jack detection and using ALC880_FIXUP_GPIO1

+ [ALC880_FIXUP_ASUS_W5A] = {
+ .type = HDA_FIXUP_PINS,
+ .v.pins = (const struct hda_pintbl[]) {
+ /* set up the whole pins as BIOS is utterly broken */
+ { 0x14, 0x0121411f }, /* HP */
+ { 0x15, 0x411111f0 }, /* N/A */
+ { 0x16, 0x411111f0 }, /* N/A */
+ { 0x17, 0x411111f0 }, /* N/A */
+ { 0x18, 0x90a60160 }, /* mic */
+ { 0x19, 0x411111f0 }, /* N/A */
+ { 0x1a, 0x411111f0 }, /* N/A */
+ { 0x1b, 0x411111f0 }, /* N/A */
+ { 0x1c, 0x411111f0 }, /* N/A */
+ { 0x1d, 0x411111f0 }, /* N/A */
+ { 0x1e, 0xb743111e }, /* SPDIF out */
+ { }
+ },
+ .chained = true,
+ .chain_id = ALC880_FIXUP_GPIO1,

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=29e3fdcc84e5da04cb7e6a36fee0a772c91d3b28

Most asus computers using alc880 were using asus model in previous version

Do the front or surround  playback volume affect the speaker and headphone
in your asus m6s00v ?

Do the mic jack works ?

Do mic boost and front mic boost affect the mic and internal mic ?

Try hdajacksensetest to test the jack detection of hp and mic jack

http://git.alsa-project.org/?p=alsa-tools.git;a=tree;f=hdajacksensetest;hb=HEAD

> > >> I had some problems getting the sound to work on my asus m6s00v
> > >> (I think that is the model, it is a bit worn so I can't really read
it)
> > >>
> > >> the symptoms was
> > >> * on the integrated speakers, no sound at all
> > >> * on the headphone speakers, sound for a very very short period that
> > faded into nothing.
> > >>
> > >> with help from debianuser on freenode#alsa we managed to get it
working.
> > >> the option that i had to load the module with is the following:
> > >> sudo modprobe snd-hda-intel model=3stack-digout
> > >> the status now (perfect)...
> > >> * sound on integrated speaker.
> > >> * sound in headphones (disables integrated speaker output which is
fine)
> > >> * mic works, both for direct playback and recording
> > >> * when recording it is the 'digital' channel that controls the
volume of
> > the recording level, all others
> > >>
> > >> Notice:
> > >> I don't have OSS or pulseaudio installed.
> > >>
> > >> I am thinking it would be really nice if the driver automatically
could
> > detect that this option is required.
> > >>
> > >> this is the output from the alsa-info script
> > >>
> >
http://www.alsa-project.org/db/?f=28b98a3bd1efc6a80dbd5c54b52c4472d8ea5496
> > >>
> > >> let me know if I can do anything to help with this.
> > >
> > > It seems the latest kernel already had a fixup for this machine, but
the
> > fixup is ALC880_FIXUP_ASUS_W5A instead of ALC880_FIXUP_3ST_DIG. Probably
> > you should use latest upstream kernel without "model=3stack-digout" to
test
> > again, if it can't fix your problem, maybe the patch below can work.
> > >
> > > --- a/sound/pci/hda/patch_realtek.c
> > > +++ b/sound/pci/hda/patch_realtek.c
> > > @@ -1349,7 +1349,7 @@ static const struct hda_fixup alc880_fixups[] =
{
> > >
> > >  static const struct snd_pci_quirk alc880_fixup_tbl[] = {
> > >         SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P",
ALC880_FIXUP_W810),
> > > -       SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS W5A",
ALC880_FIXUP_ASUS_W5A),
> > > +       SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS W5A",
ALC880_FIXUP_3ST_DIG),
> > >         SND_PCI_QUIRK(0x1043, 0x1964, "ASUS Z71V", ALC880_FIXUP_Z71V),
> > >         SND_PCI_QUIRK_VENDOR(0x1043, "ASUS", ALC880_FIXUP_GPIO1),
> > >         SND_PCI_QUIRK(0x147b, 0x1045, "ABit AA8XE",
> > ALC880_FIXUP_6ST_AUTOMUTE),
> > >
> > >
> >
> > Sysfs Files
> > !!-----------
> >
> > /sys/class/sound/hwC0D0/init_pin_configs:
> > 0x14 0x0121411f
> > 0x15 0x411111f0
> > 0x16 0x411111f0
> > 0x17 0x411111f0
> > 0x18 0x01a19920
> > 0x19 0x411111f0
> > 0x1a 0x411111f0
> > 0x1b 0x411111f0
> > 0x1c 0xb7331121
> > 0x1d 0x411111f0
> > 0x1e 0x0145411e
> > 0x1f 0x411111f0
> >
> > Simple mixer control 'Channel Mode',0
> >   Capabilities: enum
> >   Items: '2ch' '6ch'
> >   Item0: '2ch'
> > Simple mixer control 'Input Source',0
> >   Capabilities: cenum
> >   Items: 'Mic' 'Front Mic' 'Line' 'CD'
> >   Item0: 'Mic'
> > Simple mixer control 'Input Source',1
> >   Capabilities: cenum
> >   Items: 'Mic' 'Front Mic' 'Line' 'CD'
> >   Item0: 'Mic'
> > Simple mixer control 'Input Source',2
> >   Capabilities: cenum
> >   Items: 'Mic' 'Front Mic' 'Line' 'CD'
> >   Item0: 'Mic'
> >
> > Seem missing internal speaker and redundant  CD pin
> >
> > Do your mic jack and internal mic work as expected ?
> >
> > It is not correct to use 3stack when your laptop does not have three
audio
> > jacks for surround 5.1
> >
> > !!
> >
> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=487a588d09db0d6508261867df208d8bdc718251
> >
> > Seem no mic jack and speaker in w5n
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
