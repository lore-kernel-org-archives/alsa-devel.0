From: Kailang <kailang@realtek.com>
Subject: Re: ALC700 headphone no sound issue
Date: Fri, 7 Dec 2018 07:19:56 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1842026C@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1842007A@RTITMBSV02.realtek.com.tw>
 <s5ho9a0uwu3.wl-tiwai@suse.de>	<s5hlg54uwmq.wl-tiwai@suse.de>
 <s5hk1kouwgd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1842026CRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 33B7C267CE1
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 08:20:02 +0100 (CET)
In-Reply-To: <s5hk1kouwgd.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1842026CRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

I regenerate the patch as attach.
Thanks.

BR,
Kailang

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Wednesday, December 5, 2018 5:58 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: ALC700 headphone no sound issue

On Wed, 05 Dec 2018 10:54:21 +0100,
Takashi Iwai wrote:
>=20
> On Wed, 05 Dec 2018 10:49:56 +0100,
> Takashi Iwai wrote:
> >=20
> > On Wed, 05 Dec 2018 09:18:52 +0100,
> > Kailang wrote:
> > >=20
> > > Hi Takashi,
> > >=20
> > > In Intel ENG board with ALC700. It had headphone no sound issue.
> > > If it plugged headphone or headset into the jack, then do the reboot,=
 it will have a chance to cause headphone no sound.
> > > It just need to run the headphone mode procedure after boot time.
> > > The issue will be fixed.
> > > It also suitable for ALC234 ALC274 and ALC294.
> >=20
> > Does this correspond to the HDA_FIXUP_ACT_INIT part of the patch?
>=20
> Bah, scratch that, I looked into a wrong patch (what you've sent=20
> before).  Now checking the right one.

OK, now reviewed.

The change looks mostly OK, but a couple of things:

- hp_pin is not guaranteed to be present;
  it should check the case of hp_pin=3D0, too

- Please give some comment to the function, otherwise it's really
  mystery without answer.
  You can just put the text in the patch description there.


Could you fix these and resubmit?  Thanks!


Takashi

------Please consider the environment before printing this e-mail.

--_002_6FAB7C47BCF00940BB0999A99BE3547A1842026CRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0002-intel-alc700-hp-issue.patch"
Content-Description: 0002-intel-alc700-hp-issue.patch
Content-Disposition: attachment;
	filename="0002-intel-alc700-hp-issue.patch"; size=2477;
	creation-date="Fri, 07 Dec 2018 07:17:25 GMT";
	modification-date="Fri, 07 Dec 2018 07:16:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMmRhZmU2NDVlZDVlYTgzYjgwNzUwNWYwNWViZmFlNDdlYTBlMzg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IEZyaSwgNyBEZWMgMjAxOCAxNToxNDo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gRml4ZWQgaGVhZHBob25lIGlzc3VlIGZvciBBTEM3MDAKCklmIGl0IHBs
dWdnZWQgaGVhZHBob25lIG9yIGhlYWRzZXQgaW50byB0aGUgamFjaywgdGhlbgpkbyB0aGUgcmVi
b290LCBpdCB3aWxsIGhhdmUgYSBjaGFuY2UgdG8gY2F1c2UgaGVhZHBob25lIG5vIHNvdW5kLgpJ
dCBqdXN0IG5lZWQgdG8gcnVuIHRoZSBoZWFkcGhvbmUgbW9kZSBwcm9jZWR1cmUgYWZ0ZXIgYm9v
dCB0aW1lLgpUaGUgaXNzdWUgd2lsbCBiZSBmaXhlZC4KSXQgYWxzbyBzdWl0YWJsZSBmb3IgQUxD
MjM0IEFMQzI3NCBhbmQgQUxDMjk0LgoKU2lnbmVkLW9mZi1ieTogS2FpbGFuZyBZYW5nIDxrYWls
YW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRl
ay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggYmI0MDYyNC4uODkzMzQ0
MSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTcyMjQsNiArNzIyNCwzNyBAQCBzdGF0aWMgdm9p
ZCBhbGMyNjlfZmlsbF9jb2VmKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWFsY191cGRhdGVf
Y29lZl9pZHgoY29kZWMsIDB4NCwgMCwgMTw8MTEpOwogfQogCitzdGF0aWMgdm9pZCBhbGMyOTRf
aHBfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKK3sKKwlzdHJ1Y3QgYWxjX3NwZWMgKnNw
ZWMgPSBjb2RlYy0+c3BlYzsKKwloZGFfbmlkX3QgaHBfcGluID0gc3BlYy0+Z2VuLmF1dG9jZmcu
aHBfcGluc1swXTsKKwlpbnQgaSwgdmFsOworCisJaWYgKCFocF9waW4pCisJCXJldHVybjsKKwor
CXNuZF9oZGFfY29kZWNfd3JpdGUoY29kZWMsIGhwX3BpbiwgMCwKKwkJCSAgICBBQ19WRVJCX1NF
VF9BTVBfR0FJTl9NVVRFLCBBTVBfT1VUX01VVEUpOworCisJbXNsZWVwKDEwMCk7CisKKwlzbmRf
aGRhX2NvZGVjX3dyaXRlKGNvZGVjLCBocF9waW4sIDAsCisJCQkgICAgQUNfVkVSQl9TRVRfUElO
X1dJREdFVF9DT05UUk9MLCAweDApOworCisJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg2
ZiwgMHgwMDBmLCAwKTsvKiBTZXQgSFAgZGVwb3AgdG8gbWFudWFsIG1vZGUgKi8KKwlhbGNfdXBk
YXRlX2NvZWZleF9pZHgoY29kZWMsIDB4NTgsIDB4MDAsIDB4ODAwMCwgMHg4MDAwKTsgLyogSFAg
ZGVwb3AgcHJvY2VkdXJlIHN0YXJ0ICovCisKKwkvKiBXYWl0IGZvciBkZXBvcCBwcm9jZWR1cmUg
ZmluaXNoICAqLworCXZhbCA9IGFsY19yZWFkX2NvZWZleF9pZHgoY29kZWMsIDB4NTgsIDB4MDEp
OworCWZvciAoaSA9IDA7IGkgPCAyMCAmJiB2YWwgJiAweDAwODA7IGkrKykgeworCQltc2xlZXAo
NTApOworCQl2YWwgPSBhbGNfcmVhZF9jb2VmZXhfaWR4KGNvZGVjLCAweDU4LCAweDAxKTsKKwl9
CisJLyogU2V0IEhQIGRlcG9wIHRvIGF1dG8gbW9kZSAqLworCWFsY191cGRhdGVfY29lZl9pZHgo
Y29kZWMsIDB4NmYsIDB4MDAwZiwgMHgwMDBiKTsKKwltc2xlZXAoNTApOworfQorCiAvKgogICov
CiBzdGF0aWMgaW50IHBhdGNoX2FsYzI2OShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKQEAgLTcz
NDksNiArNzM4MCw3IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMg
KmNvZGVjKQogCQlzcGVjLT5jb2RlY192YXJpYW50ID0gQUxDMjY5X1RZUEVfQUxDMjk0OwogCQlz
cGVjLT5nZW4ubWl4ZXJfbmlkID0gMDsgLyogQUxDMng0IGRvZXMgbm90IGhhdmUgYW55IGxvb3Bi
YWNrIG1peGVyIHBhdGggKi8KIAkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg2YiwgMHgw
MDE4LCAoMTw8NCkgfCAoMTw8MykpOyAvKiBVQUogTUlDIFZyZWYgY29udHJvbCBieSB2ZXJiICov
CisJCWFsYzI5NF9ocF9pbml0KGNvZGVjKTsKIAkJYnJlYWs7CiAJY2FzZSAweDEwZWMwMzAwOgog
CQlzcGVjLT5jb2RlY192YXJpYW50ID0gQUxDMjY5X1RZUEVfQUxDMzAwOwpAQCAtNzM2MCw2ICs3
MzkyLDcgQEAgc3RhdGljIGludCBwYXRjaF9hbGMyNjkoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMp
CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQgPSBBTEMyNjlfVFlQRV9BTEM3MDA7CiAJCXNwZWMtPmdl
bi5taXhlcl9uaWQgPSAwOyAvKiBBTEM3MDAgZG9lcyBub3QgaGF2ZSBhbnkgbG9vcGJhY2sgbWl4
ZXIgcGF0aCAqLwogCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDRhLCAxIDw8IDE1LCAw
KTsgLyogQ29tYm8gamFjayBhdXRvIHRyaWdnZXIgY29udHJvbCAqLworCQlhbGMyOTRfaHBfaW5p
dChjb2RlYyk7CiAJCWJyZWFrOwogCiAJfQo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A1842026CRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1842026CRTITMBSV02realt_--
