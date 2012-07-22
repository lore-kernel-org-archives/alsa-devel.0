From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Can ASoC support SPDIF AC3 passthrough playback
 (non linear PCM) ?
Date: Sun, 22 Jul 2012 19:42:34 +0100
Message-ID: <20120722184233.GC4557@opensource.wolfsonmicro.com>
References: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6841028005073147122=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86B92264FE9
 for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2012 20:42:34 +0200 (CEST)
In-Reply-To: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sangsu Park <sangsu@gmail.com>
Cc: android-platform@googlegroups.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6841028005073147122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 22, 2012 at 12:39:50AM +0900, Sangsu Park wrote:

> Are there anyone who have a SPDIF AC3 passthrough playback?
> or anyone who know the clue about SPDIF AC3 passthrought playback
> supportable on ASoC?

I don't know if anyone's tried but it should be pretty trivial to get it
working if the hardware can do it, ASoC itself doesn't pay much
attention to the data formats.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDEmSAAoJEBus8iNuMP3dDYgP/jM6tGfhlWXty3jRytCymBdC
RESyBcj9O2palJFOfNnld+NsvH+8eiQH+it5QV6PbMBNrxqXRPfO37BwBDsiO1WQ
/RDbm9rUQLtDF/DXup0Wnyr4yOZDIFLkitPIj/s0wiu52uM1et3w84xNztmyVxJC
VlYTUzfRNfx8ZF/d+Va53Hz/vWe0Y4Q05PCvH3/5kxrXhBYYXO48Hd17KYTs9KGI
GTZ24KT9ngz0ZS7gs2+AF2E6pY1X/u/ByLvRpH5GFkXCs1rwIslBFIe3HOMxRnCc
a93cFPxAIzAyLsKkep72tf6yym6FHRP+wA8x4MFw/D+CffJR3IrQjVwfQASZ/+hh
5894fMLf3+mxvR56E5duePAlF0Be7+SsJYDoR2e9eqdxe3cOWGuMPcmSzFJ5fD0U
+DB8AUMb3CwLGDA4NVCCyo/W8eh2MOJEAlHUu5HOP7LDWggCFkPjYc8pU72D698h
gCaatGTJKqkVaeyDuTG5h1vFSFjasbhpO3ck04BXi+SKxf0BAjXVAJ7Rv1E6v+I7
EXiVwPr7o6uD9T/IOnC90CUVgioSu9wUhwEu0vfTovrKz1/0YqzWftkpxJTIW17Q
PA67T/tgTNAUzdiiVRRZZVlLO/IWRCMzZ7c5BS76HPyWgwTGSFZ8eAONCc9I+stM
iMuUxVOUhcRh9a1YmfJm
=VlpP
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

--===============6841028005073147122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6841028005073147122==--
