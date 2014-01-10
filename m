From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: s6000: Don't mix
	SNDRV_PCM_RATE_CONTINUOUS with specific rates
Date: Fri, 10 Jan 2014 16:06:34 +0100
Message-ID: <1389366396-16884-3-git-send-email-lars@metafoo.de>
References: <1389366396-16884-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB362608D0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:06:35 +0100 (CET)
In-Reply-To: <1389366396-16884-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Acked-by=3A=20Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

U05EUlZfUENNX1JBVEVfQ09OVElOVU9VUyBtZWFucyB0aGF0IGFsbCByYXRlcyAocG9zc2libHkg
bGltaXRlZCB0byBhIGNlcnRhaW4KaW50ZXJ2YWwpIGFyZSBzdXBwb3J0ZWQuIFRoZXJlIGlzIG5v
IG5lZWQgdG8gbWFudWFsbHkgc2V0IG90aGVyIHJhdGUgYml0cy4KClNpZ25lZC1vZmYtYnk6IExh
cnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPgpDYzogQWNrZWQtYnk6IERhbmllbCBH
bMO2Y2tuZXIgPGRhbmllbC1nbEBnbXgubmV0PgotLS0KIHNvdW5kL3NvYy9zNjAwMC9zNjAwMC1p
MnMuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3M2MDAwL3M2MDAwLWkycy5jIGIvc291bmQvc29j
L3M2MDAwL3M2MDAwLWkycy5jCmluZGV4IDczYmI5OWYuLjdlYmE3OTcgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3NvYy9zNjAwMC9zNjAwMC1pMnMuYworKysgYi9zb3VuZC9zb2MvczYwMDAvczYwMDAtaTJz
LmMKQEAgLTQwNSw4ICs0MDUsNyBAQCBzdGF0aWMgaW50IHM2MDAwX2kyc19kYWlfcHJvYmUoc3Ry
dWN0IHNuZF9zb2NfZGFpICpkYWkpCiAJcmV0dXJuIDA7CiB9CiAKLSNkZWZpbmUgUzYwMDBfSTJT
X1JBVEVTCShTTkRSVl9QQ01fUkFURV9DT05USU5VT1VTIHwgU05EUlZfUENNX1JBVEVfNTUxMiB8
IFwKLQkJCSBTTkRSVl9QQ01fUkFURV84MDAwXzE5MjAwMCkKKyNkZWZpbmUgUzYwMDBfSTJTX1JB
VEVTIFNORFJWX1BDTV9SQVRFX0NPTlRJTlVPVVMKICNkZWZpbmUgUzYwMDBfSTJTX0ZPUk1BVFMg
KFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFIHwgU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUpCiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYWlfb3BzIHM2MDAwX2kyc19kYWlfb3BzID0gewot
LSAKMS44LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
