From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Fri, 23 Aug 2013 17:58:00 +0100
Message-ID: <20130823165800.GB30617@sirena.org.uk>
References: <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
 <20130823125803.GN6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6172382630486523941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8B42615AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 18:58:24 +0200 (CEST)
In-Reply-To: <20130823125803.GN6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6172382630486523941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 01:58:03PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 23, 2013 at 01:13:14PM +0100, Liam Girdwood wrote:

> > You asked me privately to Ack the series so you could carry it in your
> > own tree for upstreaming. Sorry if I misunderstood this request, but it
> > seemed straightforward.

> What I'm after are acks for those patches which are acceptable - which
> I believe is the entire series with the exception of the HACK patch.

If there no dependency then why is that patch included as part of this
series, especially so early on?  Obviously we shouldn't cause problems
for existing machines in mainline so I stopped applying patches which
seemed like they might depend on that one.  I had at the time been
expecting a revised version of the series to follow in due course with a
better fix as at the time the hack was sent you'd only just determined
what the problem was.

> The split of the DMA backend from the CPU DAI backend is something
> which early ASoC forced, but that has "mostly" been fixed with (as
> far as I'm currently aware through testing) the problem I've been

Essentially all the dmaengine based platforms in mainline use a shared
device for DMA and DAI; I'm fairly sure someone would have mentioned if
there were problems. =20

As you have been repeatedly told the Kirkwood drivers are the first
drivers submitted to mainline which use DPCM and therefore it is not
surprising that there are a few issues which need to be worked through,
there were a few revisions to the framework which went in as a result of
review during the mainline merge.  The problem you are seeing here is
due to this being the first platform with a *shared* device to use DPCM.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF5SVAAoJELSic+t+oim9Pz0P/AtYkbn0b1TkEv2wKYjwRGRF
F6Ed58jxsj6Ils4b9JGzyKtCpCSpj6aAdlhXsApiAYDz8t+Hc5YI3eEYYBW2JNFZ
8YYabnSJohb5I96hrVdazVrOiBSL9LZAWjulxGcIqbaBu017YkE71ZKWJ/zSH+SQ
BggZFflo+9VQysZkKA5LH/sirLc5KRjVO2r3t82lmkbvdHcUN6hjQwfyU5//CWQZ
DFBAFXwSd469S1p4G1TaMdcfsBUdHVAS4foAM0kcc8Xy1cMK/AvZn4RpmKz650eL
bbnsC4dl0EXFwmC1Dbtc0fObV3mnGBVjcN6OM0SzEyHIvTejftFs99ggBRUpeor/
ILjpOSrilOlSCdsx2vaQVoqA8buH1y3FpREgMr7OZyd8vG/k9ibuWhGrzqb3G5a7
JqX6TO0Kqj5Etkw0rv2a+XDfbh9NRKlOahJhjewbsDbiH7Qe1/WDAVrmEKE2uxJl
jOHHwqp4C7GxNmOqsVe9RMXUpXrvOEpzG48/oNDP4MX8WxWvaI2H/TH41e3aVyb7
H+q9LZ/lgs+rfSIM+jc5yMUREIX+f5VY6AziCjYe9HFKMVuI9cB2nTiDHdVTWTiM
hAkhseGrnEBZ2nMCb/TOk/B05kEv8td2jWmWW5AHerBjUrKC1fPkschz5YnplHIw
hSq4wYuf3C+HqgrD+DIO
=Wh19
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--===============6172382630486523941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6172382630486523941==--
