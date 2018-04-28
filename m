From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 4/5] ARM: ep93xx: i2s: Add IRQ to platform device resources
Date: Sat, 28 Apr 2018 22:51:41 +0200
Message-ID: <20180428205142.31921-5-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Ryan Mallon <rmallon@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

QWNjb3JkaW5nIHRvICJFUDkzeHggVXNlcuKAmXMgR3VpZGUiIGl0J3MgY2FsbGVkIEkyU0lOVFIg
YW5kIGhhcyBudW1iZXIgNjAuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFs
ZXhhbmRlci5zdmVyZGxpbkBnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1lcDkzeHgvY29y
ZS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLWVwOTN4eC9jb3JlLmMgYi9hcmNoL2FybS9tYWNoLWVwOTN4eC9jb3JlLmMK
aW5kZXggZTcwZmVlYzZmYWQ1Li40OGQ2YTllMDFkYzggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtZXA5M3h4L2NvcmUuYworKysgYi9hcmNoL2FybS9tYWNoLWVwOTN4eC9jb3JlLmMKQEAgLTYz
NSw2ICs2MzUsNyBAQCBFWFBPUlRfU1lNQk9MKGVwOTN4eF9rZXlwYWRfcmVsZWFzZV9ncGlvKTsK
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqLwogc3RhdGljIHN0cnVjdCByZXNvdXJjZSBlcDkzeHhfaTJzX3Jl
c291cmNlW10gPSB7CiAJREVGSU5FX1JFU19NRU0oRVA5M1hYX0kyU19QSFlTX0JBU0UsIDB4MTAw
KSwKKwlERUZJTkVfUkVTX0lSUShJUlFfRVA5M1hYX1NBSSksCiB9OwogCiBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RldmljZSBlcDkzeHhfaTJzX2RldmljZSA9IHsKLS0gCjIuMTYuMgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
