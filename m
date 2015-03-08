From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix component lists locking
Date: Sun, 8 Mar 2015 19:46:37 +0000
Message-ID: <20150308194637.GZ28806@sirena.org.uk>
References: <1425753243-28288-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4288068594863506773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1CBA2604FC
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 20:46:47 +0100 (CET)
In-Reply-To: <1425753243-28288-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4288068594863506773==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6ysXqiu0yoUmUNJB"
Content-Disposition: inline


--6ysXqiu0yoUmUNJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 07:34:03PM +0100, Lars-Peter Clausen wrote:
> Any access to the component_list, codec_list and platform_list needs to be
> properly locked by the client_mutex. Otherwise undefined behavior can occur
> if the list is modified in one thread and concurrently accessed from another
> thread.

Applied, thanks.

--6ysXqiu0yoUmUNJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/KccAAoJECTWi3JdVIfQutsH/22jKU90/GHghvswxvdLQhq+
U7PDP588KkKkrm6lTupggh0w9TXUoMLKBQf9cUX2zxG7htrfw8kMvWZcgpUT3su7
qSv41J13uXkrkt+4gtV8msNPq1gryjTYQYKpGHUKaVItX218b2EsXKUXCUA0X5/e
r+OvkAMpgFJkFT4deWZpLF6NPx95H/9YTgWmFm6P+1aOM5Prwi84s9ZV9QP1F9AA
oz2SCDzgYWlsxf2iGFZncbxZWkVE/VtDQjpDFXI/6KHkkVvJ8gq9m9fhRwrMTMHa
5CVMbpUFBpdBd0q+t0zBLvqdsSHnCpWuZ2Ja+6fRZN3ZcLayk1SnkyDsUbcwp6Y=
=HR+t
-----END PGP SIGNATURE-----

--6ysXqiu0yoUmUNJB--

--===============4288068594863506773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4288068594863506773==--
