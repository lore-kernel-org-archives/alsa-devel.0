From: Thor Kristoffersen <thorkr@gmail.com>
Subject: Re: X-Fi Titanium: Capture is possible only with
	unmuted input
Date: Mon, 30 Aug 2010 12:02:49 +0200
Message-ID: <AANLkTi=u9nm4rC5N8eZa1v3Yn4z-_7-h5hp3Jm1n4HwT@mail.gmail.com>
References: <m2pqx1yx42.fsf@getmail.no> <s5h8w3o8rez.wl%tiwai@suse.de>
	<AANLkTikUP83MJkgH_eb+u1QSvoKCvs=L8F7nCaKYMMS-@mail.gmail.com>
	<s5htymc4he8.wl%tiwai@suse.de>
	<AANLkTinR0HRz2rnkvPJ2Mqd4kFn0=mzn4pd+HqhS+-wP@mail.gmail.com>
	<s5hr5hg4gex.wl%tiwai@suse.de>
	<AANLkTi=HGMh266rHKKm7zO3i8ygxEkjQGWR1NHbP24DZ@mail.gmail.com>
	<s5hocck4f9x.wl%tiwai@suse.de>
	<AANLkTintks=SY392CekwCKkS=aFk3qWvzhmbbg64zBjY@mail.gmail.com>
	<s5hiq2s4ene.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 865281037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 12:02:53 +0200 (CEST)
Received: by ywg8 with SMTP id 8so2138101ywg.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 03:02:51 -0700 (PDT)
In-Reply-To: <s5hiq2s4ene.wl%tiwai@suse.de>
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

On Mon, Aug 30, 2010 at 11:45 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 30 Aug 2010 11:43:14 +0200,
> Thor Kristoffersen wrote:
>>
>> On Mon, Aug 30, 2010 at 11:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> On Mon, Aug 30, 2010 at 11:07 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> On Mon, Aug 30, 2010 at 10:46 AM, Takashi Iwai <tiwai@suse.de> wro=
te:
>> >> >> >> >> I'm having issues with an X-Fi Titanium and ALSA. =A0The pro=
blem is that
>> >> >> >> >> it appears to be impossible to capture without unmuting the =
channel I'm
>> >> >> >> >> capturing from.
>> >> >> >> >
>> >> >> >> > What do you mean exactly "unmuting the channel I'm capturing =
from"?
>> >> >> >> > If you mean to turn on/off "XXX Capture Switch", then it's a =
feature,
>> >> >> >> > no bug.
>> >> >> >>
>> >> >> >> No, I mean that capture is possible only when mute=3Doff and ca=
pture=3Don.
>> >> >> >
>> >> >> > Which mute? =A0Please be more specific.
>> >> >>
>> >> >> The signal I'm trying to capture is coming in through the SPDIF-i
>> >> >> channel, so I'm talking about the mute and capture flags on that
>> >> >> channel. However, I also tried the analog input (line), and the
>> >> >> problem is exactly the same on that channel.
>> >> >
>> >> > Well, this is still unclear (what actually do you mean "channel") b=
ut
>> >> > let me guess:
>> >> >
>> >> > =A0the recording from either mic or line-in doesn't work unless you=
 unmute
>> >> > =A0via "Front Playback Switch" mixer element.
>> >> >
>> >> > Correct?
>> >>
>> >> Not really. I use gnome-alsamixer, and there is a mixer element called
>> >> "SPDIF-i" that has a slider, a "Mute" switch, and a "Capture" switch.
>> >> I connect a digital source to the SPDIF input on the card, and then I
>> >> try to record it with arecord from device hw:0,0. The only way I'm
>> >> able to record sound is by setting the Mute switch (of the SPDIF-i
>> >> mixer element) to off and the Capture switch to on.
>> >
>> > There is no mixer switch names "SPDIF-i". =A0It's cut in alsamixer's
>> > display. =A0To check more exactly, make a diff of amixer outputs betwe=
en
>> > working and non-working states.
>> >
>> > But, what you wrote above is about the SPDIF input, not about the
>> > analog input, right? =A0Let's focus on one of them first.
>>
>> The problem is exactly the same with the analog input,
>
> Hmm... what do you mean "exactly the same"?
> Does "SPDIF-in" mixer have to be unmuted? =A0Or any other mixer element?

No, what I mean is that in order to capture sound from the analog
input, it is necessary to set the Mute switch to off and the Capture
switch to on on the Line mixer control.

Thor
