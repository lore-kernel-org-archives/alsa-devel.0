From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 2/3] ASoC: sgtl5000: fix buggy 'Capture
	Attenuate Switch' control
Date: Wed, 31 Jul 2013 16:44:30 +0200
Message-ID: <1375281871-28128-2-git-send-email-LW@KARO-electronics.de>
References: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B258261645
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 16:44:34 +0200 (CEST)
In-Reply-To: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

VGhlIFNHVEw1MDAwIENhcHR1cmUgQXR0ZW51YXRlIFN3aXRjaCAob3IgIkFEQyBWb2x1bWUgUmFu
Z2UgUmVkdWN0aW9uIgphcyBpdCBpcyBjYWxsZWQgaW4gdGhlIG1hbnVhbCkgaXMgc2luZ2xlIGJp
dCBvbmx5LgoKU2lnbmVkLW9mZi1ieTogTG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVsZWN0cm9u
aWNzLmRlPgotLS0KIHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyB8ICAgIDIgKy0KIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAu
YwppbmRleCBhNGIyOTczLi5iYTVjYTY3IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3Nn
dGw1MDAwLmMKKysrIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jCkBAIC0zOTgsNyArMzk4
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHNndGw1MDAwX3NuZF9j
b250cm9sc1tdID0gewogCVNPQ19ET1VCTEUoIkNhcHR1cmUgVm9sdW1lIiwgU0dUTDUwMDBfQ0hJ
UF9BTkFfQURDX0NUUkwsIDAsIDQsIDB4ZiwgMCksCiAJU09DX1NJTkdMRV9UTFYoIkNhcHR1cmUg
QXR0ZW51YXRlIFN3aXRjaCAoLTZkQikiLAogCQkJU0dUTDUwMDBfQ0hJUF9BTkFfQURDX0NUUkws
Ci0JCQk4LCAyLCAwLCBjYXB0dXJlXzZkYl9hdHRlbnVhdGUpLAorCQkJOCwgMSwgMCwgY2FwdHVy
ZV82ZGJfYXR0ZW51YXRlKSwKIAlTT0NfU0lOR0xFKCJDYXB0dXJlIFpDIFN3aXRjaCIsIFNHVEw1
MDAwX0NISVBfQU5BX0NUUkwsIDEsIDEsIDApLAogCiAJU09DX0RPVUJMRV9UTFYoIkhlYWRwaG9u
ZSBQbGF5YmFjayBWb2x1bWUiLAotLSAKMS43LjIuNQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
