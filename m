From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoc: kirkwood: free the external clock when
 same as the internal one
Date: Sat, 27 Jul 2013 08:52:55 +0200
Message-ID: <20130727085255.29acb28c@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id AE108260291
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 08:52:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

IFNpZ25lZC1vZmYtYnk6IEplYW4tRnJhbmNvaXMgTW9pbmUgPG1vaW5lamZAZnJlZS5mcj4KLS0t
CnNvdW5kL3NvYy9raXJrd29vZC97a2lya3dvb2QtaTJzLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29v
ZC1pMnMuYyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYwppbmRleCBiYTcyMDM5
Li5iYmFkZjUzIDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJzLmN+
CisrKyBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYwpAQCAtNDk1LDYgKzQ5NSw3
IEBAIHN0YXRpYyBpbnQga2lya3dvb2RfaTJzX2Rldl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogCXByaXYtPmV4dGNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiZXh0
Y2xrIik7CiAJaWYgKCFJU19FUlIocHJpdi0+ZXh0Y2xrKSkgewogCQlpZiAocHJpdi0+ZXh0Y2xr
ID09IHByaXYtPmNsaykgeworCQkJZGV2bV9jbGtfcHV0KCZwZGV2LT5kZXYsIHByaXYtPmV4dGNs
ayk7CiAJCQlwcml2LT5leHRjbGsgPSBFUlJfUFRSKC1FSU5WQUwpOwogCQl9IGVsc2UgewogCQkJ
ZGV2X2luZm8oJnBkZXYtPmRldiwgImZvdW5kIGV4dGVybmFsIGNsb2NrXG4iKTsKCgotLSAKS2Vu
IGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJ
CWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
