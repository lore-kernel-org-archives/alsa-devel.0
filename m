From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: Intel: Fix some error handling path in
	'sst_platform_get_resources()'
Date: Sat, 27 Jan 2018 13:40:28 +0100
Message-ID: <20180127124028.3795-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id BD289266C0E
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 13:43:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, arvind.yadav.cs@gmail.com
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

U2V2ZXJhbCBlcnJvciBoYW5kbGluZyBwYXRocyBzZXQgJ3JldCcgdG8gYW4gZXJyb3IgY29kZSwg
YnV0IHRoZSBmdW5jdGlvbgphbHdheXMgcmV0dXJucyAwIChpLmUuIHN1Y2Nlc3MpCgpSZXR1cm4g
J3JldCcgaW5zdGVhZCBpbiBvcmRlciB0byByZXR1cm4gdGhlIGVycm9yIGNvZGUuCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
PgotLS0KSSBndWVzcyB0aGF0IHRoZSBjb2RlIG5lZWRzIG1vcmUgY29ycmVjdGlvbi4gRm9yIHRo
aXMgZmlyc3QgdHJ5LCBJJ3ZlIGxlZnQKdGhlIGxvZ2ljIGFzLWlzLCBidXQgSSBkb24ndCByZWFs
bHkgc2VlIHdoeSB3ZSBjYWxsICdwY2lfcmVsZWFzZV9yZWdpb25zKCknCmluIHRoZSBub3JtYWwg
cGF0aC4KQSAncmV0dXJuIDA7JyBiZWZvcmUgdGhlICdkb19yZWxlYXNlX3JlZ2lvbnMnIGxhYmVs
IHdvdWxkIHNvdW5kIG1vcmUKbG9naWNhbCB0byBtZS4KLS0tCiBzb3VuZC9zb2MvaW50ZWwvYXRv
bS9zc3Qvc3N0X3BjaS5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbnRlbC9hdG9tL3NzdC9z
c3RfcGNpLmMgYi9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3Qvc3N0X3BjaS5jCmluZGV4IDY5MDZl
ZTYyNGNmNi4uOGNhZTIwODAyYjdjIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvaW50ZWwvYXRvbS9z
c3Qvc3N0X3BjaS5jCisrKyBiL3NvdW5kL3NvYy9pbnRlbC9hdG9tL3NzdC9zc3RfcGNpLmMKQEAg
LTEwNSw5ICsxMDUsMTIgQEAgc3RhdGljIGludCBzc3RfcGxhdGZvcm1fZ2V0X3Jlc291cmNlcyhz
dHJ1Y3QgaW50ZWxfc3N0X2RydiAqY3R4KQogCQlnb3RvIGRvX3JlbGVhc2VfcmVnaW9uczsKIAl9
CiAJZGV2X2RiZyhjdHgtPmRldiwgIkRSQU0gUHRyICVwXG4iLCBjdHgtPmRyYW0pOworCisJcmV0
ID0gMDsKKwogZG9fcmVsZWFzZV9yZWdpb25zOgogCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGNpKTsK
LQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0OwogfQogCiAvKgotLSAKMi4xNC4xCgoKLS0tCkwnYWJz
ZW5jZSBkZSB2aXJ1cyBkYW5zIGNlIGNvdXJyaWVyIMOpbGVjdHJvbmlxdWUgYSDDqXTDqSB2w6ly
aWZpw6llIHBhciBsZSBsb2dpY2llbCBhbnRpdmlydXMgQXZhc3QuCmh0dHBzOi8vd3d3LmF2YXN0
LmNvbS9hbnRpdmlydXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
