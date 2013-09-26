From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl/imx-sgtl5000: Fix uninitialized
 pointer use in error path
Date: Thu, 26 Sep 2013 12:02:21 +0100
Message-ID: <20130926110221.GK19304@sirena.org.uk>
References: <1380115321-32311-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0606524380053806328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6644E262629
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 13:02:23 +0200 (CEST)
In-Reply-To: <1380115321-32311-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org


--===============0606524380053806328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2013 at 03:22:01PM +0200, Philipp Zabel wrote:
> This patch avoids to dereference the uninitialized data pointer if the
> error path is entered before devm_kzalloc is called (or if the allocation
> fails). It fixes the following warning:

Applied, thanks.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRBQ6AAoJELSic+t+oim9JaoP/0DO5h4KowJkvcDvvcKs2HcK
WYk8fvZdO75YvDVPXMQhJbHVvl7WdGGuCf+aQ+C8WtHsvAgBhmkVJZjEJsVLph3a
EYsxa50wiq/9uoa+N3CuLNyWYUug6a1U0JUUrdOijA7h4OwFA9IpT9E357HuvhV6
kUeSSWmJim3qPxQIJLc8PXQtGgU58Sl2u22hdwA92MxNrE0+hgdiAOoIMw8Jf6rA
nCEwQh1LE3T1z4hp1tQy6LJ/+nket50RJJu2rH5SG/zBhBb8FfHwq9viUQZtkykh
AthnIloR9h/gBRIN9bpvW9ebGfjLLRPQntwHk25CvUJZJkaPY2ujX49BnEQC4f+S
wSxU7dhvgJYfM2XuEXp5FRjEE+Vx9FdnTVB1lbqYMwiVNLsBJzlnTKXZBWMmpeg8
w8wpBanr56dGhmZC17TbTpxvBZMOFzS3ovQpiHbWrI+aKdKFyoFtWOVEKup4uCtw
6YVxgQH1fx5J5RlMtdxqi8SMDaK4JgIkW3E0coDyNsVM6NBVh9VcvmjBNeXauPQh
QGQy46zd7zv/M7UVPUBq+HX/ptI6ViZzzJgoE7Mepo7sTs3rvXVxEqR4zgInXvXX
hkweTLApg5uULdecXuwmmvOXnDnJUhNV5p+o7DioR+Qh588WP4Kb20OzLXMPwiXo
mEvUOevv5gGT25AhLZcp
=4yHj
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

--===============0606524380053806328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0606524380053806328==--
