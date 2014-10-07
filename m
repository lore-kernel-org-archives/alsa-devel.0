From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call
 with uninitialized object
Date: Tue, 7 Oct 2014 19:54:43 +0100
Message-ID: <20141007185443.GY4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-2-git-send-email-tiwai@suse.de>
 <20141007170938.GM4609@sirena.org.uk>
 <s5hppe3lrzf.wl-tiwai@suse.de>
 <20141007172337.GR4609@sirena.org.uk>
 <s5hlhorlqyw.wl-tiwai@suse.de>
 <20141007180434.GU4609@sirena.org.uk>
 <s5hd2a3lpcn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536267772284290188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE2D626044D
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:54:57 +0200 (CEST)
In-Reply-To: <s5hd2a3lpcn.wl-tiwai@suse.de>
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


--===============0536267772284290188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIZeFZfK2rom9VmH"
Content-Disposition: inline


--oIZeFZfK2rom9VmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 08:14:00PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I don't actually see it as a readability concern - to me having the get
> > and release close to each other and especially having them at the same
> > level of indentation helps.

> I do understand the merit, but it looks uglier to my taste.
> The success path goes again with if (ret).  (Or we'd need two goto's
> or deeper if-else blocks.)

That looks ugly, yes - I'd be doing a check for ret before the second
property call or something.  Or just put the pdata check in the existing
error path.

--oIZeFZfK2rom9VmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDbzAAoJECTWi3JdVIfQQ3oH/3LwpfgEN3T4o7aLyyqlGfti
6XIhCgxSntKmz4ijS/IjkegWd8zZb4fe6HIlQa7q/3GBbKxR8gslDH+bB2TL4EYF
yQsnD9DH53V+tACuweCnAcb6dIVM/pZK9wg+z0uMxdA00OE/DETHmvCxPJUD1msO
roQ89m4D+sE+ojddwbVuC1kykTXWstWM7/5zPPKcNTRUWitIAF1SGpWHfPowfOrd
5d2hTz1A/i2MD3AYFbRspWrpjS4Az4Nnl1J0hfJBjhKXFhtwG3QDa4PGXYK0iJtu
IXFg6+GJ9GX7ME9wgfBNwJ9cYmycFspiwDJZBw2vmentI6jP+ZkaDxJpw5m6KGc=
=nZD2
-----END PGP SIGNATURE-----

--oIZeFZfK2rom9VmH--

--===============0536267772284290188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0536267772284290188==--
