From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Sun, 4 Sep 2005 21:34:20 +0200
Message-ID: <200509042134.23916.alien999999999@users.sourceforge.net>
References: <4317CC51.3040709@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1363588.Z7H6E7qnQd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4317CC51.3040709@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: Erik <assie2@zonnet.nl>, Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1363588.Z7H6E7qnQd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op vrijdag 2 september 2005 05:51, schreef Raymond:
> I am not sure Alien's au8810 patch is as same as Igor Kovalenko 's
> au8820 patch. They seem to have their own patches.
>
> The EQ part in diff11.diff seem to be not tested since EQ is not present
> in au8820.
>
> You should cc your reply to openvortex-dev@nongnu.org and
> alsa-devel@lists.sourceforge.net so that the others can keep track of
> your problem.
>
> There are 3 bug reports for AMD64 in ALSA BTS.
> 1047 - au8810
> 1138 - au8820
> 1025 - au8830
>
> Need feedback from testers with au8810/au8820/au8830 and 32bits/64bits
> machines to debug this patch.
>
> 1) EQ, SPDIF of au8810/au8830 are not present in au8820,
> 2) WT of au8820/au8830 are not present in au8810,
> 3) SoftModem of au8810 are not present in au8820.
> 4) 3D of au8830 is not present in au8810/au8820.
>
> Please correct me if I am wrong, I think au8810 do not have any 3D
> effect hardware.

i'm not entirely sure, but i think it has some 3D stuff, since i've always =
had=20
controls to manage 3D depth, etc...

unless you are speaking of something else...

--nextPart1363588.Z7H6E7qnQd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDG0w/uBWKXETrtdcRAvCBAKDiRCgzU/9tbpDbWmRqcjEgfgf6hgCgqZHy
4XlNk+PjamB0g/nsv8hzPSo=
=jHG0
-----END PGP SIGNATURE-----

--nextPart1363588.Z7H6E7qnQd--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
