From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <remi@remlab.net>
Subject: [PATCHv2 alsa-lib 0/3] Close-on-exec flag for device
	nodes
Date: Thu, 5 Nov 2009 21:16:53 +0200
Message-ID: <200911052116.53251.remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E5EB10395A
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:16:55 +0100 (CET)
Received: from basile.remlab.net (cs27051160.pp.htv.fi [89.27.51.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: remi)
	by yop.chewa.net (Postfix) with ESMTPSA id B580835F
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:16:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ICAgICAgICBIZWxsbywKClRoaXMgaXMgYmFzaWNhbGx5IHRoZSBzYW1lIHBhdGNoIHNlcmllcyBh
cyB5ZXN0ZXJkYXksIGJ1dCBhZGRyZXNzaW5nIExlbm5hcnQncyAKaXNzdWUuIENvbW1lbnRzIHdl
bGNvbWUuCgogY29uZmlndXJlLmluICAgICAgICAgICAgIHwgICAgMiArKwogaW5jbHVkZS9sb2Nh
bC5oICAgICAgICAgIHwgICAxNyArKysrKysrKysrKy0tLS0tLQogc3JjL2NvbnRyb2wvY29udHJv
bF9ody5jIHwgICAxMSAtLS0tLS0tLS0tLQogc3JjL2h3ZGVwL2h3ZGVwX2h3LmMgICAgIHwgICAx
MSAtLS0tLS0tLS0tLQogc3JjL3BjbS9wY21faHcuYyAgICAgICAgIHwgICAxMiAtLS0tLS0tLS0t
LS0KIHNyYy9yYXdtaWRpL3Jhd21pZGlfaHcuYyB8ICAgMTEgLS0tLS0tLS0tLS0KIHNyYy9zZXEv
c2VxX2h3LmMgICAgICAgICB8ICAgMTEgLS0tLS0tLS0tLS0KIHNyYy90aW1lci90aW1lcl9ody5j
ICAgICB8ICAgMTEgLS0tLS0tLS0tLS0KIDggZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgNzMgZGVsZXRpb25zKC0pCgoKLS0gClLDqW1pIERlbmlzLUNvdXJtb250Cmh0dHA6Ly93d3cu
cmVtbGFiLm5ldC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
