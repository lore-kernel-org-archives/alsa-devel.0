From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: no-pcm (backend) error propagation
Date: Sat, 2 Mar 2013 11:32:07 +0800
Message-ID: <20130302033205.GC6610@opensource.wolfsonmicro.com>
References: <190351B32828744FBA3BD9565204D27B01CA3AF2@NA-MBX-03.mgc.mentorg.com>
 <1361953433.28121.33.camel@vega>
 <190351B32828744FBA3BD9565204D27B01CA4E06@NA-MBX-03.mgc.mentorg.com>
 <1362173090.4439.44.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5134347528446804567=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5ADE26086D
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 04:32:35 +0100 (CET)
In-Reply-To: <1362173090.4439.44.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Frkuska,
 Joshua" <Joshua_Frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org


--===============5134347528446804567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2013 at 09:24:50PM +0000, Liam Girdwood wrote:
> On Thu, 2013-02-28 at 00:49 +0000, Frkuska, Joshua wrote:

Reflowed both sets of text into 80 columns...

> > With architectures that have an audio DSP, I think it makes sense to
> > do it as it is done with OMAP where underruns can be handled
> > internally by the DSP. The need came up for me because in my setup
> > there isn=E2=80=99t a dedicated audio DSP and the BE components are on =
the
> > same SoC as the FE, running/controlled by linux. (with the exception
> > of the codec)

> So if there is no audio DSP architecture then I assume you have some
> sort of DAI switch matrix/mixers in the HW and you don't do any ASRC ?=20

The modern Samsung SoCs are an example of this in mainline (currently a
bit bodged rather than using soc-pcm) - they've got a couple of DAIs
with a simple mixer that outputs on a single physical output, requiring
that both streams be at the same sample rate.  There's no meaningful
handling of underruns to do except for propagate them back up to the
application layer, each stream can error totally independently.

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMXKtAAoJELSic+t+oim90QoP/2sjAd21R8QZsFc2s3yi+hTZ
Iw3vWp+ePIF2MbG3+QE9IVo7atpd6S9Dss8HX/1k7VYrwhkvfBMzVzuLgLSDVqMQ
4qtxmsLLqfzT2aSei8FPgYvLygIJ7LAOvKoR5amwrM/6Rd2+2ARynI9dKTZ5BMck
yYIdVp0KcrMnAcK56L6i+NBHatr5zCmMy7QS2uAMM17fVuVeXGOyvq2VvwHqL6We
MFIQhxu4a2Zp7XUB4U8p8o6sO1pDrnocn84i/nmbBTaeQIDB9hKRMucdgTDEuY0F
QhzcSXXXMxkeEhkjfblIU02RY8JEo6DpdXBoN17oe3JLfM8WSDDz3qIJ+Lg/rBMI
H63GEAhmoZSH5iFZD7DqsKtJd+88rnGR5a7zYKzBQkREybgk+Jyyhvs0VqWJ6vQl
XLEhYfLHkYqeBj3OdDtvj7owoBQx2N8hPxSbbbDRq5FmgLtv1gmeRY/SW7eZu5LL
Sa0GkH7RFyUA7/wGd/7yoF0l7kn7jCY+EjAGVZmCkV5clULEOeXefCt4O6zUGNTE
NIgwG4F3/NxonxO1xVSXl0kre9li+YGyGMfdB16CTjychKJDB+ua49/zo/iHjKwS
fb/16c9VYhgeAuQomVzVQTGdu/k4OXu1W8Vd6lpzbyf2vF0I2TXdPQRXTTktLmSD
lYEvSd3oMX3An3jrCc3H
=9LbE
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

--===============5134347528446804567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5134347528446804567==--
