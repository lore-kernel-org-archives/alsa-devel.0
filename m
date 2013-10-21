From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: kirkwood: cleanup the external clock
	probe
Date: Mon, 21 Oct 2013 09:46:13 +0200
Message-ID: <20131021094613.2a07bd79@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 5523B2655DD
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 09:45:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBjaGVja3MgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgY2xrX3ByZXBhcmVfZW5h
YmxlIG9mIHRoZQpleHRlcm5hbCBjbG9jayBhbmQgcmVtb3ZlcyB0aGUgdGVzdCBhYm91dCBhIHNh
bWUgaW50ZXJuYWwgYW5kIGV4dGVybmFsCmNsb2NrIHdoaWNoIHdvdWxkIHF1aXRlIG5ldmVyIG9j
Y3VyIGFuZCB3b24ndCB3b3JrIGluIG1vc3QgY2FzZXMKaXQgd291bGQgb2NjdXIuCgpTaWduZWQt
b2ZmLWJ5OiBKZWFuLUZyYW5jb2lzIE1vaW5lIDxtb2luZWpmQGZyZWUuZnI+Ci0tLQpUaGlzIHBh
dGNoIGFwcGxpZXMgYWdhaW5zdCBicm9vbmllL3NvdW5kIGZvci1uZXh0LgotLS0KIHNvdW5kL3Nv
Yy9raXJrd29vZC9raXJrd29vZC1pMnMuYyB8IDEzICsrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jLm9sZCBiL3NvdW5kL3NvYy9raXJrd29vZC9raXJr
d29vZC1pMnMuYy5wYXQyCmluZGV4IGQwNTA0YTIuLmMyNDMzZWEgMTAwNjQ0Ci0tLSBhL3NvdW5k
L3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYy5vbGQKKysrIGIvc291bmQvc29jL2tpcmt3b29k
L2tpcmt3b29kLWkycy5jLnBhdDIKQEAgLTUwMCwxNCArNTAwLDExIEBAIHN0YXRpYyBpbnQga2ly
a3dvb2RfaTJzX2Rldl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlpZiAo
UFRSX0VSUihwcml2LT5leHRjbGspID09IC1FUFJPQkVfREVGRVIpCiAJCQlyZXR1cm4gLUVQUk9C
RV9ERUZFUjsKIAl9IGVsc2UgewotCQlpZiAocHJpdi0+ZXh0Y2xrID09IHByaXYtPmNsaykgewot
CQkJZGV2bV9jbGtfcHV0KCZwZGV2LT5kZXYsIHByaXYtPmV4dGNsayk7Ci0JCQlwcml2LT5leHRj
bGsgPSBFUlJfUFRSKC1FSU5WQUwpOwotCQl9IGVsc2UgewotCQkJZGV2X2luZm8oJnBkZXYtPmRl
diwgImZvdW5kIGV4dGVybmFsIGNsb2NrXG4iKTsKLQkJCWNsa19wcmVwYXJlX2VuYWJsZShwcml2
LT5leHRjbGspOwotCQkJc29jX2RhaSA9ICZraXJrd29vZF9pMnNfZGFpX2V4dGNsazsKLQkJfQor
CQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiZm91bmQgZXh0ZXJuYWwgY2xvY2tcbiIpOworCQlyZXQg
PSBjbGtfcHJlcGFyZV9lbmFibGUocHJpdi0+ZXh0Y2xrKTsKKwkJaWYgKGVyciA8IDApCisJCQly
ZXR1cm4gZXJyOworCQlzb2NfZGFpID0ga2lya3dvb2RfaTJzX2RhaV9leHRjbGs7CiAJfQogCiAJ
LyogU29tZSBzZW5zaWJsZSBkZWZhdWx0cyAtIHRoaXMgcmVmbGVjdHMgdGhlIHBvd2VydXAgdmFs
dWVzICovCgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6aCBoYSBMaW51eCBh
dGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
