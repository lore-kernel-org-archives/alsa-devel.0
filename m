From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Mon, 31 Dec 2018 17:46:54 +0000
Message-ID: <20181231174654.GH1846@sirena.org.uk>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5095110652645496127=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8335326789E
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 18:46:58 +0100 (CET)
In-Reply-To: <20181230195612.6657-9-okaya@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sinan Kaya <okaya@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5095110652645496127==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 30, 2018 at 07:56:09PM +0000, Sinan Kaya wrote:
> Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> CONFIG_PCI set but this is not specified anywhere.

I don't have the cover letter or anything for this series, what's going
on with dependencies?

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqVgsACgkQJNaLcl1U
h9DK0Qf5AdiTvdsqlkSq4ADpfxzrhXV9yrPpE9JaSk42vEizr7qzwrid+GFrVbLv
7xnKpMDE8DAdWxtRf9UAqj+G3iuj5jU8fGbCeVbYrCxpgZdsJA7YWixJq3XlZ6Iw
3Hvtscbn2u6N656P4L2fYcIpgFVHvMU3MdVVqs9LO3YknHVV+8j9/i8XKc5/KYx4
y2yCc5BHiniwsLMeupbyii3HHrAHw4FMGlgeqLqVT9558m3Vj3hwoWhvI/emG8uV
XhFI4OoiPPDtQlF5SU+fUKOnSjUF3vLNubC6peKLu8euzsC0kn5nNa9wtbDzoQ1c
N4Tkr2/CS/k/IOD8QLNbkHGjXzuj0w==
=9M9Q
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--

--===============5095110652645496127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5095110652645496127==--
