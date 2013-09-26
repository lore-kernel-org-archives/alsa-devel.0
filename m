From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: kirkwood: Extend the min and max
 number of bytes per period
Date: Thu, 26 Sep 2013 11:24:08 +0100
Message-ID: <20130926102408.GE19304@sirena.org.uk>
References: <20130919112043.5ad16147@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7101512311318021416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 46924261A6C
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:24:15 +0200 (CEST)
In-Reply-To: <20130919112043.5ad16147@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7101512311318021416==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 11:20:43AM +0200, Jean-Francois Moine wrote:
> This patch extends the min and max number of bytes per period.
> It mainly permits to reduce the sound delay in MIDI real-time playing.

Applied, thanks.  For the minimum limit is there any hardware imposed
limit that could be used rather than tweaking the numbers?

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRAtEAAoJELSic+t+oim9RykP/37/XPq0ayZkbSob+V4Xzb0r
F1/xgVcXjFS9rsp1M9RzcqNgJNQrsru03ZdOOvgjAG3WHRbCpyVBMNRlz1uhSPuM
MbbE4y5GCkTwIfP/GSKmTXN0Ux8eb3Uebaf0ZtT/AG3xbm5YV+buSRatwUu2d743
CEcDdzjT2r9P4yzEv+0wxBdEsYLqJqT7uu0Q6ZBTVsWe4wKmaiumICM23nH9kHDD
G2wTk3+Vl/x6VdzvN78uTv1mwkIW9PdmaPuavPiY6hLTmjEXSKCXuS/JJT3xvHxF
P1Z+YrWCxNBH+T0QeOAcZanPxSIyoM5CXzYwfeonf0FtWnsN0B6aeHMDj5Q/i8tx
h3dOaSK2WIQyHZbQ+YzoCDRjtZshvA6S6FkbKS87tn1U+/+SWGreUtCpJE4ZjPK9
zW9WLy2j6HMIUVjaBNBfSS8rAoBP42HtbXmn2f89yPHsArOpvg3tQG/duRLENJqJ
x3jDkk2EM9PrAXNfX7U0SpFvch322YszTFJWQU7zTzRoJr5CY2bkN82H4J1xXOx7
t9jzpm+eIcE4HDZm5j0Okx40BibPNUEpuGH+R4HOYUbXP/PvRcXu5gQGDIVHBC6M
2MWYkYkIvTVFMiOPOqUwNevF2ZVLCIYYsKC6pKvZ8mKFZi7dOQp7+BM7sh9nXXPG
emdo4Ulywwb4Eum9kOYB
=3EW9
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

--===============7101512311318021416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7101512311318021416==--
