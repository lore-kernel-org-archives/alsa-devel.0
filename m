From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Lenovo Dock + Thinkpad X260 -> no HDMI audio output
Date: Wed, 16 Nov 2016 13:07:54 +0100
Message-ID: <20161116120753.4wuw5feaoklqajf5@earth>
References: <20161116023821.hcwg4u2iconuc5d6@burischnitzel.preining.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkxs6u7j3zmxdcii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161116023821.hcwg4u2iconuc5d6@burischnitzel.preining.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--zkxs6u7j3zmxdcii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Norbert,

On Wed, Nov 16, 2016 at 11:38:21AM +0900, Norbert Preining wrote:
> I am trying to get HDMI audio output via a Lenovo Dock Ultra in
> combination with a Lenovo Thinkpad X260.
>
> [...]

Lenovo Dock Ultra contains a DP-MST Hub to provide all those
HDMI/DVI/DP ports. Audio over DP-MST is currently not supported
by the i915 driver, but there are patches (developed since ~2014):

https://lists.freedesktop.org/archives/intel-gfx/2016-November/111353.html

-- Sebastian

--zkxs6u7j3zmxdcii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlgsTBcACgkQ2O7X88g7
+posBRAAqVtkdL9hcDBNieX6qXTXBHGMlKaKZQQ0cUaMTtdoM5H/X90BdphQMkwK
InXPePxyC2zQpQXBc9malzxv+K7LRdIPA5NSZnbZ4dPfWcIU29JOOmNwzGUorLmt
oLmEV5hY0SrbENq1ivpr54tYQS2mxnj+pOAbTJdTYzAPWkWTDXwaZ3MclR2CVXUg
4EokdI/zFQOMo/8upulWe9MsSSz+gIn8g1GmxCq3ixfBn8Lxd/sTE8zC957rJ5gY
U4ZBjjkgMmcRkD2Po2YtMs/Uc6+Xt2flI3XhL4bdIgqLBKNyS091+wV1kUqNTmom
WK2jh+m75Bf2gTPQG0D+A9LKvDKCcxYYUi7akfZSyCqU1NWK1z+foBuOxdK3KXvw
Dss85OHFvQOilkxdLDK5dAPVbjZgR0oiUj31yDq10bh7qNFPbn8wfdZQ+99rHqW1
v4Gocj4/oS3er2guI6lDg8CQij0TF8oqm8vn6SDpvoPu1nXQIyZQB+h+7nRu4mID
o3Jj8eb5Rr5zXTqfkHBnEBL3FfNPp1hkg+7LXAyVd22+DGYDkkV6VfXiugBSEwmM
lefWZ5UKR2vYnsInJodtle+MnK+TiktxSScj4hdHV60ligknNOXiuuK/UxNGE1tb
hl1nUh99FxbYUAXPFBTrwJhej0j0FLAAPwUgh5hZIbsWcpQIu2I=
=P+zb
-----END PGP SIGNATURE-----

--zkxs6u7j3zmxdcii--
