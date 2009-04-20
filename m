From: Daniel T Chen <seven.steps@gmail.com>
Subject: [PATCH] Atiixp: Add SSID for mute_led quirk (unknown
	HP model)
Date: Mon, 20 Apr 2009 07:09:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0904200706530.7662@errno>
Reply-To: Daniel T Chen <seven.steps@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-305384278-1240225766=:7662"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FB8243CC
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 13:09:28 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1797643wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2009 04:09:26 -0700 (PDT)
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

--8323329-305384278-1240225766=:7662
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Subject says it all. Briefly, use the mute_led quirk for another HP model.

Thanks,
Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJ7FfZe9GwFciKvaMRAleaAJ9mmtLUW7HgwjZCHkV1Mk4/dbV+MgCgjDEm
ZD/KsZbyDYJB4Egq+fzDXc8=
=qaDE
-----END PGP SIGNATURE-----
--8323329-305384278-1240225766=:7662
Content-Type: TEXT/x-diff; name=0001--Atiixp-Add-SSID-for-mute_led-quirk.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.0904200709110.7662@errno>
Content-Description: 
Content-Disposition: attachment; filename=0001--Atiixp-Add-SSID-for-mute_led-quirk.patch

RnJvbSBmMzM5YjBmZGJkZDA1ZDNjMDBkMWZjMTI2N2IzYzJhZTRmNmQyNDBm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGFuaWVsIFQgQ2hl
biA8c2V2ZW4uc3RlcHNAZ21haWwuY29tPg0KRGF0ZTogU2F0LCAxOCBBcHIg
MjAwOSAyMToxOTozOSAtMDQwMA0KU3ViamVjdDogW1BBVENIXSBbUEFUQ0hd
IEF0aWl4cDogQWRkIFNTSUQgZm9yIG11dGVfbGVkIHF1aXJrDQoNClJlZmVy
ZW5jZTogVWJ1bnR1ICM4NDk3MyAoaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1
Z3MvODQ5NzMpDQpSZWZlcmVuY2U6IExpbnV4ICM4MDAxIChodHRwOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9ODAwMSkNCg0KTWFr
ZSB0aGUgbXV0ZSBMRUQgZnVuY3Rpb24gcHJvcGVybHkgb24gdGhpcyB1bmtu
b3duIEhQIG1vZGVsLg0KDQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVu
IDxzZXZlbi5zdGVwc0BnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9wY2kvYXRp
aXhwLmMgfCAgICA2ICsrKysrKw0KIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2F0aWl4cC5jIGIvc291bmQvcGNpL2F0aWl4cC5jDQppbmRleCA5
Y2U4NTQ4Li43MTUxNWRkIDEwMDY0NA0KLS0tIGEvc291bmQvcGNpL2F0aWl4
cC5jDQorKysgYi9zb3VuZC9wY2kvYXRpaXhwLmMNCkBAIC0xMzkzLDYgKzEz
OTMsMTIgQEAgc3RhdGljIHN0cnVjdCBhYzk3X3F1aXJrIGFjOTdfcXVpcmtz
W10gX19kZXZpbml0ZGF0YSA9IHsNCiAJCS5uYW1lID0gIkhQIG54NjEyNSIs
DQogCQkudHlwZSA9IEFDOTdfVFVORV9NVVRFX0xFRA0KIAl9LA0KKwl7DQor
CQkuc3VidmVuZG9yID0gMHgxMDNjLA0KKwkJLnN1YmRldmljZSA9IDB4MzA5
MSwNCisJCS5uYW1lID0gInVua25vd24gSFAiLA0KKwkJLnR5cGUgPSBBQzk3
X1RVTkVfTVVURV9MRUQNCisJfSwNCiAJeyB9IC8qIHRlcm1pbmF0b3IgKi8N
CiB9Ow0KIA0KLS0gDQoxLjYuMC40DQoNCg==

--8323329-305384278-1240225766=:7662
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323329-305384278-1240225766=:7662--
