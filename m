From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: seq: Don't allow resizing pool in use
Date: Thu,  8 Mar 2018 08:18:55 +0100
Message-ID: <20180308071856.12149-2-tiwai@suse.de>
References: <20180308071856.12149-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A8CD267412
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 08:18:59 +0100 (CET)
In-Reply-To: <20180308071856.12149-1-tiwai@suse.de>
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
Cc: =?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>, Nicolai Stange <nstange@suse.de>
List-Id: alsa-devel@alsa-project.org

VGhpcyBpcyBhIGZpeCBmb3IgYSAoc29ydCBvZikgZmFsbG91dCBpbiB0aGUgcmVjZW50IGNvbW1p
dApkMTVkNjYyZTg5ZmMgKCJBTFNBOiBzZXE6IEZpeCByYWN5IHBvb2wgaW5pdGlhbGl6YXRpb25z
IikgZm9yCkNWRS0yMDE4LTEwMDAwMDQuCkFzIHRoZSBwb29sIHJlc2l6ZSBkZWxldGVzIHRoZSBl
eGlzdGluZyBjZWxscywgaXQgbWF5IGxlYWQgdG8gYSByYWNlCndoZW4gYW5vdGhlciB0aHJlYWQg
aXMgd3JpdGluZyBjb25jdXJyZW50bHksIGV2ZW50dWFsbHkgcmVzdWx0aW5nIGEKVUFGLgoKQSBz
aW1wbGUgd29ya2Fyb3VuZCBpcyBub3QgdG8gYWxsb3cgdGhlIHBvb2wgcmVzaXppbmcgd2hlbiB0
aGUgcG9vbCBpcwppbiB1c2UuICBJdCdzIGFuIGludmFsaWQgYmVoYXZpb3IgaW4gYW55d2F5LgoK
Rml4ZXM6IGQxNWQ2NjJlODlmYyAoIkFMU0E6IHNlcTogRml4IHJhY3kgcG9vbCBpbml0aWFsaXph
dGlvbnMiKQpSZXBvcnRlZC1ieTog6IyD6b6Z6aOeIDxsb25nNzU3M0AxMjYuY29tPgpSZXBvcnRl
ZC1ieTogTmljb2xhaSBTdGFuZ2UgPG5zdGFuZ2VAc3VzZS5kZT4KQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0t
LQogc291bmQvY29yZS9zZXEvc2VxX2NsaWVudG1nci5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9jb3JlL3NlcS9zZXFfY2xpZW50
bWdyLmMgYi9zb3VuZC9jb3JlL3NlcS9zZXFfY2xpZW50bWdyLmMKaW5kZXggMDRkNGRiNDRmYWU1
Li5kNDFjZTNlZDYyY2EgMTAwNjQ0Ci0tLSBhL3NvdW5kL2NvcmUvc2VxL3NlcV9jbGllbnRtZ3Iu
YworKysgYi9zb3VuZC9jb3JlL3NlcS9zZXFfY2xpZW50bWdyLmMKQEAgLTE4MzgsNiArMTgzOCw5
IEBAIHN0YXRpYyBpbnQgc25kX3NlcV9pb2N0bF9zZXRfY2xpZW50X3Bvb2woc3RydWN0IHNuZF9z
ZXFfY2xpZW50ICpjbGllbnQsCiAJICAgICghIHNuZF9zZXFfd3JpdGVfcG9vbF9hbGxvY2F0ZWQo
Y2xpZW50KSB8fAogCSAgICAgaW5mby0+b3V0cHV0X3Bvb2wgIT0gY2xpZW50LT5wb29sLT5zaXpl
KSkgewogCQlpZiAoc25kX3NlcV93cml0ZV9wb29sX2FsbG9jYXRlZChjbGllbnQpKSB7CisJCQkv
KiBpcyB0aGUgcG9vbCBpbiB1c2U/ICovCisJCQlpZiAoYXRvbWljX3JlYWQoJmNsaWVudC0+cG9v
bC0+Y291bnRlcikpCisJCQkJcmV0dXJuIC1FQlVTWTsKIAkJCS8qIHJlbW92ZSBhbGwgZXhpc3Rp
bmcgY2VsbHMgKi8KIAkJCXNuZF9zZXFfcG9vbF9tYXJrX2Nsb3NpbmcoY2xpZW50LT5wb29sKTsK
IAkJCXNuZF9zZXFfcXVldWVfY2xpZW50X2xlYXZlX2NlbGxzKGNsaWVudC0+bnVtYmVyKTsKLS0g
CjIuMTYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
