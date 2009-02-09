From: Mackenzie Morgan <macoafi@gmail.com>
Subject: Patch for  Asus z37e (1043:8284)
Date: Mon, 09 Feb 2009 12:21:19 -0500
Message-ID: <1234200079.8368.86.camel@betty>
Reply-To: macoafi@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0603221326702389847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f16.google.com (mail-ew0-f16.google.com
	[209.85.219.16])
	by alsa0.perex.cz (Postfix) with ESMTP id EECAE103813
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 18:21:23 +0100 (CET)
Received: by ewy9 with SMTP id 9so1848422ewy.8
	for <alsa-devel@alsa-project.org>; Mon, 09 Feb 2009 09:21:23 -0800 (PST)
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


--===============0603221326702389847==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QOD2OUJcJy90pdHNAjVL"


--=-QOD2OUJcJy90pdHNAjVL
Content-Type: multipart/mixed; boundary="=-0S1wzJSdrMfuegk2fIlO"


--=-0S1wzJSdrMfuegk2fIlO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

A bug was reported in Ubuntu a while ago about Asus Z37E not having
audible sound after resuming from suspend/hibernate[1].  A git changeset
signed off by Daniel T. Chen and myself [2] was accepted and is in the
last 2 Ubuntu releases along with the development one. =20

I filed a bug [3] in ALSA with a patch attached, then realized that the
surrounding lines wouldn't match up in trunk so updated the patch and
put it in the bugtracker and tried to email it here.  The email didn't
pass moderation, but now I'm trying again as a subscriber.

It's just an addition to the quirks table for patch_realtek.c to set
2043:8284 to use 6stack-dig.

I'm trying to get this accepted here so that Ubuntu's not the only
distro where sound works consistently across suspend/resume cycles.

[1] https://bugs.edge.launchpad.net/ubuntu/+source/linux/+bug/25896
[2]
http://launchpadlibrarian.net/17053575/0001-Add-quirk-for-ASUS-Z37E-to-make=
-sound-audible-afte.patch
[3]
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D4282

--=20
Mackenzie Morgan
http://ubuntulinuxtipstricks.blogspot.com
apt-get moo

--=-0S1wzJSdrMfuegk2fIlO
Content-Disposition: attachment; filename="z37e.patch"
Content-Type: text/x-patch; name="z37e.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIv
c291bmQvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMNCmluZGV4IDAwZjkwN2Eu
LjllMGFmZWIgMTAwNjQ0DQotLS0gYS9zb3VuZC9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYw0KKysrIGIvc291bmQvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMN
CkBAIC03NjA1LDYgKzc2MDUsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgz
X2NmZ190YmxbXSA9IHsNCiAgICAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MmE2MCwgIkhQIEx1
Y2tub3ciLCBBTEM4ODhfM1NUX0hQKSwNCiAgICAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MmE2
MSwgIkhQIE5ldHRsZSIsIEFMQzg4OF82U1RfSFApLA0KICAgICBTTkRfUENJX1FVSVJLKDB4MTA0
MywgMHg4MjQ5LCAiQXN1cyBNMkEtVk0gSERNSSIsIEFMQzg4M18zU1RfNmNoX0RJRyksDQorIFNO
RF9QQ0lfUVVJUksoMHgxMDQzLCAweDgyODQsICJBc3VzIFozN0UiLCBBTEM4ODNfNlNUX0RJRyks
DQoJIFNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgyZmUsICJBc3VzIFA1US1FTSBIRE1JIiwgQUxD
MTIwMF9BU1VTX1A1USksDQoJIFNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgzNWYsICJBc3VzIEVl
ZSAxNjAxIiwgQUxDODg4X0FTVVNfRUVFMTYwMSksDQogICAgIFNORF9QQ0lfUVVJUksoMHgxMDVi
LCAweDBjZTgsICJGb3hjb25uIFAzNUFYLVMiLCBBTEM4ODNfNlNUX0RJRyksDQo=


--=-0S1wzJSdrMfuegk2fIlO--

--=-QOD2OUJcJy90pdHNAjVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmQZgwACgkQojm3DbyNMmmRqQCcDRWl4gQ29ZAm7Ec0k1pyH/6Z
XZgAmwfJ/E2b8DDjYbt8C6myrY54paol
=9Ols
-----END PGP SIGNATURE-----

--=-QOD2OUJcJy90pdHNAjVL--


--===============0603221326702389847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0603221326702389847==--
