From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to
 kirkwood-i2s
Date: Fri, 30 Aug 2013 10:56:59 +0100
Message-ID: <20130830095659.GV10783@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
 <87wqnzhek5.wl%kuninori.morimoto.gx@renesas.com>
 <87li3jr6et.wl%kuninori.morimoto.gx@renesas.com>
 <5220571F.5020006@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3539578862975681733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 19EC92655DD
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 11:57:12 +0200 (CEST)
In-Reply-To: <5220571F.5020006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3539578862975681733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zWK6BCY0Qpt3/P3j"
Content-Disposition: inline


--zWK6BCY0Qpt3/P3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2013 at 10:26:07AM +0200, Lars-Peter Clausen wrote:
> On 08/30/2013 09:20 AM, Kuninori Morimoto wrote:

> > My understanding for this ASoC DT support milestone is that

> >  1) merge codec/component
> >  2) add .of_xlate_dai_name on it
> >  3) add DT support

> > But, do you think 1) is possible ?
> > Becouse, now, too many functions are based on/using "codec"
> > struct snd_soc_codec / struct snd_soc_codec_driver.
> > In reality, merging these is super difficult IMO.

> The idea is to use the component struct as a base class for the codec and
> platform struct. So drivers will keep seeing what they see now and don't
> need to be updated. Lots of the fields that can be shared between component,
> platform and codec are only used by the core.

Indeed, and doing things that can be done with a direct search and
replace is not so bad.  Splitting  things up makes life easier too.  I'd
been planning to start looking at the merge of CODEC and component
myself during the next release cycle.

--zWK6BCY0Qpt3/P3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIGxnAAoJELSic+t+oim9O78P/A1Yx3OmeZlBGNPD0O8K/jIn
HI7wfGY7sausT3qawENxOxs6gEP+ZiNHUlepV7KbP0bbXu6X4ZXRuxJxTLUFL9Bq
Nl6RFMwN4O+9TlGyzIaqihW3T/NtCPe4opOApdxC3+mgY4IB/FF0gW8Nz70emIR+
pd2GYg73kpW8bqGU4KiBbniiRsRfc1xihtn7C8PMqkg4lwjH3xlarP5apxQ6vnFk
/bfUoM7JaFz6SrxBNZmgB9r96OImkowFfDGK1uXrGbzA6uS4/9k+uNCFzUaLILPD
AQJPR6QKTGv/Oqi9q2Wjr3yK0sMr/qknL23IhjIDXIwGPIeh8Tq9x6dO3ZIOSDXo
9RYlJpHC68Yh/tzcZjijyhfec41ZYvLHNpF6OGIHGM6v85Ya/Wsm7sVdA4aVMWTT
Um7EP4rKhQrBouClTgsVi1UBsgWlNNtmtJnGXxqaUjLEiJVHhHDwhXkx8w7L/AOp
HlSaP7sblUrKVM3so38oIKOXr1Bt1tbeFC7k8hVvnN3Dfmg5yCSmNuvZcDwzzfvh
O0yOxzYsVif/IRmwdP93QzzMa4VieTn6kHz28N0QzMeoDy1C6DUDc2IEUwZfIdUo
F+0tumH/4VlAZ5RdAaUOgNUWnw3Dvm9ZxOJOp/AIxWleV1kw9gNbXbDI4iJdtDsP
sTYUxvBjPRiZNzi6nkjd
=VGR8
-----END PGP SIGNATURE-----

--zWK6BCY0Qpt3/P3j--

--===============3539578862975681733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3539578862975681733==--
