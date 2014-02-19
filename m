From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Move extended fw base and
 size fields in struct sst_pdata
Date: Wed, 19 Feb 2014 13:41:26 +0900
Message-ID: <20140219044126.GZ2669@sirena.org.uk>
References: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1423435192245801093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D35B12610D7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:52:53 +0100 (CET)
In-Reply-To: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1423435192245801093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="33vRkRs1qLSKUE7/"
Content-Disposition: inline


--33vRkRs1qLSKUE7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 04:42:02PM +0200, Jarkko Nikula wrote:
> Move fw_base and fw_size fields in struct sst_pdata under ACPI data for
> clarifying that these are not related to firmware file but for platform
> specific extended firmware area reserved by the BIOS.

Applied, thanks.

--33vRkRs1qLSKUE7/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDXzAAoJELSic+t+oim9uoAP/RoIAvi82L2l5Q9TZQo1KW97
SK1amr8d8JmifwWkNB+3ti0mOZ33BTiGAllzENWqGANRGwYBziEg+djc7S3/cBLq
9K/kYcV3GqfNIR/40gSHwGCYmnb1SRIb+YnHLxIeQU0XnjWm9pwKQs0SjhTXAPoO
tTiqHzs0iQ7yEl9XP3/MP3TyqJ+FcR78fiSfP0JZ7A8bPdzkTHjAmWgQxLlc8HYF
uGyxWBg8i3d7D2LMNTdV/TeCOQfPrLV2mbgvVrLix7/fN5BhAPbG+KzkzZdgWQ/s
19CA9xxwvlNp8OYIY/xep2RivlAp85J5n2e1AFO/hChyRn5vQ6iJ/wK7FSsqxI2l
Ofx9YoQPP7oybseZh2cuC/aunW6rzin2/CreyCth6vC6VsHKcsJr8hYhp90eMRaq
0GnuNl8OeXo7/vfUnrXEHJfuSfdTTnNN4jlzI6xCrYh4YGJs5YG2nP72B7QjOluJ
oMAy4zvLc4ierJSimpbh+4xrVugn0/R7Ex+R88oXxBjp+6lo8zwXKYZJcvLK8+Ry
RbtfLGokrFJKyF2zfcdHcddBpGONTo+H0wqOmtVF8QXUFzr0Q+Sns5KnOVFyRk5E
TJPIMf+9zXdPha13ThglWrfVzcyTDM84C0aSDI4gySMCtdf2C4wSYmRbU+3aYATC
DcEI0RGxCLvWBWyWXJH+
=e1Dm
-----END PGP SIGNATURE-----

--33vRkRs1qLSKUE7/--

--===============1423435192245801093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1423435192245801093==--
