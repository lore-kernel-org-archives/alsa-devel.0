From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: kirkwood: Fix erroneous double output
	while playing
Date: Mon, 25 Nov 2013 20:19:05 +0100
Message-ID: <20131125201905.0d009921@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B944261B11
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 20:17:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: alsa-devel@alsa-project.org

VGhpcyBwYXRjaCBmaXhlcyB0aGUgc2V0dGluZyBvZiB0aGUgcmVnaXN0ZXIgS0lSS1dPT0RfUExB
WUNUTCB3aGljaCBkaWQKYWx3YXlzIHN0cmVhbWluZyBvbiBib3RoIEkyUyBhbmQgU1BESUYsIGln
bm9yaW5nIHRoZSBEQUkgSUQuCgpUaGUgYnVnIHdhcyBpbnRyb2R1Y2VkIGJ5IHRoZSBjb21taXQg
NzViOWI2NWVlNWEKICJBU29DOiBraXJrd29vZDogYWRkIFMvUERJRiBzdXBwb3J0IgoKU2lnbmVk
LW9mZi1ieTogSmVhbi1GcmFuY29pcyBNb2luZSA8bW9pbmVqZkBmcmVlLmZyPgotLS0KIHNvdW5k
L3NvYy9raXJrd29vZC9raXJrd29vZC1pMnMuYyB8IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2tpcmt3b29kL2tpcmt3b29kLWkycy5jIGIvc291bmQvc29jL2tpcmt3b29kL2tpcmt3b29k
LWkycy5jCmluZGV4IGQzNGQ5MTcuLmIyN2Y4MjYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9raXJr
d29vZC9raXJrd29vZC1pMnMuYworKysgYi9zb3VuZC9zb2Mva2lya3dvb2Qva2lya3dvb2QtaTJz
LmMKQEAgLTI0NCwxNSArMjQ0LDE1IEBAIHN0YXRpYyBpbnQga2lya3dvb2RfaTJzX3BsYXlfdHJp
Z2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAkJCQkgICBjdGwpOwog
CX0KIAotCWlmIChkYWktPmlkID09IDApCi0JCWN0bCAmPSB+S0lSS1dPT0RfUExBWUNUTF9TUERJ
Rl9FTjsJLyogaTJzICovCi0JZWxzZQotCQljdGwgJj0gfktJUktXT09EX1BMQVlDVExfSTJTX0VO
OwkvKiBzcGRpZiAqLwotCiAJc3dpdGNoIChjbWQpIHsKIAljYXNlIFNORFJWX1BDTV9UUklHR0VS
X1NUQVJUOgogCQkvKiBjb25maWd1cmUgKi8KIAkJY3RsID0gcHJpdi0+Y3RsX3BsYXk7CisJCWlm
IChkYWktPmlkID09IDApCisJCQljdGwgJj0gfktJUktXT09EX1BMQVlDVExfU1BESUZfRU47CS8q
IGkycyAqLworCQllbHNlCisJCQljdGwgJj0gfktJUktXT09EX1BMQVlDVExfSTJTX0VOOwkvKiBz
cGRpZiAqLworCiAJCXZhbHVlID0gY3RsICYgfktJUktXT09EX1BMQVlDVExfRU5BQkxFX01BU0s7
CiAJCXdyaXRlbCh2YWx1ZSwgcHJpdi0+aW8gKyBLSVJLV09PRF9QTEFZQ1RMKTsKIAoKLS0gCktl
biBhciBjJ2hlbnRhw7EJfAkgICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEgKioKSmVmCQl8
CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZyLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
