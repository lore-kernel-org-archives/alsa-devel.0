From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/21] ASoC: SOF: Intel: hda: fix link DMA
 config
Date: Tue, 23 Jul 2019 17:30:10 +0100
Message-ID: <20190723163010.GK5365@sirena.org.uk>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
 <20190722141402.7194-19-pierre-louis.bossart@linux.intel.com>
 <20190723111515.GD5365@sirena.org.uk>
 <cabe9c2b-359d-deb6-93ee-e42b1400ea27@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8681604099960430464=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8530CF80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 18:32:23 +0200 (CEST)
In-Reply-To: <cabe9c2b-359d-deb6-93ee-e42b1400ea27@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8681604099960430464==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 09:37:47AM -0500, Pierre-Louis Bossart wrote:
> On 7/23/19 6:15 AM, Mark Brown wrote:

> > In general fixes should come at the start of a series so that they can
> > be applied as such and sent to Linus without getting caught up with
> > dependencies on development work.

> Yes, but in this case we had two developers that changed the code and I
> couldn't really move code around too much.

Might be worth pushing back on them to pick a better base for their
fixes (and possibly work out a way to get that stuff sent out separately
rather than stuck with a big queue of other stuff).

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03NhEACgkQJNaLcl1U
h9Asngf/Ro6eQOO7WK5Qh0xxpUKRiLrWJJYcjJ7mvV2DJLBkcV07pe+3ukNaMUGU
tAzxGtGNcYUc/r21We8pkqKQPtaSHiqAJFoHh+EeY+lFXhV4TLkoSmbSUfziae+3
DI5RecWh6VnrWzZW2q6TD4okwk1bFcZWq4IKeA03xUSRwnGhZtaPENAD3wXS0EPs
/Cv4Iox50np7TIzPrc2ZGg6Z5i8+LmPJp6WPF/IiIIvWeR66HQI0BGSZzK99ZWpJ
3KU3ImFkc0/+e6DS971yu1SnUARf1E4cLJ0NgSldcpnJcadljyPu0Hi6HxgxCdiZ
7Dq3l5/k/3AgTZZ87narqo1LsQBBTw==
=cF/3
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--

--===============8681604099960430464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8681604099960430464==--
