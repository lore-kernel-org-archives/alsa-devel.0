From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: rt5651: Remove
 is_sys_clk_from_pll, it has ordering issues
Date: Thu, 22 Feb 2018 11:13:56 +0000
Message-ID: <20180222111356.GD5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-2-hdegoede@redhat.com>
 <20180221111821.GA8334@sirena.org.uk>
 <7c0a41b1-6765-13e6-be96-b354c744ba29@redhat.com>
 <20180222104816.GA5905@sirena.org.uk>
 <1af26369-fc76-8862-86bf-f554c3559a41@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5485474268815261909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA55A2676E1
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:13:59 +0100 (CET)
In-Reply-To: <1af26369-fc76-8862-86bf-f554c3559a41@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============5485474268815261909==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2018 at 12:00:35PM +0100, Hans de Goede wrote:

> I hope this helps clear up the confusion surrounding this patch. And I guess
> I need to improve the commit message...

Yeah, that's *probably* the main issue here.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOpfMACgkQJNaLcl1U
h9BZzAf+L5Zg+MpbGE3EQjQqXZe0TMR6vzslQtGhf36m1xmtH1fIoyUMLpJi3mJp
SLvgEu7aJrgFI3utSCewbQ9AMoyISx80jMB9Jn6ohwPNFuVp4Rwf5lc3AXbz8/X2
NSQHUf78lY9IOJuvqQ1TlEznWygmhG0Ht/HW8hY6FT9Dypv/J+e8lYGHcT5Sqi8d
i1VOj06Aouci7QYHAZyHHTDuMv2x4EVYi3eVdzzYslwUt7TxMEo+RMo1rRujAXaZ
4PrA23CQq54cvdt2tAvKrAxFyHjTjOb4eXlvOD58nxUzNv+hI9/A0E3X0wDh/4se
XADvdjLX5t53qJyfUnSBI+PeNtOmxg==
=1SMY
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--

--===============5485474268815261909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5485474268815261909==--
