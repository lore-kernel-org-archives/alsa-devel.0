From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/12] ASoC: AMD: add suspend/resume for
	ACP PCM driver
Date: Thu, 6 Aug 2015 20:23:04 +0100
Message-ID: <20150806192304.GI20873@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-11-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4171959359814457001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF1826061B
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 21:23:09 +0200 (CEST)
In-Reply-To: <1438871112-25946-11-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4171959359814457001==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3nAG2g9QcVnArZzN"
Content-Disposition: inline


--3nAG2g9QcVnArZzN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 10:25:11AM -0400, Alex Deucher wrote:

> +static int acp_pcm_suspend(struct device *dev)
> +{
> +	return 0;
> +}

You should never need to add empty functions like this.

--3nAG2g9QcVnArZzN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw7QXAAoJECTWi3JdVIfQ+EMH/2TutGmTP9PvrRvPPMzosqVX
jR9o0jU8aSDSDH79mHZ+4v2AA26KMfFkCqvYVvFEoKhEJNsqAo9M75/fKtkthIOB
6yXTO5rM1rfjGcC2sPoBeKCXtri60bQWZ6F3jNji39xBW7zNS7ggxuAVWaZma0ug
rrfqhaoemuHeyfKcZM9VWDybBYiVZ2mu6vA781VpmAKrn8GdyKZ4kJWyK6kUp8bB
Smz4kRNma2ZQBTopdjTzDjnkfXFuEckcBMY8j/i586ZzD5/APJ25eGbmRAW4FN8g
7cAAsoY0YGcEWXCSCMLcDmSZsQkGoTSmepKFFt9Hh6LtEFoNZb0qiCYkuYnZ0kM=
=WoY9
-----END PGP SIGNATURE-----

--3nAG2g9QcVnArZzN--

--===============4171959359814457001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4171959359814457001==--
