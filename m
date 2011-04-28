From: Emmanuel Benisty <benisty.e@gmail.com>
Subject: Re: 2.6.38.4 broke my audio
Date: Thu, 28 Apr 2011 12:50:12 +0700
Message-ID: <BANLkTim22Cb3e-ST2Mphn2CRksXWa6GwDw@mail.gmail.com>
References: <20110424113037.11af0b04@omega.digital-domain.net>
	<20110425000126.GA18681@suse.de>
	<s5htydmhed2.wl%tiwai@suse.de>
	<20110425173409.GA32047@suse.de>
	<s5hpqoagjtf.wl%tiwai@suse.de>
	<BANLkTim0UGi2Y9wE4NEMgyKQLx73garNxA@mail.gmail.com>
	<s5hvcy1b2kj.wl%tiwai@suse.de>
	<BANLkTinVWhbis7HxfQLc-89eQgg=qsFhhg@mail.gmail.com>
	<s5h39l4gkf1.wl%tiwai@suse.de>
	<BANLkTinmXbkk579oaiTqRdexvOZFpS_gvg@mail.gmail.com>
	<s5haafbae7k.wl%tiwai@suse.de>
	<BANLkTimbyDBgdCuo=feser9eRnPhS34FQA@mail.gmail.com>
	<s5hy62vfpx4.wl%tiwai@suse.de>
	<BANLkTimMQgquUD+wi6WuxzVAK8eA7kQEQQ@mail.gmail.com>
	<s5hvcxzey1z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvcxzey1z.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Andrew Clayton <andrew@digital-domain.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 12:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 28 Apr 2011 08:07:23 +0700,
> Emmanuel Benisty wrote:
>>
>> [1 =C2=A0<text/plain; UTF-8 (quoted-printable)>]
>> On Thu, Apr 28, 2011 at 2:35 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Wed, 27 Apr 2011 23:17:20 +0700,
>> > Emmanuel Benisty wrote:
>> >>
>> >> [1 =C2=A0<text/plain; UTF-8 (quoted-printable)>]
>> >> On Wed, Apr 27, 2011 at 10:47 PM, Takashi Iwai <tiwai@suse.de> wr=
ote:
>> >> > At Wed, 27 Apr 2011 21:57:32 +0700,
>> >> > Emmanuel Benisty wrote:
>> >> >>
>> >> >> On Wed, Apr 27, 2011 at 3:36 PM, Takashi Iwai <tiwai@suse.de> =
wrote:
>> >> >> > At Wed, 27 Apr 2011 08:15:28 +0700,
>> >> >> > Emmanuel Benisty wrote:
>> >> >> >>
>> >> >> >> [1 =C2=A0<text/plain; UTF-8 (quoted-printable)>]
>> >> >> >> On Tue, Apr 26, 2011 at 7:49 PM, Takashi Iwai <tiwai@suse.d=
e> wrote:
>> >> >> >> > At Tue, 26 Apr 2011 08:42:59 +0700,
>> >> >> >> > Emmanuel Benisty wrote:
>> >> >> >> >>
>> >> >> >> >> On Tue, Apr 26, 2011 at 3:25 AM, Takashi Iwai <tiwai@sus=
e.de> wrote:
>> >> >> >> >> > At Mon, 25 Apr 2011 10:34:09 -0700,
>> >> >> >> >> > Greg KH wrote:
>> >> >> >> >> >>
>> >> >> >> >> >> On Mon, Apr 25, 2011 at 11:25:29AM +0200, Takashi Iwa=
i wrote:
>> >> >> >> >> >> > At Sun, 24 Apr 2011 17:01:26 -0700,
>> >> >> >> >> >> > Greg KH wrote:
>> >> >> >> >> >> > >
>> >> >> >> >> >> > > On Sun, Apr 24, 2011 at 11:30:37AM +0100, Andrew =
Clayton wrote:
>> >> >> >> >> >> > > > Hi guys.
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > Just upgraded to .4 from .3 and found my audio =
was _really_ quiet. All
>> >> >> >> >> >> > > > the mixers looked sane.
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > A quick check of the changelog and a revert of:
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > commit 58541cc27531727f7120683a7cb123ee3ada4bd4
>> >> >> >> >> >> > > > Author: Takashi Iwai <tiwai@suse.de>
>> >> >> >> >> >> > > > Date: =C2=A0 Mon Mar 28 12:05:31 2011 +0200
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 ALSA: hda - Fix pin-config of Gig=
abyte mobo
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 commit c6b358748e19ce7e230b0926ac=
42696bc485a562 upstream.
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 Use pin-fix instead of the static=
 quirk for Gigabyte mobos 1458:a002.
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 Bugzilla: https://bugzilla.novell=
=2Ecom/show_bug.cgi?id=3D677256
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 Signed-off-by: Takashi Iwai <tiwa=
i@suse.de>
>> >> >> >> >> >> > > > =C2=A0 =C2=A0 Signed-off-by: Greg Kroah-Hartman=
 <gregkh@suse.de>
>> >> >> >> >> >> > > >
>> >> >> >> >> >> > > > made it normal again.
>> >> >> >> >> >> > >
>> >> >> >> >> >> > > Takashi, do you have a fix for this, or should I =
revert this from the
>> >> >> >> >> >> > > .38 stable tree? =C2=A0It looks like we now have =
2 reports of this problem.
>> >> >> >> >> >> >
>> >> >> >> >> >> > If we need to revert, I'll do it in the upstream fi=
rst, as it must hit
>> >> >> >> >> >> > to 2.6.39, too.
>> >> >> >> >> >>
>> >> >> >> >> >> True.
>> >> >> >> >> >>
>> >> >> >> >> >> > But let me check this breakage first. =C2=A0I'll ta=
ke a look at it more
>> >> >> >> >> >> > deeply tomorrow.
>> >> >> >> >> >>
>> >> >> >> >> >> Ok, that sounds good.
>> >> >> >> >> >
>> >> >> >> >> > Thanks.
>> >> >> >> >> >
>> >> >> >> >> > Andrew, could you give alsa-info.sh outputs on your ma=
chine?
>> >> >> >> >> > Preferably, the outputs both before and after the kern=
el update would
>> >> >> >> >> > be really helpful.
>> >> >> >> >>
>> >> >> >> >> In case it might help, mine are attached too.
>> >> >> >> >
>> >> >> >> > Thanks. =C2=A0But the output after update (alsa-info.txt.=
bad) looks weird.
>> >> >> >> > It contains unexpected pin-update for NID 0x15 (found in
>> >> >> >> > /sys/class/sound/hwC0D0/driver_pin_configs), and thus the=
 mixer
>> >> >> >> > elements created don't match with the results on HD-audio=
 emulator.
>> >> >> >> >
>> >> >> >> > Could you double-check whether you have no modification o=
ver 2.6.38.4
>> >> >> >> > driver?
>> >> >> >>
>> >> >> >> Hi Takashi,
>> >> >> >>
>> >> >> >> To double check, I have rebuilt .3 and .4 straight from ker=
nel.org
>> >> >> >> sources with the same config (which I attached, just in cas=
e).
>> >> >> >> alsa-info.sh outputs are attached.
>> >> >> >
>> >> >> > Thanks. =C2=A0The bad output still shows the strange pin-con=
fig for NID
>> >> >> > 0x15 while it's not found in the good output.
>> >> >> >
>> >> >> > Could you check the following?
>> >> >> >
>> >> >> > 1. Set model=3Dauto option to snd-hda-intel module and boot =
2.6.38.3.
>> >> >> > =C2=A0 Get alsa-info.sh output.
>> >> >> >
>> >> >> > 2. Apply fix1.diff patch below to 2.6.38.4, and boot, get al=
sa-info.sh
>> >> >> > =C2=A0 again.
>> >> >> >
>> >> >> > 3. Reviert fix1.diff, and apply fix2.diff to 2.6.38.4. =C2=A0=
The same
>> >> >> > =C2=A0 procedure.
>> >> >> >
>> >> >> > The point to be checked is the widget 0x15. =C2=A0In a good =
case, it should
>> >> >> > have the pin config such as:
>> >> >> > =C2=A0Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>> >> >> >
>> >> >> > In a bad case, the driver modifies this by some reason to
>> >> >> > =C2=A0Pin Default 0x99130112: [Fixed] Speaker at Int ATAPI
>> >> >>
>> >> >> Hi Takashi,
>> >> >>
>> >> >> alsa-info.sh outputs are attached. fix1 works, fix2 is still b=
roken.
>> >> >
>> >> > Thanks. =C2=A0Hm, so it happens only with the patch. =C2=A0Puzz=
ling.
>> >> >
>> >> > Could you check the messages triggered by the patch below?
>> >> > Does it include 0x15?
>> >>
>> >> attached is what it gives.
>> >
>> > OK, so it's chained wrongly by some reason. =C2=A0Maybe using bool=
 type
>> > causes a problem for some compiler?
>> >
>> > Could you try the patch below instead? =C2=A0If it works as expect=
ed,
>> > you'll see _no_ Surround volume control.
>>
>> Sorry Takashi, still no luck with this patch.
>
> Please double-check whether the patch was really applied.
> Now there is no debug message seen. =C2=A0It should still put some
> 'XXX hda_codec: ' lines. =C2=A0This looks odd.

my bad, I have reverted this patch (the debug one, habit of keeping
the sources unpatched) but the latest one has been applied, sorry.

>> > And, what is your configuration, i.e. which output are you testing=
?
>> > The output from the speaker and/of from the headphone jack?
>>
>> Ouput from speakers only until now.
>
> You don't plug into the headphone or line-out jack, right?
> Otherwise the speaker output is muted automatically by the jack.

in fact, it's a desktop machine, not a laptop, so speakers are plugged
into the line-out jack.

Thanks.
