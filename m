From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call
 with uninitialized object
Date: Wed, 8 Oct 2014 00:01:50 +0100
Message-ID: <20141007230150.GO4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-2-git-send-email-tiwai@suse.de>
 <20141007170938.GM4609@sirena.org.uk>
 <s5hppe3lrzf.wl-tiwai@suse.de>
 <20141007172337.GR4609@sirena.org.uk>
 <s5hlhorlqyw.wl-tiwai@suse.de>
 <20141007180434.GU4609@sirena.org.uk>
 <s5hd2a3lpcn.wl-tiwai@suse.de>
 <20141007185443.GY4609@sirena.org.uk>
 <s5h4mvflna9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6543552552308572090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 497AC260605
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 01:02:12 +0200 (CEST)
In-Reply-To: <s5h4mvflna9.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6543552552308572090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYpwwOSOoAAr8PNn"
Content-Disposition: inline


--qYpwwOSOoAAr8PNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 08:58:38PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > That looks ugly, yes - I'd be doing a check for ret before the second
> > property call or something.  Or just put the pdata check in the existing
> > error path.

> Well, I don't mind much how it'll be fixed, so I rather toss this fix
> to you.  Feel free to cook :)

Well, I can't even see the warning so as far as I can tell it's all
fixed!

--qYpwwOSOoAAr8PNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNHDeAAoJECTWi3JdVIfQoa8H/2sgBI6uFlMtwAovHUVgH3Ss
kybx/H3HJfWUHVMR1FZFEEmEV8j8CyA+e93qGSeg4eF8eoNTo4QBVhKnA1u7kwhK
FhDo/FUBj5UkZjNv/PQZvX1ZrAU6XOiHdKOddxlhEb8ZKS36OTVIGfx4CAsyJeiT
Yzj2rLD8akA8OJCO1oCMiJRudo5lk5pCQ+cjoefXtipmLQnaWiEYlUUZpwJu3217
WgafNX0CTskEa7dbR2Lp0GNkuqw1MITxEbrbew5RKCySd5WxKncSXEEIu1XMjCwp
jU4AiJxhcW8wh527hE92bYoUebHK231xI6RqVSXlztQD38O89On1h3iak7D50VE=
=rFTe
-----END PGP SIGNATURE-----

--qYpwwOSOoAAr8PNn--

--===============6543552552308572090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6543552552308572090==--
