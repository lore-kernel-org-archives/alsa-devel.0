From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use model=mb5 for MacBookPro 5,2
Date: Wed, 11 Nov 2009 14:49:07 -0500
Message-ID: <604760770911111149y6d8ae733w996f6d062dbab907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd32eb843c74204781db8bc
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id B7E09103982
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 20:49:08 +0100 (CET)
Received: by pzk14 with SMTP id 14so983215pzk.23
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 11:49:07 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--000e0cd32eb843c74204781db8bc
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against current sound-2.6 HEAD adding
the codec SSID for MacBookPro 5,2 to enable playback and capture
(with the same caveat as for MacBookPro 5,1 that jacksense remains
at odds).

Thanks,
Dan

--000e0cd32eb843c74204781db8bc
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-model-mb5-for-MacBookPro-5-2.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-model-mb5-for-MacBookPro-5-2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1wi6qa50

RnJvbSBjZjIwNTY1MTcyYTVlN2M0Y2I5NDBiYjVhZjA0OGFlYzM0NDExY2JlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMTEgTm92IDIwMDkgMTQ6MzI6MTAgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBtb2RlbD1tYjUgZm9yIE1hY0Jvb2tQcm8gNSwyCgpCdWdMaW5rOiBodHRwczov
L2J1Z3MubGF1bmNocGFkLm5ldC9idWdzLzQ2MjA5OAoKVW50aWwgd2UgY2FuIGxvb2sgY2xvc2Vy
IGF0IHRoZSB2ZXJicywgbGV0J3MgdXNlIEFMQzg4NV9NQjUgZm9yCmNvZGVjIFNTSUQgMHgxMDZi
NDYwMCB0byBlbmFibGUgcGxheWJhY2sgYW5kIGNhcHR1cmUgZm9yIE1hY0Jvb2tQcm8KNSwycy4K
ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBz
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDUgKysrLS0KIDEgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5k
ZXggMDA0MWFlMi4uNDlkZTEwNyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTg5MTIsMTAgKzg5
MTIsMTEgQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzg4Ml9zc2lkX2NmZ190Ymxb
XSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzODAwLCAiTWFjYm9va1BybyA0LDEiLCBB
TEM4ODVfTUJQMyksCiAJU05EX1BDSV9RVUlSSygweDEwNmIsIDB4M2UwMCwgImlNYWMgMjQgQWx1
bWludW0iLCBBTEM4ODVfSU1BQzI0KSwKIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHgzZjAwLCAi
TWFjYm9vayA1LDEiLCBBTEM4ODVfTUI1KSwKLQkvKiBGSVhNRTogSFAgamFjayBzZW5zZSBzZWVt
cyBub3Qgd29ya2luZyBmb3IgTUJQIDUsMSwgc28gYXBwYXJlbnRseQotCSAqIG5vIHBlcmZlY3Qg
c29sdXRpb24geWV0CisJLyogRklYTUU6IEhQIGphY2sgc2Vuc2Ugc2VlbXMgbm90IHdvcmtpbmcg
Zm9yIE1CUCA1LDEgb3IgNSwyLAorCSAqIHNvIGFwcGFyZW50bHkgbm8gcGVyZmVjdCBzb2x1dGlv
biB5ZXQKIAkgKi8KIAlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHg0MDAwLCAiTWFjYm9va1BybyA1
LDEiLCBBTEM4ODVfTUI1KSwKKwlTTkRfUENJX1FVSVJLKDB4MTA2YiwgMHg0NjAwLCAiTWFjYm9v
a1BybyA1LDIiLCBBTEM4ODVfTUI1KSwKIAl7fSAvKiB0ZXJtaW5hdG9yICovCiB9OwogCi0tIAox
LjYuMy4zCgo=
--000e0cd32eb843c74204781db8bc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd32eb843c74204781db8bc--
