From: =?UTF-8?q?Johan=20Rast=C3=A9n?= <johan@oljud.se>
Subject: [PATCH] usb-audio: Set the Control Selector to
	SU_SELECTOR_CONTROL for UAC2
Date: Mon, 17 Nov 2014 08:39:33 +0100
Message-ID: <1416209973-7773-1-git-send-email-johan@oljud.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4AB2614DD
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 08:39:45 +0100 (CET)
Received: by mail-la0-f54.google.com with SMTP id gf13so5966562lab.27
 for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 23:39:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?Johan=20Rast=C3=A9n?= <johan@oljud.se>
List-Id: alsa-devel@alsa-project.org

U3BlY2lmaWVkIGluIHNlY3Rpb24gNS4yLjUuNi4xIG9mIHRoZSBVU0IgQXVkaW8gQ2xhc3MgMi4w
IGRlZmluaXRpb24uCgpTb2x2ZXMgdGhlIGZvbGxvd2luZyBlcnJvciBmb3IgQy1NZWRpYSA2NjMy
QSAoQXN1cyBYb25hciBVNyk6ClsgODIxOS42NzYxNjRdIGNhbm5vdCBnZXQgY3RsIHZhbHVlOiBy
ZXEgPSAweDgxLCB3VmFsdWUgPSAweDAsIHdJbmRleCA9IDB4MTQwMCwgdHlwZSA9IDMKClNpZ25l
ZC1vZmYtYnk6IEpvaGFuIFJhc3TDqW4gPGpvaGFuQG9sanVkLnNlPgotLS0KIHNvdW5kL3VzYi9t
aXhlci5jIHwgNyArKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlci5jIGIvc291bmQvdXNiL21p
eGVyLmMKaW5kZXggMTRlMTQ1NS4uYzYyMDljZSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL21peGVy
LmMKKysrIGIvc291bmQvdXNiL21peGVyLmMKQEAgLTIwMzIsMTAgKzIwMzIsMTEgQEAgc3RhdGlj
IGludCBwYXJzZV9hdWRpb19zZWxlY3Rvcl91bml0KHN0cnVjdCBtaXhlcl9idWlsZCAqc3RhdGUs
IGludCB1bml0aWQsCiAJY3ZhbC0+cmVzID0gMTsKIAljdmFsLT5pbml0aWFsaXplZCA9IDE7CiAK
LQlpZiAoZGVzYy0+YkRlc2NyaXB0b3JTdWJ0eXBlID09IFVBQzJfQ0xPQ0tfU0VMRUNUT1IpCi0J
CWN2YWwtPmNvbnRyb2wgPSBVQUMyX0NYX0NMT0NLX1NFTEVDVE9SOwotCWVsc2UKKwlpZiAoc3Rh
dGUtPm1peGVyLT5wcm90b2NvbCA9PSBVQUNfVkVSU0lPTl8xKQogCQljdmFsLT5jb250cm9sID0g
MDsKKwllbHNlIC8qIFVBQ19WRVJTSU9OXzIgKi8KKwkJY3ZhbC0+Y29udHJvbCA9IChkZXNjLT5i
RGVzY3JpcHRvclN1YnR5cGUgPT0gVUFDMl9DTE9DS19TRUxFQ1RPUikgPworCQkJVUFDMl9DWF9D
TE9DS19TRUxFQ1RPUiA6IFVBQzJfU1VfU0VMRUNUT1I7CiAKIAluYW1lbGlzdCA9IGttYWxsb2Mo
c2l6ZW9mKGNoYXIgKikgKiBkZXNjLT5iTnJJblBpbnMsIEdGUF9LRVJORUwpOwogCWlmICghbmFt
ZWxpc3QpIHsKLS0gCjIuMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
