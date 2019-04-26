From: Kailang <kailang@realtek.com>
Subject: EAPD turn on  later
Date: Fri, 26 Apr 2019 08:46:04 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D765348@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D765348RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 030A9F8961C
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 10:46:08 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765348RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

EAPD need to turn on after set pin output.
This will avoid pop noise for more machine via speaker.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765348RTITMBSVM07real_
Content-Type: application/octet-stream; name="0000-eapd-on-later.patch"
Content-Description: 0000-eapd-on-later.patch
Content-Disposition: attachment; filename="0000-eapd-on-later.patch";
	size=792; creation-date="Fri, 26 Apr 2019 08:38:49 GMT";
	modification-date="Fri, 26 Apr 2019 08:42:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNzc3ZGNjNDhhMzdjZTVkMTBlMjBhNmJmNTg3YzNjMTEwZmY0NjdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgMjYgQXByIDIwMTkgMTY6MzU6NDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEVBUEQgdHVybiBvbiBsYXRlcgoKTGV0IEVBUEQgdHVybiBvbiBhZnRl
ciBzZXQgcGluIG91dHB1dC4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0By
ZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBi
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGY1YjUxMGYxMTllZC4uMWQwZTBm
MmU2NTI2IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtODAzLDExICs4MDMsMTAgQEAgc3RhdGlj
IGludCBhbGNfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAlpZiAoc3BlYy0+aW5pdF9o
b29rKQogCQlzcGVjLT5pbml0X2hvb2soY29kZWMpOwogCisJc25kX2hkYV9nZW5faW5pdChjb2Rl
Yyk7CiAJYWxjX2ZpeF9wbGwoY29kZWMpOwogCWFsY19hdXRvX2luaXRfYW1wKGNvZGVjLCBzcGVj
LT5pbml0X2FtcCk7CiAKLQlzbmRfaGRhX2dlbl9pbml0KGNvZGVjKTsKLQogCXNuZF9oZGFfYXBw
bHlfZml4dXAoY29kZWMsIEhEQV9GSVhVUF9BQ1RfSU5JVCk7CiAKIAlyZXR1cm4gMDsK

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765348RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D765348RTITMBSVM07real_--
