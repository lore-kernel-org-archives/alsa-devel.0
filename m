From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Thu, 25 Jan 2007 12:27:43 +0100
Message-ID: <45B8942F.7050006__48669.8732631796$1169724555$gmane$org@drzeus.cx>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650911810=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.drzeus.cx (85.8.24.16.se.wasadata.net [85.8.24.16])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E61BC333
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 12:27:45 +0100 (MET)
In-Reply-To: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
Cc: fedora-desktop-list@redhat.com, alsa-devel@alsa-project.org, jrb@redhat.com, greg@kroah.com, linux-kernel@vger.kernel.org, mclasen@redhat.com, Lennart Poettering <lennart@poettering.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============1650911810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=_hera.drzeus.cx-11376-1169724464-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-11376-1169724464-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher "Monty" Montgomery wrote:
> This patch was generated against 2.6.20-rc5; it fixes a bug that
> cropped up in a late 2.6.19-mm kernel.
>=20
> When ALSA's sysfs device creation was converted from using
> class_device_create() to device_create(), the fourth param from
> class_device_create() [dev] was simply plugged into arg 2 of
> device_create().  This causes the device symlinks under all the
> class/sound/[node] to point to nonsensical places.  Among other
> problems, this breaks HAL and all audio software that depends on HAL.
>=20

There are no device symlinks anymore, so the current behaviour seems
correct. HAL should follow the symlink, then move up in the device tree
to find a suitable parent.

Rgds
Pierre



--=_hera.drzeus.cx-11376-1169724464-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFuJQy7b8eESbyJLgRAsEuAJ9Qlmg66NBRO59pfo95lTTSTrnbqgCfRwbC
pqiWo5eXUTOVQLcNqOKiYKk=
=buKe
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-11376-1169724464-0001-2--


--===============1650911810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1650911810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1650911810==--
