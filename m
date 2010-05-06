From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 1/2] es1968: Clear interrupts before enabling
	them
Date: Fri,  7 May 2010 00:12:12 +0300
Message-ID: <1273180333-15500-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 230A8103817
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 23:13:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

RnJvbTogVmlsbGUgU3lyasOkbMOkIDxzeXJqYWxhQHNjaS5maT4KCkF2b2lkIHNwdXJpb3VzIGlu
dGVycnVwdHMgd2hlbiBpbml0aWFsaXppbmcgdGhlIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IFZp
bGxlIFN5cmrDpGzDpCA8c3lyamFsYUBzY2kuZmk+Ci0tLQogc291bmQvcGNpL2VzMTk2OC5jIHwg
ICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvZXMxOTY4LmMgYi9zb3VuZC9wY2kvZXMxOTY4LmMKaW5k
ZXggYWE5NzNjZS4uMjNhNThmMCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2VzMTk2OC5jCisrKyBi
L3NvdW5kL3BjaS9lczE5NjguYwpAQCAtMjQwMSw2ICsyNDAxLDcgQEAgc3RhdGljIHZvaWQgc25k
X2VzMTk2OF9zdGFydF9pcnEoc3RydWN0IGVzMTk2OCAqY2hpcCkKIAl3ID0gRVNNX0hJUlFfRFNJ
RSB8IEVTTV9ISVJRX0hXX1ZPTFVNRTsKIAlpZiAoY2hpcC0+cm1pZGkpCiAJCXcgfD0gRVNNX0hJ
UlFfTVBVNDAxOworCW91dGIodywgY2hpcC0+aW9fcG9ydCArIDB4MUEpOwogCW91dHcodywgY2hp
cC0+aW9fcG9ydCArIEVTTV9QT1JUX0hPU1RfSVJRKTsKIH0KIAotLSAKMS42LjQuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
