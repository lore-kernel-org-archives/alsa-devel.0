From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] ALSA: hda: Use ALC260_WILL quirk for another
	Acer model (0x1025007f)
Date: Sun, 13 Dec 2009 11:22:13 -0800 (PST)
Message-ID: <912673.15685.qm@web112612.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-30982655-1260732133=:15685"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112612.mail.gq1.yahoo.com (web112612.mail.gq1.yahoo.com
	[98.137.27.192]) by alsa0.perex.cz (Postfix) with SMTP id 619C71037F1
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 20:22:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-30982655-1260732133=:15685
Content-Type: text/plain; charset=us-ascii

Hi, Takashi,

Here's a patch against sound-2.6 (master) HEAD to use the appropriate
quirk for another Acer model.

Thanks,
Dan


      
--0-30982655-1260732133=:15685
Content-Type: application/octet-stream; name="0001-ALSA-hda-Use-ALC260_WILL-quirk-for-another-Acer-mode.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-hda-Use-ALC260_WILL-quirk-for-another-Acer-mode.patch"

RnJvbSA3ODdiOTEwYTM0ZTFkM2YyMWM0MDBjZWYzMGUxNGE3YmYyMmE5Yzkx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFN1biwgMTMgRGVjIDIwMDkg
MTQ6MTE6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNBOiBoZGE6IFVz
ZSBBTEMyNjBfV0lMTCBxdWlyayBmb3IgYW5vdGhlciBBY2VyIG1vZGVsICgw
eDEwMjUwMDdmKQoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5u
ZXQvYnVncy80MTg2MjcKClRoZSBvcmlnaW5hbCByZXBvcnRlciBzdGF0ZXMg
dGhhdCB0aGlzIHF1aXJrIGlzIG5lY2Vzc2FyeSB0byBvYnRhaW4KcmVhc29u
YWJsZSBnYWluIGZvciBwbGF5YmFjay4gIFdpdGhvdXQgaXQsIHNvdW5kIGlz
IGluYXVkaWJsZS4gIFRlc3RlZAp3aXRoIHBsYXliYWNrIChzcGtyIGFuZCBo
cCkgYW5kIGNhcHR1cmUuCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMKaW5kZXggODg4YjYzMS4uYWVlZDRjYyAxMDA2NDQKLS0t
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTYyNDgsNiArNjI0OCw3IEBA
IHN0YXRpYyBjb25zdCBjaGFyICphbGMyNjBfbW9kZWxzW0FMQzI2MF9NT0RF
TF9MQVNUXSA9IHsKIAogc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFs
YzI2MF9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4
MDA3YiwgIkFjZXIgQzIweCIsIEFMQzI2MF9BQ0VSKSwKKwlTTkRfUENJX1FV
SVJLKDB4MTAyNSwgMHgwMDdmLCAiQWNlciIsIEFMQzI2MF9XSUxMKSwKIAlT
TkRfUENJX1FVSVJLKDB4MTAyNSwgMHgwMDhmLCAiQWNlciIsIEFMQzI2MF9B
Q0VSKSwKIAlTTkRfUENJX1FVSVJLKDB4MTUwOSwgMHg0NTQwLCAiRmF2b3Jp
dCAxMDBYUyIsIEFMQzI2MF9GQVZPUklUMTAwKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHgyODA4LCAiSFAgZDU3MDAiLCBBTEMyNjBfSFBfMzAxMyks
Ci0tIAoxLjYuMy4zCgo=

--0-30982655-1260732133=:15685
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-30982655-1260732133=:15685--
