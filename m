From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Mon, 28 Jan 2019 12:10:53 +0000
Message-ID: <20190128121053.GB11699@sirena.org.uk>
References: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
 <c20a4737-ab29-11e7-7780-4782463eb2cf@axentia.se>
 <bed2d410-1b67-c2e1-dd9b-3877917fef43@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8020369657523217846=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DCB47267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:10:56 +0100 (CET)
In-Reply-To: <bed2d410-1b67-c2e1-dd9b-3877917fef43@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--===============8020369657523217846==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 26, 2019 at 09:00:09PM +0200, Dimitris Papavasiliou wrote:
> On 1/26/19 8:48 PM, Peter Rosin wrote:

> > ratio == 0 should also generate -EINVAL.

> Sorry, I forgot to mention in the notes, that I allowed setting a
> zero ratio on purpose, in order to allow "unsetting" the bclk
> ratio (since it only takes effect if it is positive).  I'm not
> sure if it will ever be necessary to do that in practice, but I
> thought I'd allow it, since it has a valid effect.

This is fairly idiomatic for ASoC FWIW.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO8UwACgkQJNaLcl1U
h9DW6gf9GZI06XopQsHnbi2lFlAMse7mjjw1Ic9JYAS1oVriykx71rynUl3T1Iz1
ji9DFPL7RNHNMHFmBojG8BqPOKVKkaVsA2PJjlv23zIXtEm9o9urY5aHv+QLxB32
jRWrb6DXON+xe/boRiYITzd0u5XyzKDPQS19Fhf0+DNF0WrCcRglK9ikTFD3fQNi
Z6YKChDSbPhODBK+UPIFQjgNUmJD9GQcx2rsAgnPRiDxeSKqKPJzrirFospT6Zyx
yoS4hDacOVP9jLdiMoSyz73wfm+3ciSo37PI7E6HW0KNfbNNjR1RliThO1a4uYGd
oLNBVEghxE1FgmiIBrdLoTrKhTc28w==
=KLR8
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

--===============8020369657523217846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8020369657523217846==--
