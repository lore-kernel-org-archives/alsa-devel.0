From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for Acer Aspire 5110
Date: Sat, 22 May 2010 12:18:48 -0400
Message-ID: <AANLkTilXxOIvT_JXjKluzLupSCmmVE1dz5B_ijTvnomb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502ad009fc4d1048731291e
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8AF2424966
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 18:18:49 +0200 (CEST)
Received: by pwj9 with SMTP id 9so979438pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 22 May 2010 09:18:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502ad009fc4d1048731291e
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against sound-2.6 master HEAD specifying
the LPIB quirk for an additional SSID to make capture work correctly
in an installed distribution.

This patch is applicable to 2.6.32, 2.6.33, and 2.6.34 stable trees
(some with fuzz).

Best,
-Dan

--00504502ad009fc4d1048731291e
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-Acer-Aspire-5110.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-Acer-Aspire-5110.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9in6ogy0

RnJvbSA4ZjA0ZTM2NGFhMjhiNDljYzlkMzNjYjUxZWE5ZTZkNTNmNWQwMmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMjIgTWF5IDIwMTAgMTI6MDU6NDEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBBY2VyIEFzcGlyZSA1MTEwCgpCdWdMaW5rOiBodHRwczovL2xh
dW5jaHBhZC5uZXQvYnVncy81ODM5ODMKClN5bXB0b206IG9uIGEgc2lnbmlmaWNhbnQgbnVtYmVy
IG9mIGhhcmR3YXJlLCBib290aW5nIGZyb20gYSBsaXZlIGNkCnJlc3VsdHMgaW4gY2FwdHVyZSB3
b3JraW5nIGNvcnJlY3RseSwgYnV0IG9uY2UgdGhlIGRpc3RyaWJ1dGlvbiBpcwppbnN0YWxsZWQs
IGJvb3RpbmcgZnJvbSB0aGUgaW5zdGFsbCByZXN1bHRzIGluIGNhcHR1cmUgbm90IHdvcmtpbmcu
CgpUZXN0IGNhc2U6IGJvb3QgZnJvbSBVYnVudHUgMTAuMDQgTFRTIGxpdmUgY2Q7IGNhcHR1cmUg
d29ya3MgY29ycmVjdGx5LgpJbnN0YWxsIHRvIEhEIGFuZCByZWJvb3Q7IGNhcHR1cmUgZG9lcyBu
b3Qgd29yay4gUmVwcm9kdWNlZCB3aXRoIDIuNi4zMgptYWlubGluZSBidWlsZCAodmFuaWxsYSBr
ZXJuZWwub3JnIGNvbXBpbGUpLgoKUmVzb2x1dGlvbjogYWRkIFNTSUQgZm9yIEFjZXIgQXNwaXJl
IDUxMTAgdG8gdGhlIHBvc2l0aW9uX2ZpeCBxdWlyawp0YWJsZSwgZXhwbGljaXRseSBzcGVjaWZ5
aW5nIHRoZSBMUElCIG1ldGhvZC4KCkknbGwgYmUgc2VuZGluZyBhZGRpdGlvbmFsIHBhdGNoZXMg
Zm9yIHRoZXNlIFNTSURzIGFzIGJ1ZyByZXBvcnRzIGFyZQpjb25maXJtZWQuCgpSZXBvcnRlZC1h
bmQtVGVzdGVkLUJ5OiBMZW8KQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRh
X2ludGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3Vu
ZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDE3MDYxMGUuLmVjNTU0ZmMgMTAwNjQ0Ci0tLSBh
L3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwu
YwpAQCAtMjI3OSw2ICsyMjc5LDcgQEAgc3RhdGljIGludCBhenhfZGV2X2ZyZWUoc3RydWN0IHNu
ZF9kZXZpY2UgKmRldmljZSkKICAqIHdoaXRlL2JsYWNrLWxpc3RpbmcgZm9yIHBvc2l0aW9uX2Zp
eAogICovCiBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgcG9zaXRpb25fZml4X2xpc3RbXSBf
X2RldmluaXRkYXRhID0geworCVNORF9QQ0lfUVVJUksoMHgxMDI1LCAweDAwOWYsICJBY2VyIEFz
cGlyZSA1MTEwIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMWNj
LCAiRGVsbCBEODIwIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgw
MWRlLCAiRGVsbCBQcmVjaXNpb24gMzkwIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTAyOCwgMHgwMWY2LCAiRGVsbCBMYXRpdHVkZSAxMzFMIiwgUE9TX0ZJWF9MUElCKSwKLS0g
CjEuNy4wLjQKCg==
--00504502ad009fc4d1048731291e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502ad009fc4d1048731291e--
