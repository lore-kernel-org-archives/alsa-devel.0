From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ASoC: da7219: Fix a compile warning at
	CONFIG_COMMON_CLK=n
Date: Mon,  6 May 2019 17:02:22 +0200
Message-ID: <20190506150224.1394-2-tiwai@suse.de>
References: <20190506150224.1394-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C658F89715
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:02:25 +0200 (CEST)
In-Reply-To: <20190506150224.1394-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QSB0cml2aWFsIGZpeCBmb3IgdGhlIHJhbmRjb25maWcgYnVpbGQgZXJyb3I6CiAgc291bmQvc29j
L2NvZGVjcy9kYTcyMTkuYzoyMzY2OjY6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhp4oCZ
IFstV3VudXNlZC12YXJpYWJsZV0KCkZpeGVzOiBkOTBiYTZjOGI1M2UgKCJBU29DOiBkYTcyMTk6
IEV4cG9zZSBCQ0xLIGFuZCBXQ0xLIGNvbnRyb2wgdGhyb3VnaCBDQ0YiKQpTaWduZWQtb2ZmLWJ5
OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0tLQogc291bmQvc29jL2NvZGVjcy9kYTcy
MTkuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5jIGIvc291bmQvc29jL2NvZGVjcy9kYTcyMTkuYwpp
bmRleCBjZjI5NDhjMDAyNjIuLjdkOWQxZjg0ZWVkOCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2Nv
ZGVjcy9kYTcyMTkuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL2RhNzIxOS5jCkBAIC0yMzYzLDcg
KzIzNjMsOSBAQCBzdGF0aWMgaW50IGRhNzIxOV9wcm9iZShzdHJ1Y3Qgc25kX3NvY19jb21wb25l
bnQgKmNvbXBvbmVudCkKIHN0YXRpYyB2b2lkIGRhNzIxOV9yZW1vdmUoc3RydWN0IHNuZF9zb2Nf
Y29tcG9uZW50ICpjb21wb25lbnQpCiB7CiAJc3RydWN0IGRhNzIxOV9wcml2ICpkYTcyMTkgPSBz
bmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21wb25lbnQpOworI2lmZGVmIENPTkZJR19D
T01NT05fQ0xLCiAJaW50IGk7CisjZW5kaWYKIAogCWRhNzIxOV9hYWRfZXhpdChjb21wb25lbnQp
OwogCi0tIAoyLjE2LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
