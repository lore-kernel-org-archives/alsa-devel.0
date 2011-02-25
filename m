From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] eukrea-tlv320: fix platform_name
Date: Fri, 25 Feb 2011 13:47:46 +0100
Message-ID: <1298638066-4049-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 26.mail-out.ovh.net (2.26.mail-out.ovh.net [178.33.107.8])
	by alsa0.perex.cz (Postfix) with SMTP id DC86C10390B
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:47:48 +0100 (CET)
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Y29tbWl0IGYwZmJhMmFkMWI2YjUzZDUzNjAxMjVjNDE5NTNiN2FmY2Q2ZGVmZjAgaW5jbHVkZWQg
YSBtaXN0YWtlCm9uIHRoZSBuYW1lIG9mIHRoZSBwbGF0Zm9ybSBpbiB0aGUgc25kX3NvY19kYWlf
bGluayBzdHJ1Y3R1cmUuCgpTaWduZWQtb2ZmLWJ5OiBFcmljIELDqW5hcmQgPGVyaWNAZXVrcmVh
LmNvbT4KLS0tCiBzb3VuZC9zb2MvaW14L2V1a3JlYS10bHYzMjAuYyB8ICAgIDIgKy0KIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9pbXgvZXVrcmVhLXRsdjMyMC5jIGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2
MzIwLmMKaW5kZXggZTIwYzllMS4uMWU5YmNjYSAxMDA2NDQKLS0tIGEvc291bmQvc29jL2lteC9l
dWtyZWEtdGx2MzIwLmMKKysrIGIvc291bmQvc29jL2lteC9ldWtyZWEtdGx2MzIwLmMKQEAgLTc5
LDcgKzc5LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGV1a3JlYV90bHYzMjBf
ZGFpID0gewogCS5uYW1lCQk9ICJ0bHYzMjBhaWMyMyIsCiAJLnN0cmVhbV9uYW1lCT0gIlRMVjMy
MEFJQzIzIiwKIAkuY29kZWNfZGFpX25hbWUJPSAidGx2MzIwYWljMjMtaGlmaSIsCi0JLnBsYXRm
b3JtX25hbWUJPSAiaW14LXBjbS1hdWRpby4wIiwKKwkucGxhdGZvcm1fbmFtZQk9ICJpbXgtZmlx
LXBjbS1hdWRpby4wIiwKIAkuY29kZWNfbmFtZQk9ICJ0bHYzMjBhaWMyMy1jb2RlYy4wLTAwMWEi
LAogCS5jcHVfZGFpX25hbWUJPSAiaW14LXNzaS4wIiwKIAkub3BzCQk9ICZldWtyZWFfdGx2MzIw
X3NuZF9vcHMsCi0tIAoxLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
