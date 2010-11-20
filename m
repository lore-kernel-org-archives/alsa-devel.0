From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Add Samsung R720 SSID for subwoofer
	pin fixup
Date: Sat, 20 Nov 2010 10:33:57 -0500
Message-ID: <AANLkTimF+0xTdzxaCEJGiyqRB2RwMCwdA42FtyrxzL3m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363103055ab53f04957dc05a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A5AC824422
	for <alsa-devel@alsa-project.org>; Sat, 20 Nov 2010 16:33:58 +0100 (CET)
Received: by qyk32 with SMTP id 32so155688qyk.17
	for <alsa-devel@alsa-project.org>; Sat, 20 Nov 2010 07:33:57 -0800 (PST)
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

--0016363103055ab53f04957dc05a
Content-Type: text/plain; charset=UTF-8

Hi,

Please apply the following patch against current sound-2.6 master HEAD
to enable automuting of the subwoofer on the Samsung R720 when
headphones are inserted.

Thanks,
-Dan

--0016363103055ab53f04957dc05a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Add-Samsung-R720-SSID-for-subwoofer-pin-fix.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Add-Samsung-R720-SSID-for-subwoofer-pin-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggqnr1d80

RnJvbSA1ZTE2NmRkN2I3ZDFhN2NlZmVmZDkyMGJmMmM0NWRhYWM3MTdiNGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjAgTm92IDIwMTAgMTA6MjA6MzUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEFkZCBTYW1zdW5nIFI3MjAgU1NJRCBmb3Igc3Vid29vZmVyIHBpbiBmaXh1cAoKQnVn
TGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNjc3ODMwCgpUaGUgb3JpZ2luYWwgcmVw
b3J0ZXIgc3RhdGVzIHRoYXQgdGhlIHN1Yndvb2ZlciBkb2VzIG5vdCBtdXRlIHdoZW4KaW5zZXJ0
aW5nIGhlYWRwaG9uZXMuICBXZSBuZWVkIGFuIGVudHJ5IGZvciBoaXMgbWFjaGluZSdzIFNTSUQg
aW4gdGhlCnN1Yndvb2ZlciBwaW4gZml4dXAgbGlzdCwgc28gYWRkIGl0IHRoZXJlICh2ZXJpZmll
ZCB1c2luZyBoZGFfYW5hbHl6ZXIpLgoKUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogaS1Ob0QKQ2M6
IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1
bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAgMSAr
CiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jCmluZGV4IDVmMDA1ODkuLjFhNzcwM2EgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5j
CkBAIC0xOTI5OCw2ICsxOTI5OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWxjX2ZpeHVwIGFs
YzY2Ml9maXh1cHNbXSA9IHsKIAogc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzY2Ml9m
aXh1cF90YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTAyNSwgMHgwMzhiLCAiQWNlciBBc3Bp
cmUgODk0M0ciLCBBTEM2NjJfRklYVVBfQVNQSVJFKSwKKwlTTkRfUENJX1FVSVJLKDB4MTQ0ZCwg
MHhjMDUxLCAiU2Ftc3VuZyBSNzIwIiwgQUxDNjYyX0ZJWFVQX0lERUFQQUQpLAogCVNORF9QQ0lf
UVVJUksoMHgxN2FhLCAweDM4YWYsICJMZW5vdm8gSWRlYXBhZCBZNTUwUCIsIEFMQzY2Ml9GSVhV
UF9JREVBUEFEKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzYTBkLCAiTGVub3ZvIElkZWFw
YWQgWTU1MCIsIEFMQzY2Ml9GSVhVUF9JREVBUEFEKSwKIAl7fQotLSAKMS43LjEKCg==
--0016363103055ab53f04957dc05a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016363103055ab53f04957dc05a--
