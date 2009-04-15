From: Daniel T Chen <seven.steps@gmail.com>
Subject: [PATCH] Intel8x0: Remove conflicting quirk for SSID
	0x103c0934
Date: Wed, 15 Apr 2009 19:43:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0904151940220.25087@errno>
Reply-To: Daniel T Chen <seven.steps@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1631712441-1239839027=:25087"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A405B1038A8
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 01:43:48 +0200 (CEST)
Received: by qyk1 with SMTP id 1so304859qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 16:43:47 -0700 (PDT)
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

--8323329-1631712441-1239839027=:25087
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While cleaning up quirks, I noticed that there is a duplicated quirk for 
the SSID 0x103c0934. Looking back through the bug reports, I've concluded 
that there is only one necessary quirk (hp_mute_led), so this patch 
removes the conflicting one.

Thanks,
Daniel T Chen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJ5nEoe9GwFciKvaMRAqf+AJ45j7iM7XYnV+bDO9sa7fj4XjpHlQCfSSAw
mOJvx87TYvsMbGw5g/aS8Ds=
=rvle
-----END PGP SIGNATURE-----
--8323329-1631712441-1239839027=:25087
Content-Type: TEXT/x-diff; name=0001-Reference-Ubuntu-44066-https-launchpad.net-bugs.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.0904151943350.25087@errno>
Content-Description: 
Content-Disposition: attachment; filename=0001-Reference-Ubuntu-44066-https-launchpad.net-bugs.patch

RnJvbSA1MTg1MGY2ZTYzNjNkYTUwYmVmNmZmMTAzM2YwOTM3ZWE2YmNjMzZj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogRGFuaWVsIFQgQ2hl
biA8c2V2ZW4uc3RlcHNAZ21haWwuY29tPg0KRGF0ZTogV2VkLCAxNSBBcHIg
MjAwOSAxOToyMjozOCAtMDQwMA0KU3ViamVjdDogW1BBVENIXSBSZWZlcmVu
Y2U6IFVidW50dSAjNDQwNjYgKGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdz
LzQ0MDY2KQ0KDQpSZW1vdmUgY29uZmxpY3RpbmcgcXVpcmsgZm9yIFNTSUQg
MHgxMDNjMDkzNA0KDQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxz
ZXZlbi5zdGVwc0BnbWFpbC5jb20+DQotLS0NCiBwY2kvaW50ZWw4eDAuYyB8
ICAgIDYgLS0tLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9wY2kvaW50ZWw4
eDAuYyBiL3BjaS9pbnRlbDh4MC5jDQppbmRleCA1ZGNlZDViLi5iMzE4MGQw
IDEwMDY0NA0KLS0tIGEvcGNpL2ludGVsOHgwLmMNCisrKyBiL3BjaS9pbnRl
bDh4MC5jDQpAQCAtMTg5NiwxMiArMTg5Niw2IEBAIHN0YXRpYyBzdHJ1Y3Qg
YWM5N19xdWlyayBhYzk3X3F1aXJrc1tdIF9fZGV2aW5pdGRhdGEgPSB7DQog
CX0sDQogCXsNCiAJCS5zdWJ2ZW5kb3IgPSAweDEwM2MsDQotCQkuc3ViZGV2
aWNlID0gMHgwOTM0LA0KLQkJLm5hbWUgPSAiSFAgbng4MjIwIiwNCi0JCS50
eXBlID0gQUM5N19UVU5FX01VVEVfTEVEDQotCX0sDQotCXsNCi0JCS5zdWJ2
ZW5kb3IgPSAweDEwM2MsDQogCQkuc3ViZGV2aWNlID0gMHgxMjlkLA0KIAkJ
Lm5hbWUgPSAiSFAgeHc4MDAwIiwNCiAJCS50eXBlID0gQUM5N19UVU5FX0hQ
X09OTFkNCi0tIA0KMS42LjAuNA0KDQo=

--8323329-1631712441-1239839027=:25087
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323329-1631712441-1239839027=:25087--
