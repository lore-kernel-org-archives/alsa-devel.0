From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinvi-mcasp: Balance pm_runtime_enable() on
 probe failure
Date: Mon, 10 Nov 2014 13:45:48 +0000
Message-ID: <20141110134548.GR3815@sirena.org.uk>
References: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0p6fkQojZ86Dx7oG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, peter.ujfalusi@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--0p6fkQojZ86Dx7oG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 09, 2014 at 06:15:14PM +0530, Anil Kumar wrote:
> If probe fails then we need to call pm_runtime_disable() to balance
> out the previous pm_runtime_enable() call.

applied, thanks.

--0p6fkQojZ86Dx7oG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYMGLAAoJECTWi3JdVIfQTl8H+gK/cfvzkG0eHQ2fzjLswA3v
QFZsS2nm9EJWB3bLJEV7JhAYyTeMWFHepv/pmMiANBi2pL0ZbbYRS1gH9A9VJy/U
+VDnhgn5KNBod7musETF24x+Nshba5BXoOyF9Btr2xEXHkOv4OgwhCtupU/c4YCc
f+AZtge6mm8TpCKrbHOnV5L8mmvZobHWerD5/f8g4ZohI9mWGtwY+0B03SnVQGu8
4vLXcu3AWJH3HgU0Rw8ARae1s9/VYKOlifoVqdwI2PCGucSDSsvwq6G7OSIvQMcK
+7Zrkwxb+h5xY4YQY6gX4pVSm72S1frfOXo1ckuH9Nhf0MisLz7LzJo0cnDicwA=
=cq7Z
-----END PGP SIGNATURE-----

--0p6fkQojZ86Dx7oG--
