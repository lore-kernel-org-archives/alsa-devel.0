From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l52: fix default value for
	MASTERA_VOL.
Date: Tue, 28 May 2013 15:41:33 +0100
Message-ID: <20130528144133.GP3660@sirena.org.uk>
References: <1369320782-2371-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3098747666835131063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D62E2610BA
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 16:41:53 +0200 (CEST)
In-Reply-To: <1369320782-2371-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============3098747666835131063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctUzwJm0i+kwMBIK"
Content-Disposition: inline


--ctUzwJm0i+kwMBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 04:53:02PM +0200, Nicolas Schichan wrote:
> The default register value for MASTERA_VOL is 0x00, the same as
> MASTERB_VOL.

Applied, thanks.  Please use my current e-mail address as per
MAINTAINERS and so on, the Wolfson one will go bad at the end of the
week.

--ctUzwJm0i+kwMBIK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpMIaAAoJELSic+t+oim9je4P/3RNUKo3oteZS+jQYeGKekOZ
1frn11H/2yy21x+gZM3tRgd1EkMc5JaL2aYF/xXdeFHGe0r502gYcPpZM6AKr7Wb
o9a10zuLSTIjYs70zAuTJYZGCiaDFcVxfsxRfa7l1dC9Gwo9pdZ2fC/NdGa4Jmac
WpGoNfsuMYJnfX9IiNqDQSXVDMVQQIIhkHS02D/k44XTAPvqgMSvDRTF7cRZ+kDJ
qUCpSwMdHol+eQX7zMPhu0DpSJVwW5C/oVMA+bI533zZPzrvM9hch7Rv8jFkymQx
kHBOBcB1FTD8EBxkbVrAV5z+hHBDqV6Xc8tGmyLDN4IcFdpCCqmCv0vavh176ona
Fk7FtXT9USUkqieVuVlCNN9LeKXODvT6GuyNmagCW4JkU32YS0KrxhT6ypqgYOI/
xJrJrnq6MSDJ+OTNea0p6M+C4VMR5u8lPVdyrUhjRy4KpDeMOC17nU6ozzo7BHCC
f1K6cGmcI0uYptJghTG4TtCjY61fYfS4PxXaxB5zmgKelQIn+wbCEiR1SKO5W+3C
+lZ+tdL5MLa9Nyg+L7jtXXpXLRmwbx/ROfHXNnaHJQOn2LUnH09vW8gDKAW5iTkC
yMMruge0/LEqTmTQ5dkpU2nyLCgxYPLNuPDieF2dZj3AFwhG29/1ibaz/mpWLLFN
xps7j4o0qnM2H1YIP+kv
=3e6Z
-----END PGP SIGNATURE-----

--ctUzwJm0i+kwMBIK--

--===============3098747666835131063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3098747666835131063==--
