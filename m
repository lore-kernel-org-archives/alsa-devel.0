From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Tue, 14 Apr 2009 10:07:51 +0300
Message-ID: <200904141007.52528.peter.ujfalusi@nokia.com>
References: <49DDFE1D.3090009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 23AC32446C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 09:08:08 +0200 (CEST)
In-Reply-To: <49DDFE1D.3090009@samsung.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1cnNkYXkgMDkgQXByaWwgMjAwOSAxNjo1NDozNyBleHQgSm9vbnlvdW5nIFNoaW0gd3Jv
dGU6Cj4gQWRkIFZvaWNlIERBSSB0byBzdXBwb3J0IHRoZSBQQ00gdm9pY2UgaW50ZXJmYWNlIG9m
IHRoZSB0d2w0MDMwIGNvZGVjLgo+Cj4gVGhlIFBDTSB2b2ljZSBpbnRlcmZhY2UgY2FuIGJlIHVz
ZWQgd2l0aCA4LWtIeih2b2ljZSBuYXJyb3diYW5kKSBvciAxNi1rSHoKPiAodm9pY2Ugd2lkZWJh
bmQpIHNhbXBsaW5nIHJhdGVzLCBhbmQgMTZiaXRzLCBhbmQgbW9ubyBSWCBhbmQgbW9ubyBUWCBv
cgo+IHN0ZXJlbyBUWC4KPgo+IElmIHRoZSBzeXN0ZW0gbWFzdGVyIGNsb2NrIGlzIG5vdCAyNk1I
eiwgdGhlIHZvaWNlIFBDTSBpbnRlcmZhY2UgaXMgbm90Cj4gYXZhaWxhYmxlLgo+Cj4gVGhlIFBD
TSB2b2ljZSBpbnRlcmZhY2UgaGFzIHR3byBtb2Rlcwo+IC0gUENNIG1vZGUxIDogVGhpcyB1c2Vz
IHRoZSByaXNpbmcgZWRnZSBvZiB0aGUgY2xvY2sgc2lnbmFsCj4gLSBQQ00gbW9kZTIgOiBUaGlz
IHVzZXMgdGhlIGZhbGxpbmcgZWRnZSBvZiB0aGUgY2xvY2sgc2lnbmFsCj4KPiBQQ00gbW9kZTEg
YW5kIG1vZGUyIGhhdmUgYSBsb29rIG9mIERTUF9BIGFuZCBEU1BfQiwgc28gd2UgdXNlZCBEU1Bf
QSBhbmQKPiBEU1BfQi4KCkJvdGggb2YgdGhlIFBDTSBtb2RlMSBhbmQgbW9kZTIgaXMgYWN0dWFs
bHkgRFNQX0EsIGJ1dCB0aGUgRlMgcG9sYXJpdHkgaXMgCmludmVydGVkIGFuZCBhbHNvIHRoZSBk
YXRhIGlzIHNoaWZ0ZWQvc2FtcGxlZCBvbiB0aGUgb3Bwb3NpdGUgZWRnZSBvZiB0aGUgCmJpdGNs
b2NrLgoKPiArc3RhdGljIGludCB0d2w0MDMwX3ZvaWNlX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21f
c3Vic3RyZWFtICpzdWJzdHJlYW0sCj4gKwkJCQlzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkKPiAr
ewo+ICsJc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+cHJpdmF0
ZV9kYXRhOwo+ICsJc3RydWN0IHNuZF9zb2NfZGV2aWNlICpzb2NkZXYgPSBydGQtPnNvY2RldjsK
PiArCXN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IHNvY2Rldi0+Y2FyZC0+Y29kZWM7Cj4g
Kwl1OCBpbmZyZXE7Cj4gKwo+ICsJLyogSWYgdGhlIHN5c3RlbSBtYXN0ZXIgY2xvY2sgaXMgbm90
IDI2TUh6LCB0aGUgdm9pY2UgUENNIGludGVyZmFjZSBpcwo+ICsJICogbm90IGF2aWxhYmxlLgo+
ICsJICovCj4gKwlpbmZyZXEgPSB0d2w0MDMwX3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBUV0w0MDMw
X1JFR19BUExMX0NUTCkKPiArCQkmIFRXTDQwMzBfQVBMTF9JTkZSRVE7Cj4gKwo+ICsJaWYgKGlu
ZnJlcSAhPSBUV0w0MDMwX0FQTExfSU5GUkVRXzI2MDAwS0haKQo+ICsJCXJldHVybiAtRVBFUk07
CgpXb3VsZCBpdCBiZSBmZWFzaWJsZSB0byBhZGQgYSBjaGVjayBoZXJlIGFnYWluc3QgdGhlIENP
REVDX01PREU6T1BUX01PREUgYW5kIAppZiB0aGUgY29kZWMgaXMgbm90IGluIE9wdGlvbjIgbW9k
ZSwgdGhhbiByZXR1cm4gd2l0aCBlcnJvcj8KCgotLSAKUMOpdGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
