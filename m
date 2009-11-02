From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] hda: Use quirk mask for Dell Inspiron
	Mini9/Vostro A90
Date: Sun, 1 Nov 2009 16:00:48 -0800 (PST)
Message-ID: <287656.16150.qm@web112611.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1217861429-1257120048=:16150"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112611.mail.gq1.yahoo.com (web112611.mail.gq1.yahoo.com
	[98.137.27.191]) by alsa0.perex.cz (Postfix) with SMTP id DC1AF24564
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 01:00:50 +0100 (CET)
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
Cc: crimsun@ubuntu.com, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0-1217861429-1257120048=:16150
Content-Type: text/plain; charset=us-ascii

Hi,

Attached please find a patch against current sound-2.6 HEAD that uses a quirk
mask for Dell Inspiron Mini9/Vostro A90.

Thanks,
Dan



      
--0-1217861429-1257120048=:16150
Content-Type: application/octet-stream; name="0001-ALSA-hda-Use-quirk-mask-for-Dell-Inspiron-Mini9-Vost.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-hda-Use-quirk-mask-for-Dell-Inspiron-Mini9-Vost.patch"

RnJvbSBiY2QyNzQ4NGJhZDhjNzYyZjEwNWZmZGIwOTI2NTA2MzJjODM4NGRl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFN1biwgMSBOb3YgMjAwOSAx
ODozMjoyOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IGhkYTogVXNl
IHF1aXJrIG1hc2sgZm9yIERlbGwgSW5zcGlyb24gTWluaTkvVm9zdHJvIEE5
MCB1c2luZyBBTEMyNjgKCkJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hw
YWQubmV0L2J1Z3MvMzY4NjI5CgpXZSBzaG91bGQgdXNlIGEgcXVpcmsgbWFz
ayBmb3IgdGhlc2UgRGVsbCBJbnNwaXJvbiBNaW5pOXMgYW5kIFZvc3RybwpB
OTBzLCBhcyB0aGUgbW9kZWw9ZGVsbCBxdWlyayBhcHBlYXJzIHRvIGVuYWJs
ZSBhdWRpbyBvbiB0aGVtLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hl
biA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jIHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMKaW5kZXggZTAxYjRiMS4uODExNzc2NCAxMDA2NDQK
LS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291
bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTEyNTk0LDcgKzEyNTk0
LDggQEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzI2OF9jZmdf
dGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MDE1YiwgIkFj
ZXIgQXNwaXJlIE9uZSIsCiAJCQkJCQlBTEMyNjhfQUNFUl9BU1BJUkVfT05F
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMjUzLCAiRGVsbCBPRU0i
LCBBTEMyNjhfREVMTCksCi0JU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDJi
MCwgIkRlbGwgSW5zcGlyb24gTWluaTkiLCBBTEMyNjhfREVMTCksCisJU05E
X1BDSV9RVUlSS19NQVNLKDB4MTAyOCwgMHhmZmYwLCAweDAyYjAsCisJCQki
RGVsbCBJbnNwaXJvbiBNaW5pOS9Wb3N0cm8gQTkwIiwgQUxDMjY4X0RFTEwp
LAogCS8qIGFsbW9zdCBjb21wYXRpYmxlIHdpdGggdG9zaGliYSBidXQgd2l0
aCBvcHRpb25hbCBkaWdpdGFsIG91dHM7CiAJICogYXV0by1wcm9iaW5nIHNl
ZW1zIHdvcmtpbmcgZmluZQogCSAqLwotLSAKMS42LjMuMwoK

--0-1217861429-1257120048=:16150
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1217861429-1257120048=:16150--
