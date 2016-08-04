From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about struct snd_soc_dai() :: cpu_dai->codec
Date: Thu, 4 Aug 2016 21:12:09 +0900
Message-ID: <a9071ad9-ea67-1bce-27cf-3f2ac21b6456@sakamocchi.jp>
References: <s5hpopy6dbi.wl-tiwai@suse.de> <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de> <579AA39B.5030100@sakamocchi.jp>
 <884bd15f-da5e-49f5-73ee-d8173dc0720a@metafoo.de>
 <20160729160702.GK9681@localhost> <s5hy44k41oa.wl-tiwai@suse.de>
 <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
 <20160729220854.GN10376@sirena.org.uk>
 <5152607b-90ab-1675-6be8-986be880a8eb@sakamocchi.jp>
 <20160804102826.GU10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jV9qtKrM7EWng9Ln8BVb9Qk1wEr5FRKBk"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160804102826.GU10376@sirena.org.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jV9qtKrM7EWng9Ln8BVb9Qk1wEr5FRKBk
Content-Type: multipart/mixed; boundary="BuxvAwn0hb28WuWiVQG2pDXs0hxePHb7t"
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-renesas-soc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
 Simon <horms@verge.net.au>
Message-ID: <a9071ad9-ea67-1bce-27cf-3f2ac21b6456@sakamocchi.jp>
Subject: Re: Question about struct snd_soc_dai() :: cpu_dai->codec
References: <s5hpopy6dbi.wl-tiwai@suse.de> <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de> <579AA39B.5030100@sakamocchi.jp>
 <884bd15f-da5e-49f5-73ee-d8173dc0720a@metafoo.de>
 <20160729160702.GK9681@localhost> <s5hy44k41oa.wl-tiwai@suse.de>
 <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
 <20160729220854.GN10376@sirena.org.uk>
 <5152607b-90ab-1675-6be8-986be880a8eb@sakamocchi.jp>
 <20160804102826.GU10376@sirena.org.uk>
In-Reply-To: <20160804102826.GU10376@sirena.org.uk>

--BuxvAwn0hb28WuWiVQG2pDXs0hxePHb7t
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Aug 4 2016 19:28, Mark Brown wrote:
> On Thu, Aug 04, 2016 at 12:17:57PM +0900, Takashi Sakamoto wrote:
>> On Jul 30 2016 07:08, Mark Brown wrote:
>=20
>>> The card should be deinstantiated and reinstantiated whenever a
>>> component driver unbinds and rebinds (respectively).  You'd need to
>>> completely deregister the card to change the list of things it's
>>> expecting currently.
>=20
>> In a point of application interfaces, I guess that current implementat=
ion of
>> ALSA soc part includes a bug that it's possible to unload codec or com=
ponent
>> modules when any ALSA character devices are opened. The framework has =
no
>> codes to manage reference counting of character devices or loaded code=
cs,
>> components.
>=20
> Yes, exactly - we don't cope very well with that situation and we reall=
y
> ought to but since it's hard to trigger without trying in practice it's=

> never been a priority.

Ugly... completely ugly idea for user space applications and operating
system... It's better for developers for ALSA soc part to pay enough
attention not only to their hardwares but also to application interfaces.=


Please assume that a loaded module for SoC's sound interface which
supports Jack detection, and pulseaudio runs on the system. Then,
typically, the process listen to ALSA ctrl character device for Jack
detection.

In this case, when modules for codec or component are unloaded, what
happends? In worst case, pulseaudio process can kill the system in a
system call path or something else, because the modules for SoC's sound
interface is still loaded and userspace applications can execute system
calls via ALSA character devices.

It should be forbidden to build ALSA soc part as loadable kernel
modules. It's really danger...


Regards

Takashi Sakamoto


--BuxvAwn0hb28WuWiVQG2pDXs0hxePHb7t--

--jV9qtKrM7EWng9Ln8BVb9Qk1wEr5FRKBk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXozEfAAoJELWlhsfWb9NB2xcP/ijOMg1m9aHt2Lv1B8qEtTSt
a9ig0zIpiW3nQBarCbSIw/msD8NUxJaKqSbp1bdYnzIlYISxse9hJ5ljWI5MZLUo
Ikv3+LAa+O8rhWBOq9sEiwp5Y7l8oUbfYrrBZOjUxTvCeFqdPP1ys9a6OBwV7AsS
rCx/7066TtwomW68cDi6MHxxxlfoBFL/5x5BBJGEO896DT31HmV5LqOeuFA0nD1o
LeVhGMVdm2CFHdmTqwkV70mlXMEUEBPgpKPQxCGZ0n/U9Qe4OdG4RZijQUN9qUio
dza+ST5VGdVakdra7y9aLM6jSYvab4V3PgXkQk94zJJsRLrGqeGgZyg+eJVdEYuO
91gkEpm96y3FO8ENTMO0fY1HpNFr/4cKzZLcMnkLHN1zvOkiux0DQ/w+zeEPEfHB
Y0jqPXNP42cG3oVWkK6zMadOEBJ92+aFb14eWNCDUlaxpSA4oNsqSgSemXrKEdNI
n9MMHCgq+PyDSFhvsvwWMwEcyPfkT6Y+GyhAd5gcZrh12DtCLvIOxReZqCM98nJR
AAKRPl2F0vsD6SFa8c9v/LyEwItTh2Whvxj4btdvsHpm2kOpt4pazSMXQ8s5LjAX
6RJFlIXx+I8k4qgYF1f7tHvQaQpsAYYkCFBsfr9TQMknGoMPcwkARosF7uiM5/Yj
6W6B4LGt0mtY8qkC8yBi
=qWEP
-----END PGP SIGNATURE-----

--jV9qtKrM7EWng9Ln8BVb9Qk1wEr5FRKBk--
