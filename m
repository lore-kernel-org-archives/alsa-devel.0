From: Brendan Shanks <brendan.shanks@teradek.com>
Subject: [PATCH] pcm: dshare: Fix overflow when slave_hw_ptr
	rolls over boundary
Date: Mon, 11 Feb 2019 11:51:26 -0800
Message-ID: <20190211195126.29651-1-brendan.shanks@teradek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2BD267468
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 20:51:52 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id y10so67662plp.0
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 11:51:52 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Brendan Shanks <brendan.shanks@teradek.com>
List-Id: alsa-devel@alsa-project.org

SW4gc25kX3BjbV9kc2hhcmVfc3luY19hcmVhKCkgd2hlbiAnc2xhdmVfaHdfcHRyJyByb2xscyBv
dmVyCidzbGF2ZV9ib3VuZGFyeScsIHRoZSB3cm9uZyB2YXJpYWJsZSBpcyBjaGVja2VkICgnZHNo
YXJlLT5zbGF2ZV9od19wdHInIHZzCnRoZSBsb2NhbCAnc2xhdmVfaHdfcHRyJykuIEluIHNvbWUg
Y2FzZXMsIHRoaXMgcmVzdWx0cyBpbiAnc2xhdmVfaHdfcHRyJwpub3Qgcm9sbGluZyBvdmVyIGNv
cnJlY3RseS4gJ3NsYXZlX3NpemUnIGFuZCAnc2l6ZScgYXJlIHRoZW4gbXVjaCB0b28KbGFyZ2Us
IGFuZCB0aGUgZm9yIGxvb3AgYmxvY2tzIGZvciBzZXZlcmFsIG1pbnV0ZXMgY29weWluZyBzYW1w
bGVzLgoKVGhpcyB3YXMgbGlrZWx5IG9ubHkgdHJpZ2dlcmVkIG9uIDMyLWJpdCBzeXN0ZW1zLCBz
aW5jZSB0aGUgUENNIGJvdW5kYXJ5CmlzIGNvbXB1dGVkIGJhc2VkIG9uIExPTkdfTUFYIGFuZCBp
cyBtdWNoIGxhcmdlciBvbiA2NC1iaXQgc3lzdGVtcy4KClRoaXMgc2FtZSBjaGFuZ2Ugd2FzIG1h
ZGUgdG8gcGNtX2RtaXggaW4gY29tbWl0CjZjN2Y2MGY3YTk4MmZkYmE4MjhlNDUzMGE5ZDdhYTBh
YTJiNzA0YWUgKCJGaXggYm91bmRhcnkgb3ZlcmxhcOKAnSkgZnJvbQpKdW5lIDIwMDUuCgpTaWdu
ZWQtb2ZmLWJ5OiBCcmVuZGFuIFNoYW5rcyA8YnJlbmRhbi5zaGFua3NAdGVyYWRlay5jb20+Cgpk
aWZmIC0tZ2l0IGEvc3JjL3BjbS9wY21fZHNoYXJlLmMgYi9zcmMvcGNtL3BjbV9kc2hhcmUuYwpp
bmRleCAyYmI3MzVmZS4uZjEzNWI1ZGYgMTAwNjQ0Ci0tLSBhL3NyYy9wY20vcGNtX2RzaGFyZS5j
CisrKyBiL3NyYy9wY20vcGNtX2RzaGFyZS5jCkBAIC0xMjEsNyArMTIxLDcgQEAgc3RhdGljIHZv
aWQgc25kX3BjbV9kc2hhcmVfc3luY19hcmVhKHNuZF9wY21fdCAqcGNtKQogCSAqLwogCXNsYXZl
X2h3X3B0ciAtPSBzbGF2ZV9od19wdHIgJSBkc2hhcmUtPnNsYXZlX3BlcmlvZF9zaXplOwogCXNs
YXZlX2h3X3B0ciArPSBkc2hhcmUtPnNsYXZlX2J1ZmZlcl9zaXplOwotCWlmIChkc2hhcmUtPnNs
YXZlX2h3X3B0ciA+IGRzaGFyZS0+c2xhdmVfYm91bmRhcnkpCisJaWYgKHNsYXZlX2h3X3B0ciA+
PSBkc2hhcmUtPnNsYXZlX2JvdW5kYXJ5KQogCQlzbGF2ZV9od19wdHIgLT0gZHNoYXJlLT5zbGF2
ZV9ib3VuZGFyeTsKIAlpZiAoc2xhdmVfaHdfcHRyIDwgZHNoYXJlLT5zbGF2ZV9hcHBsX3B0cikK
IAkJc2xhdmVfc2l6ZSA9IHNsYXZlX2h3X3B0ciArIChkc2hhcmUtPnNsYXZlX2JvdW5kYXJ5IC0g
ZHNoYXJlLT5zbGF2ZV9hcHBsX3B0cik7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
