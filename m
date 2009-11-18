From: Christian Hergert <christian.hergert@gmail.com>
Subject: Re: PATCH: ALSA - hda - Add support for Dell E6400
	docking station
Date: Wed, 18 Nov 2009 14:34:29 -0800
Message-ID: <6d4a25b10911181434j7fc0fb44s550b303cece00313@mail.gmail.com>
References: <6d4a25b10911161520i50a677d6m78d057d900676469@mail.gmail.com>
	<s5hd43h4hlv.wl%tiwai@suse.de>
	<6d4a25b10911171217u26fa066l65cb70f90f5f6eee@mail.gmail.com>
	<s5heinwcq9g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C464F103824
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 23:34:31 +0100 (CET)
Received: by pzk9 with SMTP id 9so1082593pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 14:34:30 -0800 (PST)
In-Reply-To: <s5heinwcq9g.wl%tiwai@suse.de>
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

Hi,

On Tue, Nov 17, 2009 at 10:15 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 17 Nov 2009 12:17:59 -0800,
> Christian Hergert wrote:
>>
>> On Tue, Nov 17, 2009 at 1:37 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >
>> > At Mon, 16 Nov 2009 15:20:32 -0800,
>> > Christian Hergert wrote:
>> > >
>> > > Hi,
>> > >
>> > > I made a patch to fix bug 4657[1] on the tracker. =A0I'm fairly cert=
ain that
>> > > it isn't the correct approach but would like some feedback on what t=
hat
>> > > would be.
>> > >
>> > > The power-mappings in patch_sigmatel.c seem to allow you to flip mul=
tiple
>> > > bits. =A0In the case of the Dell docking station, you need to enable=
 some bits
>> > > while disabling others. =A0Therefore, instead of using the power map=
pings I
>> > > just hacked in a quick check to work for the hardware I have on hand=
. =A0If
>> > > there is a proper way to fix this that I have missed, I'll be more t=
han
>> > > happy to fix the patch appropriately.
>> > >
>> > > [1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4657
>> >
>> > The jack detection of the docking station is already there, but it see=
ms
>> > just a missing call to toggle the power-map.
>> >
>> > How about the patch below?
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> > ---
>> > diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigm=
atel.c
>> > index 7f76a97..bd9a2dd 100644
>> > --- a/sound/pci/hda/patch_sigmatel.c
>> > +++ b/sound/pci/hda/patch_sigmatel.c
>> > @@ -4396,10 +4396,12 @@ static void stac92xx_set_pinctl(struct hda_cod=
ec *codec, hda_nid_t nid,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pin_ctl &=3D ~(AC_PINCTL_IN_EN | AC_PIN=
CTL_OUT_EN);
>> >
>> > =A0 =A0 =A0 =A0pin_ctl |=3D flag;
>> > - =A0 =A0 =A0 if (old_ctl !=3D pin_ctl)
>> > + =A0 =A0 =A0 if (old_ctl !=3D pin_ctl) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write_cache(codec, nid, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0pin_ctl);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stac_toggle_power_map(codec, nid, 1);
>> > + =A0 =A0 =A0 }
>> > =A0}
>> >
>> > =A0static void stac92xx_reset_pinctl(struct hda_codec *codec, hda_nid_=
t nid,
>> > @@ -4407,10 +4409,12 @@ static void stac92xx_reset_pinctl(struct hda_c=
odec *codec, hda_nid_t nid,
>> > =A0{
>> > =A0 =A0 =A0 =A0unsigned int pin_ctl =3D snd_hda_codec_read(codec, nid,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, AC_VERB_GET_PIN_WIDG=
ET_CONTROL, 0x00);
>> > - =A0 =A0 =A0 if (pin_ctl & flag)
>> > + =A0 =A0 =A0 if (pin_ctl & flag) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write_cache(codec, nid, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0AC_VERB_SET_PIN_WIDGET_CONTROL,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0pin_ctl & ~flag);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stac_toggle_power_map(codec, nid, 0);
>> > + =A0 =A0 =A0 }
>> > =A0}
>> >
>> > =A0static int get_pin_presence(struct hda_codec *codec, hda_nid_t nid)
>>
>> I tried this on top of 2.6.31.4 and, unfortunately, it did not solve
>> the problem. =A0I'll investigate a bit to figure out why.
>
> Could you try 2.6.32-rc7 with the patch?
> (Or, you can just copy sound/pci/hda/* from 2.6.32 to 31, in this case.)
>
>
> thanks,
>
> Takashi
>

I tried with and without your patch on top of 2.6.32-rc7 and both
seemed to work.  So I guess the patch is not needed.  I apologize for
not trying tip before sending a patch.

-- Christian
