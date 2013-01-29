From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?=
 <benoit.thebaudeau@advansee.com>
Subject: [PATCH v2] ASoC: tlv320aic3x: Remove mono support
Date: Tue, 29 Jan 2013 21:31:48 +0100
Message-ID: <1359491508-22518-1-git-send-email-benoit.thebaudeau@advansee.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta15.web4all.fr (zose-mta15.web4all.fr [178.33.204.94])
 by alsa0.perex.cz (Postfix) with ESMTP id E5DEA261639
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 21:32:55 +0100 (CET)
In-Reply-To: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

UGxheWluZyBhIG1vbm8gc3RyZWFtIG9uIHRoZSBUTFYzMjBBSUMzeCByZXN1bHRzIGluIHRvbyBm
YXN0IHBsYXliYWNrIHJhdGUuCgpSZW1vdmUgbW9ubyBzdXBwb3J0IHNvIHRoYXQgbW9ubyBzdHJl
YW1zIGNhbiBiZSBwbGF5ZWQgY29ycmVjdGx5IG9uIHRoaXMgY29kZWMuCgpUZXN0ZWQgd2l0aCBp
bXgtc3NpIChpLk1YMjUpIGFuZCBUTFYzMjBBSUMzMTA0LgoKQ2M6IExpYW0gR2lyZHdvb2QgPGxn
aXJkd29vZEBnbWFpbC5jb20+CkNjOiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29s
ZnNvbm1pY3JvLmNvbT4KQ2M6IDxhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc+ClNpZ25lZC1v
ZmYtYnk6IEJlbm/DrnQgVGjDqWJhdWRlYXUgPGJlbm9pdC50aGViYXVkZWF1QGFkdmFuc2VlLmNv
bT4KLS0tCkNoYW5nZXMgZm9yIHYyOgogLSBSZXdvcmQgcGF0Y2ggZGVzY3JpcHRpb24gYXMgbW9u
byByZW1vdmFsIHJhdGhlciB0aGFuIGFzIG1vbm8gZml4LgotLS0KIHNvdW5kL3NvYy9jb2RlY3Mv
dGx2MzIwYWljM3guYyB8ICAgIDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFp
YzN4LmMgYi9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzN4LmMKaW5kZXggNTcwOGE5Ny4uNDk4
OTE0MyAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMzeC5jCisrKyBiL3Nv
dW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljM3guYwpAQCAtMTIxMCwxMyArMTIxMCwxMyBAQCBzdGF0
aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBhaWMzeF9kYWkgPSB7CiAJLm5hbWUgPSAidGx2
MzIwYWljM3gtaGlmaSIsCiAJLnBsYXliYWNrID0gewogCQkuc3RyZWFtX25hbWUgPSAiUGxheWJh
Y2siLAotCQkuY2hhbm5lbHNfbWluID0gMSwKKwkJLmNoYW5uZWxzX21pbiA9IDIsCiAJCS5jaGFu
bmVsc19tYXggPSAyLAogCQkucmF0ZXMgPSBBSUMzWF9SQVRFUywKIAkJLmZvcm1hdHMgPSBBSUMz
WF9GT1JNQVRTLH0sCiAJLmNhcHR1cmUgPSB7CiAJCS5zdHJlYW1fbmFtZSA9ICJDYXB0dXJlIiwK
LQkJLmNoYW5uZWxzX21pbiA9IDEsCisJCS5jaGFubmVsc19taW4gPSAyLAogCQkuY2hhbm5lbHNf
bWF4ID0gMiwKIAkJLnJhdGVzID0gQUlDM1hfUkFURVMsCiAJCS5mb3JtYXRzID0gQUlDM1hfRk9S
TUFUUyx9LAotLSAKMS43LjEwLjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
