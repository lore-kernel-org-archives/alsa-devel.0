From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [PATCH] ASoC: sgtl5000: add delay before first I2C
	access
Date: Fri, 30 Jan 2015 13:52:11 -0700
Message-ID: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1772604C3
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 21:52:18 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id kq14so56668366pab.0
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 12:52:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Cc: fabio.estevam@freescale.com, broonie@kernel.org, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

VG8gcXVvdGUgZnJvbSBzZWN0aW9uIDEuMy4xIG9mIHRoZSBkYXRhIHNoZWV0OgoJVGhlIFNHVEw1
MDAwIGhhcyBhbiBpbnRlcm5hbCByZXNldCB0aGF0IGlzIGRlYXNzZXJ0ZWQKCTggU1lTX01DTEsg
Y3ljbGVzIGFmdGVyIGFsbCBwb3dlciByYWlscyBoYXZlIGJlZW4gYnJvdWdodAoJdXAuIEFmdGVy
IHRoaXMgdGltZSwgY29tbXVuaWNhdGlvbiBjYW4gc3RhcnQKCgkuLi4KCTEuMM68cyByZXByZXNl
bnRzIDggU1lTX01DTEsgY3ljbGVzIGF0IHRoZSBtaW5pbXVtIDguMCBNSHogU1lTX01DTEsuCgpT
aWduZWQtb2ZmLWJ5OiBFcmljIE5lbHNvbiA8ZXJpYy5uZWxzb25AYm91bmRhcnlkZXZpY2VzLmNv
bT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCAzICsrKwogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUw
MDAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYwppbmRleCAyOWNmN2NlLi43ZDY1YTVi
IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMKKysrIGIvc291bmQvc29j
L2NvZGVjcy9zZ3RsNTAwMC5jCkBAIC0xNDYyLDYgKzE0NjIsOSBAQCBzdGF0aWMgaW50IHNndGw1
MDAwX2kyY19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LAogCWlmIChyZXQpCiAJCXJl
dHVybiByZXQ7CiAKKwkvKiBOZWVkIDggY2xvY2tzIGJlZm9yZSBJMkMgYWNjZXNzZXMgKi8KKwl1
c2xlZXBfcmFuZ2UoMSwgMik7CisKIAkvKiByZWFkIGNoaXAgaW5mb3JtYXRpb24gKi8KIAlyZXQg
PSByZWdtYXBfcmVhZChzZ3RsNTAwMC0+cmVnbWFwLCBTR1RMNTAwMF9DSElQX0lELCAmcmVnKTsK
IAlpZiAocmV0KQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
