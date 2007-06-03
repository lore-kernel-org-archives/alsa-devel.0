From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Subject: [PATCH] Add support for another X-Fi Extreme Audio
	(really SB Live	24bit)
Date: Sat, 02 Jun 2007 22:26:06 -0400
Message-ID: <1180837566.8636.1.camel@Box.ncat.edu>
Reply-To: crimsun@ubuntu.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8180140598847096114=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 91005243F8
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 04:26:13 +0200 (CEST)
Received: from ns1.mcdownloads.com (localhost [127.0.0.1])
	by ns1.mcdownloads.com (Postfix) with ESMTP id 87CA2284860AB
	for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2007 19:26:10 -0700 (PDT)
Received: from [127.0.0.1] (adhd.irule.net [66.81.0.197])
	(Authenticated sender: crimsun@fungus.sh.nu)
	by ns1.mcdownloads.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2007 19:26:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8180140598847096114==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vHaVhdEuwnn73K7rSnoC"


--=-vHaVhdEuwnn73K7rSnoC
Content-Type: multipart/mixed; boundary="=-grB6uvnXHQAfIUwT2OpL"


--=-grB6uvnXHQAfIUwT2OpL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Attached please find an hg changeset against current alsa-kernel tip.

Thanks,
Daniel Chen

--=-grB6uvnXHQAfIUwT2OpL
Content-Disposition: attachment; filename=new.diff
Content-Type: text/x-patch; name=new.diff; charset=UTF-8
Content-Transfer-Encoding: base64

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBjcmltc3VuQEJveC5uY2F0LmVkdQ0KIyBEYXRl
IDExODA4MzcwNTUgMTQ0MDANCiMgTm9kZSBJRCBmZmIxODgyMTBiNDlhMzdhODFkYWI2YjA4YTMw
OGU4OTU0NjFjMTBmDQojIFBhcmVudCAgZDI2NjJmMGQ0M2IxMTAyZmYzMDM1ODMyOTk1ZDYxMTNm
MTEyNGZlOA0KW1BBVENIXSBBZGQgc3VwcG9ydCBmb3IgYW5vdGhlciBYLUZpIEV4dHJlbWUgQXVk
aW8gKHJlYWxseSBTQiBMaXZlIDI0Yml0KQ0KDQpBZGQgaW5mbyBmb3IgYW5vdGhlciBYLUZpIEV4
dHJlbWUgQXVkaW8gbW9kZWwuDQoNClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1z
dW5AdWJ1bnR1LmNvbT4NCg0KZGlmZiAtciBkMjY2MmYwZDQzYjEgLXIgZmZiMTg4MjEwYjQ5IHBj
aS9jYTAxMDYvY2EwMTA2X21haW4uYw0KLS0tIGEvcGNpL2NhMDEwNi9jYTAxMDZfbWFpbi5jCVRo
dSBNYXkgMzEgMDk6MDk6MjAgMjAwNyArMDIwMA0KKysrIGIvcGNpL2NhMDEwNi9jYTAxMDZfbWFp
bi5jCVNhdCBKdW4gMDIgMjI6MTc6MzUgMjAwNyAtMDQwMA0KQEAgLTE4Niw2ICsxODYsMTQgQEAg
c3RhdGljIHN0cnVjdCBzbmRfY2EwMTA2X2RldGFpbHMgY2EwMTA2Xw0KIAkgICAubmFtZSAgID0g
IlgtRmkgRXh0cmVtZSBBdWRpbyBbU0IwNzkwXSIsDQogCSAgIC5ncGlvX3R5cGUgPSAxLA0KIAkg
ICAuaTJjX2FkYyA9IDEgfSAsDQorCSAvKiBBbm90aGVyIFgtRmkgRXh0cmVtZSBBdWRpbyBbU0Iw
NzkwXSwgdmVyaWZpZWQgaW4gI2Fsc2EvRnJlZW5vZGUNCisJICAqIG9uIFNhdCwgSnVuIDIsIDIw
MDcgYnkgQW5kZXJzIEp1ZWwgSmVuc2VuIGFuZCBQZXRlciBKb2hhbg0KKwkgICogU29lcmVuc2Vu
LiAgTm9ybWFsIFNCIExpdmUgMjRiaXQuDQorCSAgKi8NCisJIHsgLnNlcmlhbCA9IDB4MTAxMzEx
MDIsDQorCSAgIC5uYW1lICAgPSAiWC1GaSBFeHRyZW1lIEF1ZGlvIFtTQjA3OTBdIiwNCisJICAg
LmdwaW9fdHlwZSA9IDEsDQorCSAgIC5pMmNfYWRjID0gMSB9ICwNCiAJIC8qIE5ldyBEZWxsIFNv
dW5kIEJsYXN0ZXIgTGl2ZSEgNy4xIDI0Yml0LiBUaGlzIGRvZXMgbm90IGhhdmUgYW4gQUM5Ny4g
ICovDQogCSAvKiBBdWRpZ3lMU1tTQjAzMTBdICovDQogCSB7IC5zZXJpYWwgPSAweDEwMDIxMTAy
LA0K


--=-grB6uvnXHQAfIUwT2OpL--

--=-vHaVhdEuwnn73K7rSnoC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYia+e9GwFciKvaMRAhcPAKCyCLbnC/ONHD3ucx/gLbBxCvJcbACfVHrU
L56mfS+dowSuzTqp8H12ACM=
=7NHn
-----END PGP SIGNATURE-----

--=-vHaVhdEuwnn73K7rSnoC--

--===============8180140598847096114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8180140598847096114==--
