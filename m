From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: make minimum period
 size larger than FIFO
Date: Mon, 12 Mar 2012 12:15:37 +0000
Message-ID: <20120312121537.GG3110@opensource.wolfsonmicro.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-4-git-send-email-notasas@gmail.com>
	<4F59FA9D.8070009@ti.com>
	<CANOLnOM+9M2BTXasnAUqFyYAg03LE0TD266ArYDyxfRsY26QsQ@mail.gmail.com>
	<4F5A08B3.8080705@ti.com>
	<CANOLnOPZ+bMy8FyAJ0s6QSz1NMEZjgjX_ZXDkT+dFU3q8vefgg@mail.gmail.com>
	<1331487544.3326.27.camel@puukko.homenet-68>
	<CANOLnONZTBTOYLjj=Fs5rA1MX0vq2tGrr67UVmHPugykfBoUZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0480018647570061607=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3855103F60
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 13:15:38 +0100 (CET)
In-Reply-To: <CANOLnONZTBTOYLjj=Fs5rA1MX0vq2tGrr67UVmHPugykfBoUZw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============0480018647570061607==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 02:05:55PM +0200, Grazvydas Ignotas wrote:
> On Sun, Mar 11, 2012 at 7:39 PM, Jarkko Nikula <jarkko.nikula@bitmer.com> wrote:

> > I think instead of limiting minimum period size to FIFO size we should
> > find that boundary condition. Like if min buffer > FIFO + 1 period or
> > something like that in order to keep possible to use small periods.

> I was testing some hacks that force runtime->start_threshold to a bit
> above FIFO size with good results, however none of ASoC code ever
> touches it, so I guess it could be considered wrong thing to do, but
> it works with everything I tested so far, including OSS emulation.

That's more due to nothing ever particularly needing it before than due
to it being a bad idea.

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXejFAAoJEBus8iNuMP3dtOcP/RLiOPlP8GPT/WF5ASdVxKG7
ZCmpZbFTQUOMEfgbu4TLD8e7ARiF0BYKFlhsUgugDFIJN/dL7ZbNuuqAJxP6k3m0
tYddxGGYaWapkRdEASsX/AAgEvPPqSxxxkzfjHmg1aUlTtLXIpHpVOtJPOqy1mwU
MN762UFhHgGSgavG9zJo/xyvtB+nf4kcqQ8KLlU/0Nati9K8YPj/Wpnr64+6WGql
9/1hyQXrR8aolnacJ9wNNC51GMkVqbkCgRcCIlLPtr0ydxiRDozlPYUSOP7DvWMB
z82mpJ5GmGNjzw8lXez1TKhm7fFmnvFa6xKgybv3XfN31ixLrTHFw/UOZRfq8NzK
v7g75UmmcWLxN0P0xYTo+neYqHuZHFf/fvLYlrtiorDpGcC36BkB1LfiCMmfHJOT
ZTBWfJyY/eWFV6CzUJhyleZOcFoIfpC7ggdIe/0rx1L8RPkfTneaAGM6mz3Uo9hc
swBm4JgyhdsLyqR++j6Ihbitqr6oUj3mFg5rkheNzvs8NzJfIfwgbjffKI3v9L0w
5SWH2u06MmvrRMD84p25zMDjO28O6xgdrYoEtdbMJBUUKZplJ4GnbuHsm/hzITG0
ApKjJwCG68W++5g4+m5TMzyNg95U2ZI4B5c2ecZswWt/XbuVZUZ/Rfyx+mlH0FOo
OQ/KxRtq15T+26AYqRi+
=Fh9Q
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--

--===============0480018647570061607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0480018647570061607==--
