From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <rem@videolan.org>
Subject: [RESEND] [PATCH 0/3] Close alsa-lib file descriptors
	on exec
Date: Wed, 4 Nov 2009 20:38:09 +0200
Message-ID: <200911042038.09618.rem@videolan.org>
Reply-To: remi@remlab.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id BA6D710383A
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:38:10 +0100 (CET)
Received: from basile.remlab.net (cs27051160.pp.htv.fi [89.27.51.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: remi)
	by yop.chewa.net (Postfix) with ESMTPSA id 7E4C1346
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:38:10 +0100 (CET)
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

ICAgICAgICBIZWxsbywKClRoZSBkZXZpY2Ugbm9kZXMgb3BlbmVkIGJ5IGFsc2EtbGliIGFyZSBw
cml2YXRlLCBhbmQgYXJlIG5vdCBtZWFudCB0byBiZSB1c2VkIAphZnRlciBleGVjKCkuIFNldHRp
bmcgdGhlIGNsb3NlLW9uLWV4ZWMgZmxhZ3MgYXZvaWQgbGVha2luZyBkZXZpY2VzIGZpbGUgCmRl
c2NyaXB0b3JzIGludG8gdW5pbnRlbmRlZCBwcm9jZXNzZXMuIEZ1cnRoZXIgbW9yZSwgdGhlIExp
bnV4IGtlcm5lbCAKT19DTE9FWEVDIGZsYWcgaXMgdXNlZCBpZiBhdmFpbGFibGUgZm9yIGZ1bGx5
IHRocmVhZC1zYWZlIG9wZXJhdGlvbnMuCgogY29uZmlndXJlLmluICAgICAgICAgICAgIHwgICAg
MiArKwogaW5jbHVkZS9sb2NhbC5oICAgICAgICAgIHwgICAyMyArKysrKysrKysrKysrKysrKy0t
LS0tLQogc3JjL2NvbnRyb2wvY29udHJvbF9ody5jIHwgICAxMSAtLS0tLS0tLS0tLQogc3JjL2h3
ZGVwL2h3ZGVwX2h3LmMgICAgIHwgICAxMSAtLS0tLS0tLS0tLQogc3JjL3BjbS9wY21faHcuYyAg
ICAgICAgIHwgICAxMiAtLS0tLS0tLS0tLS0KIHNyYy9yYXdtaWRpL3Jhd21pZGlfaHcuYyB8ICAg
MTEgLS0tLS0tLS0tLS0KIHNyYy9zZXEvc2VxX2h3LmMgICAgICAgICB8ICAgMTEgLS0tLS0tLS0t
LS0KIHNyYy90aW1lci90aW1lcl9ody5jICAgICB8ICAgMTEgLS0tLS0tLS0tLS0KIDggZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pCgotLSAKUsOpbWkgRGVu
aXMtQ291cm1vbnQKaHR0cDovL3d3dy5yZW1sYWIubmV0LwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
