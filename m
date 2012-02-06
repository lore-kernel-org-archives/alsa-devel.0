From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 6 Feb 2012 11:09:40 +0000
Message-ID: <20120206110939.GC3070@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1123954534356361370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2998924382
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 12:09:41 +0100 (CET)
In-Reply-To: <1328524623.6799.9.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1123954534356361370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 10:37:03AM +0000, Liam Girdwood wrote:
> On Fri, 2012-02-03 at 20:46 +0000, Mark Brown wrote:

> > to hand but what are the cases where there is CODEC control?  This
> > sounds suspicous, perhaps we need some of the drivers enhancing (though
> > no reason to block this patch).

> The other machine drivers were all using the codec pointer to do extra
> codec configuration with their kcontrol code so there was no update for
> them.

Which ones were those?  That sounds very suspicous...

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL7TXAAoJEBus8iNuMP3dM7MP/ifGDHkdCLjWQGCbVKY6445G
UTY8OAuq6thRfZ/2hoeBv19yUSqUH2yQG0OOKcgwUx/QuY4xECO3+IriysUE+DaE
KS+ZWcez28bKHQPQYMFfNZsYxB5OaSKxD0UsxrGiJHLZ0c9ec+ytipLVzLTT3/Tv
X4a9AAcIIwe2el05y9mrx7KSW2wLDO/0UY5ce58kw530ygO73osuZuqYLUINEMPZ
AfU5UIJAptOCQsgFMhNOoIInRgLPObGJ23J8PAQnJzcpiJqXHNXrlYzQEg3DqYBI
MrQOzwoAig0m2YrRBUnynrEa1YYlYnvgWsFsyedFo7gcePdJndu//dMo61V3Up+y
2ELwFi14pftWBxmYwwpj5iVRG62Qb18OXa0LSbW2vO5ydW9ss3aEF8u3t/cyvZRE
lGV6eCCN12MutEBtvqKKZOi17O3HcGg0WI7VlmsqRa5/XFuG5t9vCx8gWcxb4J72
AyyMPuibcUjqZF51i/v1mspQWv9jeFynHz4aeQ1A6HLASQZ86+dCjqrMlNGezGyu
+/AnLyxEUfML/ZzETEwxe4jHY40RiHyEsgPNM5oZ3Msu/yYhFUhK/F5PIhBGy1yK
CYXeos5dpWJAgM9rFrsNaLo8TGPMiJdiyiee/6iZsf64Ri5UPZwcd/bpYu4LDF0e
yFaSX9AZo4NDPepJfFy1
=/Fxo
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

--===============1123954534356361370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1123954534356361370==--
