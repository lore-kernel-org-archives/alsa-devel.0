From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/7] ASoC: Intel: mrfld - Add DSP load
 and management
Date: Fri, 17 Oct 2014 14:01:47 +0200
Message-ID: <20141017120147.GF1820@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-3-git-send-email-vinod.koul@intel.com>
 <20141017094413.GF3771@sirena.org.uk>
 <20141017091816.GP1638@intel.com> <s5h1tq7ui47.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4046573506580295417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA50426516B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:02:07 +0200 (CEST)
In-Reply-To: <s5h1tq7ui47.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4046573506580295417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 12:04:56PM +0200, Takashi Iwai wrote:
> Vinod Koul wrote:

> > I will work on moving memcpy32_toio to core and move users as well :)

> We can move them into sound/core/memory.c.  They are pretty small and
> useful.

It's not really anything to do with sound though, the other users are
MTD devices at the minute.

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQQUqAAoJECTWi3JdVIfQgxYH/RI/UQ9L4nBKZstX43MM79dW
CGIqLcja1yq2pacD8a82fvO3V6RlZSpkWbjHz/IARi2S04IOZpNGdvb6NtFCTKkz
A/Pg7G42/QjlmYyT3gFfqqnMT5Osf8DYwR3hfDjMqOh2d89gMRL1dG6POavr256M
7i9HRVk9z0sdD+zAFDxlz7qAh0WmZyDC5BMez4kGJdGnY/h1EHeK1o0QOsNiUmNu
FAQmas9G5vwBwC7r+BFI3//EkHSEuPz7VdNPDqHRxhXz2Eo01JswD1f5HOQzuNjd
GkLFTtNiScw+Qz5TysutNAdXDx62BStpFPf5h5wtCCi0pLf63KbEpIatOd8CEQg=
=Lyu8
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--

--===============4046573506580295417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4046573506580295417==--
