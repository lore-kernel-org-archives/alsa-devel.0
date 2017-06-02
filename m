From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/27] ALSA: pcm: Introduce copy_user,
 copy_kernel and fill_silence ops
Date: Fri, 2 Jun 2017 18:14:28 +0100
Message-ID: <20170602171428.6ludtml23vfpcygp@sirena.org.uk>
References: <20170601205850.24993-1-tiwai@suse.de>
 <20170601205850.24993-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7464691629443531749=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00B8E266AF1
 for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2017 19:14:38 +0200 (CEST)
In-Reply-To: <20170601205850.24993-3-tiwai@suse.de>
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
Cc: Felipe Balbi <balbi@kernel.org>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7464691629443531749==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tkkk7d7hsv6owojv"
Content-Disposition: inline


--tkkk7d7hsv6owojv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2017 at 10:58:25PM +0200, Takashi Iwai wrote:
> For supporting the explicit in-kernel copy of PCM buffer data, and
> also for further code refactoring, three new PCM ops, copy_user,
> copy_kernel and fill_silence, are introduced.  The old copy and
> silence ops will be deprecated and removed later once when all callers
> are converted.

Acked-by: Mark Brown <broonie@kernel.org>

--tkkk7d7hsv6owojv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkxnPQACgkQJNaLcl1U
h9C1Ygf+Lf9E11DcpSKgUfS/g8SE5RYlcK5oYhJP/IWFBYAhWt2dgmanzHabGW4a
mWH8IEDT+th1fC4xAempj+Ws58GQWTaEkbThITbV72fcwSL2+6hZKmbUkEm+YTIX
axirqG88s6wlfvgKw79ImhtoFEs5mv0/gmBjq/fxaLBv1VO0xB1/yNSt4ZDng1RQ
IG0faFsM4oJrPCbZQmCsXn35tau0mSc9ujx5MIkVi76HV2mzq08FMvlEhUKyu/Yg
aIR+SUvOU1rKeFqzMtFvk871XYOMJISV5RbM4reNUT6zrjOSansg7i7lka6njLHx
moxQAJgji9LvdiM157WMostMr2uFpw==
=OwXh
-----END PGP SIGNATURE-----

--tkkk7d7hsv6owojv--

--===============7464691629443531749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7464691629443531749==--
