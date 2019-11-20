Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF258C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:58:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C55120898
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NuBWjt8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C55120898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tarent.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DB191735;
	Thu, 21 Nov 2019 08:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DB191735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574323108;
	bh=wHxe3IHH27vrJcrXTdV9s04UuHWIRqPPW3nQr+I5Iv8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NuBWjt8ufUwr89EknwXsTDFlOrpRMUHg8AGrYNuIiXb/DqZsV5R1GjStwqTNfi5b9
	 ymq5ORA/bb+lywiJY/qOgpzguS/VI6Vg/wVohZvl9noq0/U6L233rp74/AFlo5Xecw
	 wa9rUADu5DMrN3ufstgkn8E94xPFa2L64CbcrvRY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6D01F80145;
	Thu, 21 Nov 2019 08:57:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0473F8013D; Wed, 20 Nov 2019 21:51:18 +0100 (CET)
Received: from mail.lixid.net (lixid.tarent.de [193.107.123.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3057FF800F0
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 21:51:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3057FF800F0
Received: from localhost (localhost [127.0.0.1])
 by mail.lixid.net (MTA) with ESMTP id 63894140763
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 21:51:15 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
 by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
 id fBJkDUqMJAcK for <alsa-devel@alsa-project.org>;
 Wed, 20 Nov 2019 21:51:15 +0100 (CET)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lixid.net (MTA) with ESMTPS id 3E485140604
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 21:51:14 +0100 (CET)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
 id 2F2E522075A; Wed, 20 Nov 2019 21:51:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by tglase.lan.tarent.de (Postfix) with ESMTP id 157FA22074B
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 21:51:14 +0100 (CET)
Date: Wed, 20 Nov 2019 21:51:14 +0100 (CET)
From: Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To: alsa-devel@alsa-project.org
Message-ID: <alpine.DEB.2.21.1911202147000.2011@tglase.lan.tarent.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="447507459-1401816665-1574283074=:2011"
X-Mailman-Approved-At: Thu, 21 Nov 2019 08:57:36 +0100
Subject: [alsa-devel] [PATCH] fix segfault on x32,
	64-bit time_t-related format strings
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--447507459-1401816665-1574283074=:2011
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi everyone,

here are two patches I=E2=80=99ve been rebasing with each new upload
of alsa-lib to Debian to make things work for my x32 desktop.

The small one fixes it misdetecting x32 as amd64, which leads
to an immediate segfault.

The other one fixes issues related to printing time_t values
on platforms where time_t is 64 bit wide and long 32 bit wide
(various BSDs and all new 32-bit and *64ilp32 Linux platforms).

The Debian packager of alsa-lib hasn=E2=80=99t found it necessary to
forward them upstream, so I=E2=80=99m doing it with this. I hope they
can be included in the next releases. The patches were last
updated for 1.1.8 although I need to update them to 1.1.9 which
was recently introduced to Debian=E2=80=A6 usually they apply still.

Thanks in advance,
//mirabilos
--=20
tarent solutions GmbH
Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-235
HRB 5168 (AG Bonn) =E2=80=A2 USt-ID (VAT): DE122264941
Gesch=C3=A4ftsf=C3=BChrer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Ale=
xander Steeg

**********

Mit der tarent Academy bieten wir auch Trainings und Schulungen in den
Bereichen Softwareentwicklung, Agiles Arbeiten und Zukunftstechnologien an.

Besuchen Sie uns auf www.tarent.de/academy. Wir freuen uns auf Ihren Kontak=
t.

**********
--447507459-1401816665-1574283074=:2011
Content-Type: text/x-diff; name=0009-fix-format-strings.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1911202151140.2011@tglase.lan.tarent.de>
Content-Description: 
Content-Disposition: attachment; filename=0009-fix-format-strings.patch

IyBEUDogZml4IGxvbmcgdnMuIGxvbmcgbG9uZyBjb25mdXNpb24gd2hlbiB0
aGVyZSBpcyBhIDY0LWJpdCB0aW1lX3QNCiMgRFA6IG9uIGEgMzItYml0IGxv
bmcgc3lzdGVtLCBzdWNoIGFzIGFsbCBuZXdlciAzMi1iaXQgYXJjaGl0ZWN0
dXJlcw0KDQotLS0gYS9zcmMvcGNtL3BjbS5jDQorKysgYi9zcmMvcGNtL3Bj
bS5jDQpAQCAtMjI1NywxMSArMjI1NywxMSBAQCBpbnQgc25kX3BjbV9zdGF0
dXNfZHVtcChzbmRfcGNtX3N0YXR1c190DQogew0KIAlhc3NlcnQoc3RhdHVz
KTsNCiAJc25kX291dHB1dF9wcmludGYob3V0LCAiICBzdGF0ZSAgICAgICA6
ICVzXG4iLCBzbmRfcGNtX3N0YXRlX25hbWUoKHNuZF9wY21fc3RhdGVfdCkg
c3RhdHVzLT5zdGF0ZSkpOw0KLQlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIg
IHRyaWdnZXJfdGltZTogJWxkLiUwNmxkXG4iLA0KLQkJCSAgc3RhdHVzLT50
cmlnZ2VyX3RzdGFtcC50dl9zZWMsDQotCQkJICBzdGF0dXMtPnRyaWdnZXJf
dHN0YW1wLnR2X25zZWMgLyAxMDAwKTsNCi0Jc25kX291dHB1dF9wcmludGYo
b3V0LCAiICB0c3RhbXAgICAgICA6ICVsZC4lMDZsZFxuIiwNCi0JCXN0YXR1
cy0+dHN0YW1wLnR2X3NlYywgc3RhdHVzLT50c3RhbXAudHZfbnNlYyAvIDEw
MDApOw0KKwlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIgIHRyaWdnZXJfdGlt
ZTogJWxsZC4lMDZsZFxuIiwNCisJCQkgIChsb25nIGxvbmcpc3RhdHVzLT50
cmlnZ2VyX3RzdGFtcC50dl9zZWMsDQorCQkJICAobG9uZylzdGF0dXMtPnRy
aWdnZXJfdHN0YW1wLnR2X25zZWMgLyAxMDAwTCk7DQorCXNuZF9vdXRwdXRf
cHJpbnRmKG91dCwgIiAgdHN0YW1wICAgICAgOiAlbGxkLiUwNmxkXG4iLA0K
KwkJKGxvbmcgbG9uZylzdGF0dXMtPnRzdGFtcC50dl9zZWMsIChsb25nKXN0
YXR1cy0+dHN0YW1wLnR2X25zZWMgLyAxMDAwTCk7DQogCXNuZF9vdXRwdXRf
cHJpbnRmKG91dCwgIiAgZGVsYXkgICAgICAgOiAlbGRcbiIsIChsb25nKXN0
YXR1cy0+ZGVsYXkpOw0KIAlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIgIGF2
YWlsICAgICAgIDogJWxkXG4iLCAobG9uZylzdGF0dXMtPmF2YWlsKTsNCiAJ
c25kX291dHB1dF9wcmludGYob3V0LCAiICBhdmFpbF9tYXggICA6ICVsZFxu
IiwgKGxvbmcpc3RhdHVzLT5hdmFpbF9tYXgpOw0KLS0tIGEvdGVzdC9sYXRl
bmN5LmMNCisrKyBiL3Rlc3QvbGF0ZW5jeS5jDQpAQCAtMzI1LDEyICszMjUs
MTIgQEAgdm9pZCBzZXRzY2hlZHVsZXIodm9pZCkNCiAJcHJpbnRmKCIhISFT
Y2hlZHVsZXIgc2V0IHRvIFJvdW5kIFJvYmluIHdpdGggcHJpb3JpdHkgJWkg
RkFJTEVEISEhXG4iLCBzY2hlZF9wYXJhbS5zY2hlZF9wcmlvcml0eSk7DQog
fQ0KIA0KLWxvbmcgdGltZWRpZmYoc25kX3RpbWVzdGFtcF90IHQxLCBzbmRf
dGltZXN0YW1wX3QgdDIpDQorbG9uZyBsb25nIHRpbWVkaWZmKHNuZF90aW1l
c3RhbXBfdCB0MSwgc25kX3RpbWVzdGFtcF90IHQyKQ0KIHsNCi0Jc2lnbmVk
IGxvbmcgbDsNCisJc2lnbmVkIGxvbmcgbG9uZyBsOw0KIA0KIAl0MS50dl9z
ZWMgLT0gdDIudHZfc2VjOw0KLQlsID0gKHNpZ25lZCBsb25nKSB0MS50dl91
c2VjIC0gKHNpZ25lZCBsb25nKSB0Mi50dl91c2VjOw0KKwlsID0gKHNpZ25l
ZCBsb25nIGxvbmcpIHQxLnR2X3VzZWMgLSAoc2lnbmVkIGxvbmcgbG9uZykg
dDIudHZfdXNlYzsNCiAJaWYgKGwgPCAwKSB7DQogCQl0MS50dl9zZWMtLTsN
CiAJCWwgPSAxMDAwMDAwICsgbDsNCkBAIC02ODIsMTAgKzY4MiwxMCBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KIAkJc25kX3BjbV9u
b25ibG9jayhwaGFuZGxlLCAhYmxvY2sgPyAxIDogMCk7DQogCQlpZiAob2sp
IHsNCiAjaWYgMQ0KLQkJCXByaW50ZigiUGxheWJhY2sgdGltZSA9ICVsaS4l
aSwgUmVjb3JkIHRpbWUgPSAlbGkuJWksIGRpZmYgPSAlbGlcbiIsDQotCQkJ
ICAgICAgIHBfdHN0YW1wLnR2X3NlYywNCisJCQlwcmludGYoIlBsYXliYWNr
IHRpbWUgPSAlbGxpLiVpLCBSZWNvcmQgdGltZSA9ICVsbGkuJWksIGRpZmYg
PSAlbGxpXG4iLA0KKwkJCSAgICAgICAobG9uZyBsb25nKXBfdHN0YW1wLnR2
X3NlYywNCiAJCQkgICAgICAgKGludClwX3RzdGFtcC50dl91c2VjLA0KLQkJ
CSAgICAgICBjX3RzdGFtcC50dl9zZWMsDQorCQkJICAgICAgIChsb25nIGxv
bmcpY190c3RhbXAudHZfc2VjLA0KIAkJCSAgICAgICAoaW50KWNfdHN0YW1w
LnR2X3VzZWMsDQogCQkJICAgICAgIHRpbWVkaWZmKHBfdHN0YW1wLCBjX3Rz
dGFtcCkpOw0KICNlbmRpZg0KLS0tIGEvdGVzdC9xdWV1ZV90aW1lci5jDQor
KysgYi90ZXN0L3F1ZXVlX3RpbWVyLmMNCkBAIC05OSwxMSArOTksMTEgQEAg
bWFpbihpbnQgYXJnYyBBVFRSSUJVVEVfVU5VU0VELCBjaGFyICoqYQ0KIAlu
b3JtYWxpemUoJmRpZmZkaWZmKTsNCiAJcHJldmRpZmYgPSBkaWZmOw0KIA0K
LQlmcHJpbnRmKHN0ZGVyciwgIiByZWFsIHRpbWU6ICUxMmxkIHNlYyAlOGxk
IHVzZWNcbnF1ZXVlIHRpbWU6ICUxMmxkIHNlYyAlOGxkIHVzZWNcbiAgICAg
IGRpZmY6ICUxMmxkIHNlYyAlOGxkIHVzZWNcbiAgZGlmZmRpZmY6ICUxMmxk
IHNlYyAlOGxkIHVzZWNcbiIsDQotCQl0di50dl9zZWMsIHR2LnR2X3VzZWMs
DQotCQkobG9uZylydGltZS0+dHZfc2VjLCAobG9uZylydGltZS0+dHZfbnNl
YyAvIDEwMDAsDQotCQlkaWZmLnR2X3NlYywgZGlmZi50dl91c2VjLA0KLQkJ
KGxvbmcpZGlmZmRpZmYudHZfc2VjLCAobG9uZylkaWZmZGlmZi50dl91c2Vj
KTsNCisJZnByaW50ZihzdGRlcnIsICIgcmVhbCB0aW1lOiAlMTJsbGQgc2Vj
ICU4bGQgdXNlY1xucXVldWUgdGltZTogJTEybGxkIHNlYyAlOGxkIHVzZWNc
biAgICAgIGRpZmY6ICUxMmxsZCBzZWMgJThsZCB1c2VjXG4gIGRpZmZkaWZm
OiAlMTJsbGQgc2VjICU4bGQgdXNlY1xuIiwNCisJCShsb25nIGxvbmcpdHYu
dHZfc2VjLCAobG9uZyl0di50dl91c2VjLA0KKwkJKGxvbmcgbG9uZylydGlt
ZS0+dHZfc2VjLCAobG9uZylydGltZS0+dHZfbnNlYyAvIDEwMDAsDQorCQko
bG9uZyBsb25nKWRpZmYudHZfc2VjLCAobG9uZylkaWZmLnR2X3VzZWMsDQor
CQkobG9uZyBsb25nKWRpZmZkaWZmLnR2X3NlYywgKGxvbmcpZGlmZmRpZmYu
dHZfdXNlYyk7DQogDQogCWlmIChkaWZmZGlmZi50dl91c2VjID4gIDUwMDAg
fHwNCiAJICAgIGRpZmZkaWZmLnR2X3VzZWMgPCAtNTAwMCkgew0K

--447507459-1401816665-1574283074=:2011
Content-Type: text/x-diff; name=0011-distinguish-x32-from-amd64.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1911202151141.2011@tglase.lan.tarent.de>
Content-Description: 
Content-Disposition: attachment; filename=0011-distinguish-x32-from-amd64.patch

IyBEUDogZml4IHNlZ21lbnRhdGlvbiBmYXVsdCBjb21pbmcgZnJvbSB0aGlz
IHVzaW5nIGFtZDY0IGFzc2VtYmx5IGNvZGUNCiMgRFA6IG9uIHgzMiBzeXN0
ZW1zDQoNCi0tLSBhL3NyYy9wY20vcGNtX2RtaXguYw0KKysrIGIvc3JjL3Bj
bS9wY21fZG1peC5jDQpAQCAtMTQ1LDcgKzE0NSw3IEBAIHN0YXRpYyB2b2lk
IGRtaXhfc2VydmVyX2ZyZWUoc25kX3BjbV9kaXINCiAjaW5jbHVkZSAicGNt
X2RtaXhfZ2VuZXJpYy5jIg0KICNpZiBkZWZpbmVkKF9faTM4Nl9fKQ0KICNp
bmNsdWRlICJwY21fZG1peF9pMzg2LmMiDQotI2VsaWYgZGVmaW5lZChfX3g4
Nl82NF9fKQ0KKyNlbGlmIGRlZmluZWQoX194ODZfNjRfXykgJiYgIWRlZmlu
ZWQoX19JTFAzMl9fKQ0KICNpbmNsdWRlICJwY21fZG1peF94ODZfNjQuYyIN
CiAjZWxzZQ0KICNpZm5kZWYgRE9DX0hJRERFTg0K

--447507459-1401816665-1574283074=:2011
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--447507459-1401816665-1574283074=:2011--
