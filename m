From: Thor Kristoffersen <thorkr@gmail.com>
Subject: Re: X-Fi Titanium: Capture is possible only with
	unmuted input
Date: Mon, 30 Aug 2010 11:18:01 +0200
Message-ID: <AANLkTi=HGMh266rHKKm7zO3i8ygxEkjQGWR1NHbP24DZ@mail.gmail.com>
References: <m2pqx1yx42.fsf@getmail.no> <s5h8w3o8rez.wl%tiwai@suse.de>
	<AANLkTikUP83MJkgH_eb+u1QSvoKCvs=L8F7nCaKYMMS-@mail.gmail.com>
	<s5htymc4he8.wl%tiwai@suse.de>
	<AANLkTinR0HRz2rnkvPJ2Mqd4kFn0=mzn4pd+HqhS+-wP@mail.gmail.com>
	<s5hr5hg4gex.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A47AC243E6
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 11:18:34 +0200 (CEST)
Received: by gxk28 with SMTP id 28so2098280gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 02:18:34 -0700 (PDT)
In-Reply-To: <s5hr5hg4gex.wl%tiwai@suse.de>
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

On Mon, Aug 30, 2010 at 11:07 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Mon, Aug 30, 2010 at 10:46 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> I'm having issues with an X-Fi Titanium and ALSA. =A0The problem i=
s that
>> >> >> it appears to be impossible to capture without unmuting the channe=
l I'm
>> >> >> capturing from.
>> >> >
>> >> > What do you mean exactly "unmuting the channel I'm capturing from"?
>> >> > If you mean to turn on/off "XXX Capture Switch", then it's a featur=
e,
>> >> > no bug.
>> >>
>> >> No, I mean that capture is possible only when mute=3Doff and capture=
=3Don.
>> >
>> > Which mute? =A0Please be more specific.
>>
>> The signal I'm trying to capture is coming in through the SPDIF-i
>> channel, so I'm talking about the mute and capture flags on that
>> channel. However, I also tried the analog input (line), and the
>> problem is exactly the same on that channel.
>
> Well, this is still unclear (what actually do you mean "channel") but
> let me guess:
>
> =A0the recording from either mic or line-in doesn't work unless you unmute
> =A0via "Front Playback Switch" mixer element.
>
> Correct?

Not really. I use gnome-alsamixer, and there is a mixer element called
"SPDIF-i" that has a slider, a "Mute" switch, and a "Capture" switch.
I connect a digital source to the SPDIF input on the card, and then I
try to record it with arecord from device hw:0,0. The only way I'm
able to record sound is by setting the Mute switch (of the SPDIF-i
mixer element) to off and the Capture switch to on.

Thor
