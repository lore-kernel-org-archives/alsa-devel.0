From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/9] ASoC: Intel: Skylake: add DSP
 platform widget event handlers
Date: Sat, 19 Sep 2015 09:11:22 -0700
Message-ID: <20150919161122.GD30445@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8532770105819403260=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A058260660
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:32:21 +0200 (CEST)
In-Reply-To: <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8532770105819403260==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 10:56:38PM +0530, Vinod Koul wrote:

> +	if (list_empty(&s_pipe->w_list)) {
> +		ret = skl_tplg_get_pipe_widget(ctx->dev, w, s_pipe);
> +		if (ret < 0)
> +			return ret;
> +	}

I'm not entirely clear what this is supposed to do or if it does it
correctly - I suspect it's trying to always create the pipe widget which
might be a bit clearer if it just created the pipe widget.  The fact
that it's checking if a list is empty is a bit worrying, what if some
but not all of the entries needed on that list are there?  Is just
getting a widget really sufficient initialisation?

> +	return skl_tplg_bind_unbind_pipe_modules(ctx, s_pipe, true);
> +}
> +/*
> + * A PGA represents a module in a pipeline. So in the Pre-PMU event of PGA

Blank line between functions and the next thing.  I am getting fed up of
seeing this.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YkpAAoJECTWi3JdVIfQipIH/ArfS/CP/8fp0ir4SRvqeOk0
28h1pjlOa+z4O8tjDnxpI+jWiJLhWstzhA07dsPn3v4QeXdrwbfGUVeGcbiS7cSG
lzN0x335Sh9qSM5WrA0W443p7G4ADM9H4B3OoodykATyr3UWGYUUVmFIWJs4DL73
I3LElmYIivXONv7K43w3bd7Ts/z9NfXj/4cJ2kLxnoB0uLTD4ejTuPco0h1uRAvD
F5ctt3ATEXjujTAO+Z8t9ydJZ2VujWBCnqMQ/yQFb0QrvwTcxxj7bCI1Ym+JA6d9
P29yn2Nis6oxZDIDTfj0oXcEPYwIEoSEF9C8IpzG/e3EOfb10pbyyzJmo+kBoVo=
=BzDg
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

--===============8532770105819403260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8532770105819403260==--
