From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/15] ASoC: add helper to change platform
 name for all dailinks
Date: Mon, 28 Jan 2019 12:19:33 +0000
Message-ID: <20190128121933.GC11699@sirena.org.uk>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
 <20190125203509.22994-2-pierre-louis.bossart@linux.intel.com>
 <s5htvhv8g4y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8889485647766232612=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 591C8267477
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:19:35 +0100 (CET)
In-Reply-To: <s5htvhv8g4y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, vkoul@kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8889485647766232612==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 26, 2019 at 06:47:57PM +0100, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > +static inline
> > +int snd_soc_fixup_dai_links_platform_name(struct snd_soc_card *card,
> > +					  const char *platform_name)
> > +{

> Does it have to be inline?  The function has a significant size, and
> it's supposed to be called by every Intel driver.

Yeah, if it gets too big the compiler will just ignore you but given
that this isn't exactly in a hot path or anything I can't see any reason
why it should be inline.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO81UACgkQJNaLcl1U
h9Dc/gf/aWYo343Z68bAVuG/ES4dxfKOGSVXKqOCSaNUojjt86arariuZ4HVlmnN
dsHyljUqj1CHM+lvfogkffnSPujlnrJDrnMzkZ0ej8RdAgK3jXhHXb5BsbLhyDl/
+kvU25dCKh6aFcixM6MvWpojuI9r23R6cm95FqbynnlDjG2d+s3Vff20f1f165Wt
eaPcoUN+CmMyQxgXXf3zm9KtuJvLqhJG0WvaZ+tsE4p4pIpLBkootMTwWEC4MAKN
OwiUUyZcO90PRuYmIqeeMzESq1mbAPOTchVlAG2zAVCSL9E62E8Dcu3Qr9ahinfK
3tB2F9ZxL8IeiXWlDO9C6fYI/fvvpA==
=9e6I
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

--===============8889485647766232612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8889485647766232612==--
