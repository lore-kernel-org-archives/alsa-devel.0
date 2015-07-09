From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Fix missing free_irq
Date: Thu, 9 Jul 2015 12:10:10 +0100
Message-ID: <20150709111010.GL11162@sirena.org.uk>
References: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
 <20150708111437.GQ11162@sirena.org.uk>
 <1436406493.15417.4.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A/2QVx3Okwt4+LIK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436406493.15417.4.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bardliao@realtek.com, oder_chiou@realtek.com
List-Id: alsa-devel@alsa-project.org


--A/2QVx3Okwt4+LIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 09:48:13AM +0800, Koro Chen wrote:

> Do you think I should use devm_request_threaded_irq(), and change
> free_irq to devm_free_irq in remove? Or I should keep the original
> request_thread_irq(), and just add a free_irq() during probe failed?

I'd just keep request_threaded_irq() and use free_irq().

--A/2QVx3Okwt4+LIK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnlaRAAoJECTWi3JdVIfQPzQH/RQOC3u9lrXQvVvLMfO+gdYK
+sWDhDS0LoPrv+MNFdbz+53vSiAw4TJbV1PdfI3IDzoRN9SrEsFHBsTEnjg8oAw7
XhNs07TZd1cdudAA/2QIZRc+/Jotl1CgTtBfRkrf1qSlwsibGCpBxkcsydIKmTsf
XhQZf791NJzU79flHKLH/g6HhFYoNuakligz9NuhJEY6DA/CnO3ZffBOj8DoTktx
EgH9gS8GASIO+eU15Pm4yPGapleFqVhOx/fR4oludH0bPe+LKqmPdMW6dsEmeJyg
5+K3Ag7BoQxVOcT+15wPUZ+d3p/E1RxBUziF3S7mf1+RpLxqh4diXDRagVujjn4=
=jmO1
-----END PGP SIGNATURE-----

--A/2QVx3Okwt4+LIK--
