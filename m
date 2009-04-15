From: Daniel T Chen <seven.steps@gmail.com>
Subject: [PATCH] Intel8x0: Add hp_only quirk for SSID
 0x1028016a (Dell Inspiron 8600)
Date: Wed, 15 Apr 2009 19:48:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0904151946510.25087@errno>
Reply-To: Daniel T Chen <seven.steps@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1643418594-1239839303=:25087"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 770C91038A8
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 01:48:25 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id k40so69926wah.16
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 16:48:24 -0700 (PDT)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1643418594-1239839303=:25087
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Subject says it all. Briefly, use hp_only for another Dell Inspiron 8600.

Thanks,
Daniel T Chen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJ5nI5e9GwFciKvaMRAqyEAKDEzBbqoTVX84Mnh3G/5NtRsy7hbACcC/8a
xoAY8903z+8x7oIB3WKoZkA=
=r3JR
-----END PGP SIGNATURE-----
--8323329-1643418594-1239839303=:25087
Content-Type: TEXT/x-diff; name=0002-Reference-Ubuntu-41015-https-launchpad.net-bugs.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.0904151948080.25087@errno>
Content-Description: 
Content-Disposition: attachment; filename=0002-Reference-Ubuntu-41015-https-launchpad.net-bugs.patch

RnJvbSAzYWE5ZWY3YmQyNzBhZDFjMzVmNDdlMGNjZDk3MmU1NGE0YWRjMGU1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGFuaWVsIFQgQ2hl
biA8c2V2ZW4uc3RlcHNAZ21haWwuY29tPg0KRGF0ZTogV2VkLCAxNSBBcHIg
MjAwOSAxOTozMzo1NiAtMDQwMA0KU3ViamVjdDogW1BBVENIXSBSZWZlcmVu
Y2U6IFVidW50dSAjNDEwMTUgKGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdz
LzQxMDE1KQ0KDQpBZGQgaHBfb25seSBxdWlyayBmb3IgU1NJRCAweDEwMjgw
MTZhIChEZWxsIEluc3Bpcm9uIDg2MDApDQoNClNpZ25lZC1vZmYtYnk6IERh
bmllbCBUIENoZW4gPHNldmVuLnN0ZXBzQGdtYWlsLmNvbT4NCi0tLQ0KIHBj
aS9pbnRlbDh4MC5jIHwgICAgNiArKysrKysNCiAxIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL3BjaS9pbnRlbDh4MC5jIGIvcGNpL2ludGVsOHgwLmMNCmluZGV4IGIz
MTgwZDAuLjgwNDJkNTMgMTAwNjQ0DQotLS0gYS9wY2kvaW50ZWw4eDAuYw0K
KysrIGIvcGNpL2ludGVsOHgwLmMNCkBAIC0xODU0LDYgKzE4NTQsMTIgQEAg
c3RhdGljIHN0cnVjdCBhYzk3X3F1aXJrIGFjOTdfcXVpcmtzW10gX19kZXZp
bml0ZGF0YSA9IHsNCiAJfSwNCiAJew0KIAkJLnN1YnZlbmRvciA9IDB4MTAy
OCwNCisJCS5zdWJkZXZpY2UgPSAweDAxNmEsDQorCQkubmFtZSA9ICJEZWxs
IEluc3Bpcm9uIDg2MDAiLAkvKiBTVEFDOTc1MC81MSAqLw0KKwkJLnR5cGUg
PSBBQzk3X1RVTkVfSFBfT05MWQ0KKwl9LA0KKwl7DQorCQkuc3VidmVuZG9y
ID0gMHgxMDI4LA0KIAkJLnN1YmRldmljZSA9IDB4MDE4NiwNCiAJCS5uYW1l
ID0gIkRlbGwgTGF0aXR1ZGUgRDgxMCIsIC8qIGNmLiBNYWxvbmUgIzQxMDE1
ICovDQogCQkudHlwZSA9IEFDOTdfVFVORV9IUF9NVVRFX0xFRA0KLS0gDQox
LjYuMC40DQoNCg==

--8323329-1643418594-1239839303=:25087
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323329-1643418594-1239839303=:25087--
