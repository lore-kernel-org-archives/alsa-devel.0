From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] cs42l52: use same init values for
 MASTERA_VOL/MASTERB_VOL.
Date: Thu, 23 May 2013 08:58:54 -0500
Message-ID: <20130523135854.GB2412@sirena.org.uk>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-2-git-send-email-nschichan@freebox.fr>
 <20130522183425.GW1627@sirena.org.uk> <519E16E4.1030604@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5424543181807256816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF08264F3A
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:59:06 +0200 (CEST)
In-Reply-To: <519E16E4.1030604@freebox.fr>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============5424543181807256816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 03:17:24PM +0200, Nicolas Schichan wrote:

> I was not aware of that, The solution would be then to fix
> MASTERB_VOL default value to 0x00 instead to 0x88. Shall I just send
> an updated version of the patch or the whole serie ?

Don't resend anything that's already been applied, just send things that
are still being worked on.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRniCbAAoJELSic+t+oim9Ck8P/0efgUQhZrKhNcice+SZmdWi
VnD0s3FQN1nog30h+avvszSD8TPtJtFpDW04PNfGBkYj8ZT8CiGG6M6BZfYEn9nE
gl0QgCzVSms0d7O69k5SpgB8+6rlrEIMX5y1FGYGfezqpTgxEGkb5boKFAdlDbKl
2qYqwfysFZ3rWW55CsQCOoyqg/rKqgifqY8UKaZCnm9/oPpppkMRkQdrNI0Vkicx
SoofNkUM0fhA6SQIut1NmR2/xvxguLX5ydcKGOFMhDzxIuG+Op1RuaOsaW1U8SrF
3syzJtFehJWKxRJbn+TwOUAsH0ewcj3EpQSPOLuzE89kNKV3bDfpN2jJN0aSWJCz
wWqQ8q1sP6RZZ68yOkk+00QLydeZ64MLYBvcfqfgzlJpW10qlhQxD4D/vJvPLNMd
nMfs0pBIso3e7vlHDi6y6zGO37MijZSvyLYiECqA0MY7RNGR2x/KD/77BKg6PpEm
HWOtrQVPKNKTZhUAdYP6xrUzqs67jqEdoDcrbGcZAB/k4rOdNEsg5uNfdqsboZVa
JdyZagQypZS8mgHQd4ClHj8Vi9oQlfppc94BvpLHWWNKNrOwnenR8dLZGy/vCRBG
aouy5MhaKUmfhIWk5YfbkWQcF9UaxSsqo31pEhwh7jdKg3CsQJJUOFOwnzaZ9Sh9
Vov1kNWHppa3Wo5Vhuls
=Fk3v
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

--===============5424543181807256816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5424543181807256816==--
