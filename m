From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
Date: Tue, 26 Jan 2010 20:49:26 +0900
Message-ID: <1b68c6791001260349s7eed010br51c7c033271bc4d0@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	 <1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	 <1b68c6791001252332l5ee275c9we39c98691ad7692c@mail.gmail.com>
	 <20100126105322.GG15759@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100126105322.GG15759@rakim.wolfsonmicro.main>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, lrg@slimlogic.co.uk, linux-samsung-soc@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 26, 2010 at 7:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 26, 2010 at 04:32:45PM +0900, jassi brar wrote:
>> On Tue, Jan 26, 2010 at 2:51 PM, =C2=A0<jassisinghbrar@gmail.com> wr=
ote:
>
> Please delete irrelevant context when replying to mails, it's much
> easier to find the actual new text in the message that way.
ok

>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* NOTE: If the codec ouputs just one slot,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* it *seems* our AC97 controller reads the only
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* valid slot(if either 3 or 4) for PCM-In.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* For such cases, we record Mono.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .channels_min =3D 1,
>
>> =C2=A0 I would like to remove this anomaly and set channels_min =3D =
2
>
> Why?
This hypothesis was based on wrong observation that AC97 can record ste=
reo-mic
if two slots are marked valid and one of them is 6th.
I decided to remove it after that observation turned out wrong(testing =
error).
Even though this seems logical, but I have not verified it so I wanted
to remove.

>> =C2=A0And remove the second DAI_LINK in machine driver.
>
> Again, why?
The wm9713 doesn't support mono capture and AC97 controller
doesn't support stereo MIC capture. So the second dai link
is improper.
