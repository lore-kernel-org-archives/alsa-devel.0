From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: arecord cannot interrupt streaming via CTRL-C when
 using voc_pcm_wirte()
Date: Mon, 10 Jul 2017 07:47:43 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D76845AF71@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_B0FB33DC1499054591F62C0EF1E013D76845AF71HI2EXCH01aditjv_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 340F626648D
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 09:47:46 +0200 (CEST)
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0FA343C017F
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 09:47:45 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zwUmFhvK1fWL for <alsa-devel@alsa-project.org>;
 Mon, 10 Jul 2017 09:47:44 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 710743C001F
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 09:47:44 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_B0FB33DC1499054591F62C0EF1E013D76845AF71HI2EXCH01aditjv_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

please merge following patch:


>From fb58aa47b8715924667a0a4383ce9a3615378413 Mon Sep 17 00:00:00 2001
From: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Date: Mon, 19 Dec 2016 14:04:39 +0530
Subject: alsa-utils: interrupt streaming via signal in voc_pcm_write

arecord (alsa-utils v1.1.2) cannot interrupt streaming
via CTRL-C. Fixed the issue by properly handling 'in_aborting'
flag in appropriate functions.

Signed-off-by: Anant Agrawal <Anant_Agrawal@mentor.com>
Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 2da7dda..cdaa1a8 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2161,7 +2161,7 @@ static ssize_t voc_pcm_write(u_char *data, size_t cou=
nt)
        ssize_t result =3D count, r;
        size_t size;

-       while (count > 0) {
+       while (count > 0 && !in_aborting) {
                size =3D count;
                if (size > chunk_bytes - buffer_pos)
                        size =3D chunk_bytes - buffer_pos;
--
2.7.4



Best regards

Timo Wischer

Advanced Driver Information Technology GmbH
Software Group I (ADITG/ESB)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6938
Fax +49 5121 49 6999
twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi

--_002_B0FB33DC1499054591F62C0EF1E013D76845AF71HI2EXCH01aditjv_
Content-Type: text/x-patch;
	name="0001-alsa-utils-interrupt-streaming-via-signal.patch"
Content-Description: 0001-alsa-utils-interrupt-streaming-via-signal.patch
Content-Disposition: attachment;
	filename="0001-alsa-utils-interrupt-streaming-via-signal.patch"; size=1107;
	creation-date="Mon, 10 Jul 2017 07:43:17 GMT";
	modification-date="Mon, 10 Jul 2017 07:43:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYjU4YWE0N2I4NzE1OTI0NjY3YTBhNDM4M2NlOWEzNjE1Mzc4NDEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmlrYW50aCBLcmlzaG5ha2FyIDxTcmlrYW50aF9LcmlzaG5h
a2FyQG1lbnRvci5jb20+CkRhdGU6IE1vbiwgMTkgRGVjIDIwMTYgMTQ6MDQ6MzkgKzA1MzAKU3Vi
amVjdDogYWxzYS11dGlsczogaW50ZXJydXB0IHN0cmVhbWluZyB2aWEgc2lnbmFsIGluIHZvY19w
Y21fd3JpdGUKCmFwbGF5L2FyZWNvcmQgKGFsc2EtdXRpbHMgdjEuMS4yKSBjYW5ub3QgaW50ZXJy
dXB0IHN0cmVhbWluZwp2aWEgQ1RSTC1DLiBGaXhlZCB0aGUgaXNzdWUgYnkgcHJvcGVybHkgaGFu
ZGxpbmcgJ2luX2Fib3J0aW5nJwpmbGFnIGluIGFwcHJvcHJpYXRlIGZ1bmN0aW9ucy4KClNpZ25l
ZC1vZmYtYnk6IEFuYW50IEFncmF3YWwgPEFuYW50X0FncmF3YWxAbWVudG9yLmNvbT4KU2lnbmVk
LW9mZi1ieTogTWlraGFpbCBEdXJuZXYgPG1pa2hhaWxfZHVybmV2QG1lbnRvci5jb20+ClNpZ25l
ZC1vZmYtYnk6IFNyaWthbnRoIEtyaXNobmFrYXIgPFNyaWthbnRoX0tyaXNobmFrYXJAbWVudG9y
LmNvbT4KU2lnbmVkLW9mZi1ieTogVGltbyBXaXNjaGVyIDx0d2lzY2hlckBkZS5hZGl0LWp2LmNv
bT4KLS0tCiBhcGxheS9hcGxheS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXBsYXkvYXBsYXkuYyBiL2FwbGF5L2Fw
bGF5LmMKaW5kZXggMmRhN2RkYS4uY2RhYTFhOCAxMDA2NDQKLS0tIGEvYXBsYXkvYXBsYXkuYwor
KysgYi9hcGxheS9hcGxheS5jCkBAIC0yMTYxLDcgKzIxNjEsNyBAQCBzdGF0aWMgc3NpemVfdCB2
b2NfcGNtX3dyaXRlKHVfY2hhciAqZGF0YSwgc2l6ZV90IGNvdW50KQogCXNzaXplX3QgcmVzdWx0
ID0gY291bnQsIHI7CiAJc2l6ZV90IHNpemU7CiAKLQl3aGlsZSAoY291bnQgPiAwKSB7CisJd2hp
bGUgKGNvdW50ID4gMCAmJiAhaW5fYWJvcnRpbmcpIHsKIAkJc2l6ZSA9IGNvdW50OwogCQlpZiAo
c2l6ZSA+IGNodW5rX2J5dGVzIC0gYnVmZmVyX3BvcykKIAkJCXNpemUgPSBjaHVua19ieXRlcyAt
IGJ1ZmZlcl9wb3M7Ci0tIAoyLjcuNAoK

--_002_B0FB33DC1499054591F62C0EF1E013D76845AF71HI2EXCH01aditjv_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_B0FB33DC1499054591F62C0EF1E013D76845AF71HI2EXCH01aditjv_--
