From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 5/5] ASoC: mxs: Add appropriate MODULE_ALIAS()
Date: Fri,  9 Dec 2011 14:38:12 +0100
Message-ID: <e40fac1ef6f650a73034acfdad13e311aaa8e017.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
	<555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
	<42d1579aefe3a3025f16fb4e38a4acf6b72756f7.1323436034.git.LW@KARO-electronics.de>
	<a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
	[81.173.242.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 8272F10387B
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 14:38:15 +0100 (CET)
In-Reply-To: <a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

ClNpZ25lZC1vZmYtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4K
LS0tCiBzb3VuZC9zb2MvbXhzL214cy1wY20uYyAgICAgIHwgICAgMSArCiBzb3VuZC9zb2MvbXhz
L214cy1zZ3RsNTAwMC5jIHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbXhzL214cy1wY20uYyBi
L3NvdW5kL3NvYy9teHMvbXhzLXBjbS5jCmluZGV4IDg2NDY5MTMuLmYzOWQ3ZGQgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3NvYy9teHMvbXhzLXBjbS5jCisrKyBiL3NvdW5kL3NvYy9teHMvbXhzLXBjbS5j
CkBAIC0zNTksMyArMzU5LDQgQEAgc3RhdGljIHZvaWQgX19leGl0IHNuZF9teHNfcGNtX2V4aXQo
dm9pZCkKIG1vZHVsZV9leGl0KHNuZF9teHNfcGNtX2V4aXQpOwogCiBNT0RVTEVfTElDRU5TRSgi
R1BMIik7CitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOm14cy1wY20tYXVkaW8iKTsKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9teHMvbXhzLXNndGw1MDAwLmMgYi9zb3VuZC9zb2MvbXhzL214cy1zZ3Rs
NTAwMC5jCmluZGV4IGRiNWMxODQuLjIyOGJiYzUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9teHMv
bXhzLXNndGw1MDAwLmMKKysrIGIvc291bmQvc29jL214cy9teHMtc2d0bDUwMDAuYwpAQCAtMTcy
LDMgKzE3Miw0IEBAIG1vZHVsZV9leGl0KG14c19zZ3RsNTAwMF9leGl0KTsKIE1PRFVMRV9BVVRI
T1IoIkZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuIik7CiBNT0RVTEVfREVTQ1JJUFRJT04o
Ik1YUyBBTFNBIFNvQyBNYWNoaW5lIGRyaXZlciIpOwogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwor
TU9EVUxFX0FMSUFTKCJwbGF0Zm9ybTpteHMtc2d0bDUwMDAiKTsKLS0gCjEuNS42LjUKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
