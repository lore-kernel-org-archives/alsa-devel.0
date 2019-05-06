From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ASoC: SOF: Fix a compile warning with
	CONFIG_PCI=n
Date: Mon,  6 May 2019 17:02:23 +0200
Message-ID: <20190506150224.1394-3-tiwai@suse.de>
References: <20190506150224.1394-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0D91F896FF
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
L3NvZi9vcHMuYzoyMDo2OiB3YXJuaW5nOiDigJhyZXTigJkgaXMgdXNlZCB1bmluaXRpYWxpemVk
IGluIHRoaXMgZnVuY3Rpb24gWy1XdW5pbml0aWFsaXplZF0KCkZpeGVzOiBkMWQ5NWZjYjYzZTMg
KCJBU29DOiBTT0Y6IEFkZCBEU1AgSFcgYWJzdHJhY3Rpb24gb3BlcmF0aW9ucyIpClNpZ25lZC1v
ZmYtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBzb3VuZC9zb2Mvc29mL29w
cy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9vcHMuYyBiL3NvdW5kL3NvYy9zb2Yvb3BzLmMK
aW5kZXggODBmOTA3NzQwYjgyLi43YTI3YzNiNzE5ZTcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9z
b2Yvb3BzLmMKKysrIGIvc291bmQvc29jL3NvZi9vcHMuYwpAQCAtMTcsNyArMTcsNyBAQCBib29s
IHNuZF9zb2ZfcGNpX3VwZGF0ZV9iaXRzX3VubG9ja2VkKHN0cnVjdCBzbmRfc29mX2RldiAqc2Rl
diwgdTMyIG9mZnNldCwKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGNpID0gdG9fcGNpX2RldihzZGV2
LT5kZXYpOwogCXVuc2lnbmVkIGludCBvbGQsIG5ldzsKLQl1MzIgcmV0OworCXUzMiByZXQgPSAw
OwogCiAJcGNpX3JlYWRfY29uZmlnX2R3b3JkKHBjaSwgb2Zmc2V0LCAmcmV0KTsKIAlvbGQgPSBy
ZXQ7Ci0tIAoyLjE2LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
