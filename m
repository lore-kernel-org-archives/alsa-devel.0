From: Eckhard Jokisch <e.jokisch@u-code.de>
Subject: Re: How to write driver based ALSA for ARM ?
Date: Fri, 26 Nov 2004 06:00:53 +0000
Message-ID: <200411260600.57180.e.jokisch@u-code.de>
References: <41A680FB.000003.13942@TCLmail>
Reply-To: e.jokisch@u-code.de
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1905563.c9cyFRGRWZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41A680FB.000003.13942@TCLmail>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1905563.c9cyFRGRWZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Sudong,
one major thing is that most of the ARM platforms that I know don't have=20
anything like ISA or PCI. so you may need a lot of information about the=20
hardware architecture. I think that you can take some of the ALSA code from=
=20
alsa-kernel/arm/sa11xx-uda1341.c  .=20

Eckhard=20
> Hi
>   I want to write a AC'97 sound driver for ARM cpu based ALSA. I
> have seen "writing an ALSA driver" written by Takashi Iwai, but it
> focuses mainly on the PCI soundcard. I don't find any source code for
> ARM in ALSA driver.
>   Who can give me any suggestion? Where can I find any open source
> code of ac97 sound driver as reference?
> Thanks!
>
> Sudong

--nextPart1905563.c9cyFRGRWZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBpsaZiF9FD4kCbGQRAqjxAJoD+YTBRpb14U5X3KERImwYre2Q/ACg2EsS
JAZjaXtyBFb9Vq24akigwZk=
=2ZXw
-----END PGP SIGNATURE-----

--nextPart1905563.c9cyFRGRWZ--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
