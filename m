From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: echoaudio: Use standard C
 definitions of true and false
Date: Mon, 10 Aug 2015 15:54:15 +0100
Message-ID: <20150810145415.GC10748@sirena.org.uk>
References: <1439208173-16501-1-git-send-email-broonie@kernel.org>
 <s5hd1yv5ntn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6259505093693870902=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 656D026598D
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:54:24 +0200 (CEST)
In-Reply-To: <s5hd1yv5ntn.wl-tiwai@suse.de>
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


--===============6259505093693870902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 02:29:24PM +0200, Takashi Iwai wrote:

> Well, there were leftover FALSE's that broke the compilation.
> I applied the patch with the manual fix now.

Sorry about that, turns out allmodconfig isn't so useful when run for an
architecture without PCI :/

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyLsXAAoJECTWi3JdVIfQEe4H/jKMewkNfEePi2H4MeweYPz9
exmd+GcviDvOoo0ginOrSlE+rZy7cFrSvIaUtake+mcQ6cdapJIkvm83HbfPlhfm
o/4jARetfRdRGt7rjQMbAs2k7PaBrIlBe+9a5oboHR5I3zqY6fkNk99sk5b5SObT
c0dj1K2TSuhIstKGD5n7iT8bJU2FOcZJWl4MXax03hNwTZBwOUISswaZjAqEjm4+
vf4xF36BQeYx9wW/Kq6Bji/U0ooKrjIdXSV/3/M7dCXhXtC1bwnq2YHxxu5/d/ce
qM3psKxR+RBQP7EmTfMk07k/Mjen4PfWArRR9dF4s5tOmHnjAMUw8uGGRq9oNxg=
=iGFm
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--

--===============6259505093693870902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6259505093693870902==--
