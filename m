From: Kailang <kailang@realtek.com>
Subject: Update ALC255 depop optimize
Date: Wed, 25 Apr 2018 08:17:50 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184124DD@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A184124DDRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CC222676AB
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 10:17:55 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124DDRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch was update ALC255 depop optimize.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124DDRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-update-alc255-depop.patch"
Content-Description: 0000-update-alc255-depop.patch
Content-Disposition: attachment; filename="0000-update-alc255-depop.patch";
	size=806; creation-date="Wed, 25 Apr 2018 08:11:42 GMT";
	modification-date="Wed, 25 Apr 2018 08:11:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYjhmNWUzZjRjOGFkODQ5NTU5MmRkMWJhMDlhYWE4MjMyOWEzMWU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjUgQXByIDIwMTggMTY6MDU6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIFVwZGF0ZSBBTEMyNTUgZGVwb3Agb3B0aW1pemUKCkFkZCBBTEMyNTUg
aXRzIG93biBkZXBvcCBmdW5jdGlvbnMgZm9yIGFsY19pbml0IGFuZCBhbGNfc2h1dHVwLgpBc3Np
Z24gaXQgdG8gQUxDMjU2IHVzYWdlLgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWls
YW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMjA4Njk0OS4uM2Y2NTlm
MCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTcxNjQsNiArNzE2NCw4IEBAIHN0YXRpYyBpbnQg
cGF0Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgMHgxMGVjMDIzNToK
IAljYXNlIDB4MTBlYzAyNTU6CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQgPSBBTEMyNjlfVFlQRV9B
TEMyNTU7CisJCXNwZWMtPnNodXR1cCA9IGFsYzI1Nl9zaHV0dXA7CisJCXNwZWMtPmluaXRfaG9v
ayA9IGFsYzI1Nl9pbml0OwogCQlicmVhazsKIAljYXNlIDB4MTBlYzAyMzY6CiAJY2FzZSAweDEw
ZWMwMjU2Ogo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124DDRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A184124DDRTITMBSV02realt_--
