From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM:
 shmobile: lager: add sound support on DT)
Date: Wed, 11 Jun 2014 19:08:34 +0200
Message-ID: <CAMuHMdUYFdbOxyqZnPAUxfY1vkqDr-7RUJmqgivuMQugyMme7g@mail.gmail.com>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
	<87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
	<539815E6.2050304@codethink.co.uk>
	<20140611165410.GK5099@sirena.org.uk>
	<CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
	<20140611170233.GL5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140611170233.GL5099@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 11, 2014 at 7:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 11, 2014 at 06:57:44PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jun 11, 2014 at 6:54 PM, Mark Brown <broonie@kernel.org> wro=
te:
>> > They're usually referred to as AKM when abbreviated and their web =
site
>> > is http://www.akm.com/ - don't know what the stock ticker symbol i=
s.  In
>> > any case there's no real cost to adding both abbreviated and
>> > non-abbreviated forms if we want to transition.
>
>>     of: Add vendor prefix for Asahi Kasei Corp.
>
>>     Their stock ticker is 3407.T which wouldn't make a good DT vendo=
r
>>     prefix. Use the company name initials instead.
>
> Sounds like akm, is a better bet then, especially as ak, has no real
> adoption.

Except for =D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82 =D0=9A=D0=B0=D0=BB=
=D0=B0=D1=88=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2=D0=B0...

> I think the bikeshed would be much better painted pink with yellow sp=
ots :)

Definitely.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
