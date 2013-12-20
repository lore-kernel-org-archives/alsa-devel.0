From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/19] ASoC: s6000: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:19 +0100
Message-ID: <1387545625-19240-13-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D67C26565B
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:44 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

VGhlIEFTb0MgY29yZSBhc3N1bWVzIHRoYXQgdGhlIFBDTSBjb21wb25lbnQgb2YgdGhlIEFTb0Mg
Y2FyZCB0cmFuc3BhcmVudGx5Cm1vdmVzIGRhdGEgYXJvdW5kIGFuZCBkb2VzIG5vdCBpbXBvc2Ug
YW55IHJlc3RyaWN0aW9ucyBvbiB0aGUgbWVtb3J5IGxheW91dCBvcgp0aGUgdHJhbnNmZXIgc3Bl
ZWQuIEl0IGlnbm9yZXMgYWxsIGZpZWxkcyBmcm9tIHRoZSBzbmRfcGNtX2hhcmR3YXJlIHN0cnVj
dCBmb3IKdGhlIFBDTSBkcml2ZXIgdGhhdCBhcmUgcmVsYXRlZCB0byB0aGlzLiBTZXR0aW5nIHRo
ZXNlIGZpZWxkcyBpbiB0aGUgUENNIGRyaXZlcgptaWdodCBzdWdnZXN0IG90aGVyd2lzZSB0aG91
Z2gsIHNvIHJhdGhlciBub3Qgc2V0IHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBMYXJzLVBldGVyIENs
YXVzZW4gPGxhcnNAbWV0YWZvby5kZT4KQ2M6IERhbmllbCBHbMO2Y2tuZXIgPGRhbmllbC1nbEBn
bXgubmV0PgotLS0KIHNvdW5kL3NvYy9zNjAwMC9zNjAwMC1wY20uYyB8IDcgLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3M2MDAw
L3M2MDAwLXBjbS5jIGIvc291bmQvc29jL3M2MDAwL3M2MDAwLXBjbS5jCmluZGV4IGQyMTk4ODAu
LmZiODQ2MWUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9zNjAwMC9zNjAwMC1wY20uYworKysgYi9z
b3VuZC9zb2MvczYwMDAvczYwMDAtcGNtLmMKQEAgLTMzLDEzICszMyw2IEBAIHN0YXRpYyBzdHJ1
Y3Qgc25kX3BjbV9oYXJkd2FyZSBzNjAwMF9wY21faGFyZHdhcmUgPSB7CiAJLmluZm8gPSAoU05E
UlZfUENNX0lORk9fSU5URVJMRUFWRUQgfCBTTkRSVl9QQ01fSU5GT19CTE9DS19UUkFOU0ZFUiB8
CiAJCSBTTkRSVl9QQ01fSU5GT19NTUFQIHwgU05EUlZfUENNX0lORk9fTU1BUF9WQUxJRCB8CiAJ
CSBTTkRSVl9QQ01fSU5GT19QQVVTRSB8IFNORFJWX1BDTV9JTkZPX0pPSU5UX0RVUExFWCksCi0J
LmZvcm1hdHMgPSAoU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUgfCBTTkRSVl9QQ01fRk1UQklUX1Mz
Ml9MRSksCi0JLnJhdGVzID0gKFNORFJWX1BDTV9SQVRFX0NPTlRJTlVPVVMgfCBTTkRSVl9QQ01f
UkFURV81NTEyIHwgXAotCQkgIFNORFJWX1BDTV9SQVRFXzgwMDBfMTkyMDAwKSwKLQkucmF0ZV9t
aW4gPSAwLAotCS5yYXRlX21heCA9IDE1NjI1MDAsCi0JLmNoYW5uZWxzX21pbiA9IDIsCi0JLmNo
YW5uZWxzX21heCA9IDgsCiAJLmJ1ZmZlcl9ieXRlc19tYXggPSAweDdmZmZmZmYwLAogCS5wZXJp
b2RfYnl0ZXNfbWluID0gMTYsCiAJLnBlcmlvZF9ieXRlc19tYXggPSAweGZmZmZmMCwKLS0gCjEu
OC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
