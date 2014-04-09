From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register mux
Date: Wed, 9 Apr 2014 16:56:31 +0100
Message-ID: <20140409155631.GP6518@sirena.org.uk>
References: <1396656730-30145-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396656730-30145-1-git-send-email-aruns@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: lars@metafoo.de, lgirdwood@gmail.com, swarren@wwwdotorg.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 05:12:10PM -0700, Arun Shamanna Lakshmi wrote:
> 1. Modify soc_enum struct to handle pointers for reg and mask
> 2. Add dapm get and put APIs for multi register one hot encoded mux
> 3. Update snd_soc_dapm_update struct to support multiple reg update

If you've got several changes like this it's probably a sign that the
change ought to be split into a patch series.

I'm still not seeing any handling of the issues with having invalid
configurations written to the device during the process of carrying out
multi register updates; I did raise this with one of the earlier
versions but don't recall any response.

I also think I agree with Takashi on this one - trying to implement this
without adding an abstraction for the control values is making the code
more complex than it needs to be, all the conditional paths for _ONEHOT
aren't pretty (and don't use switches which is the usual idiom for this
stuff if it's not indirected via functions).

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRW2rAAoJELSic+t+oim9ka8P/1+sW/wjVzqIBZeVtR2iAX+T
+1ZPAwXnaHyzimmvf0PImEJS+35hsTANy6kAaA7bE9qAKOV9RYQd8YK/OL3ZusxG
skB9MmMIhUjJ85yg5eRJXSlvD4GhqnrOK2avjFtgVzGTZH/DjVQ9TUnpmhDYfvHu
tDgKcg4MeGu9F+FmEsX3Fjn/7zr/BqTsMsjgh97vyJs5Li4qQ0HUO8/BDCeR5mox
3ZQdy3Aqjh3SgXtDqlbdlUokfFFMQIW79Nfo4u/Jlr5ftuQrA3CR3BrEWm6ZqtAH
HS972V+kQrTUMDdadOj9fFaP0WsIxMSCC5Wz5M/m3G76J2z5znXgphxoYvxFL3Y4
02ATNK5Z++lWjZIfdxs1QN648F5CPMB9qDTbwV6ITSFJh/QY5sNv0D0MPjJx8pxW
3aJcfY0NUc9fJrJtMZDHS7qm/9foAzYdhv5tYjS33chtQdT0dcrvZ8FSHjJ83DiR
Ca9r3QHibi13E7WWOsE1JuIGMGaCkDBK0398ERW3wUFja7l3M6gVGHCuMmBbopOO
ty2pgeBlHjFJyvSSUxB89vb/c+6oJ8tSBduD07nE20hKrskVFy0RnlARYF40OQZ6
kXYsQnV9jpaTiTkuIMEkfhxWYOsLwSg6Im3uuoQ2msUhtQKXqbJEi3o3eDb1jOPg
GkZPxk86eqDpISsP30Fk
=bSny
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--
