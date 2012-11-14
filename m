From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <remi@remlab.net>
Subject: [PATCH 0/2] alsa-plugins: fix PulseAudio prebuf
Date: Wed, 14 Nov 2012 20:07:19 +0200
Message-ID: <201211142007.19751@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A01926173E
 for <Alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 19:07:21 +0100 (CET)
Received: from leon.localnet (cs27062151.pp.htv.fi [89.27.62.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: remi)
 by oyp.chewa.net (Postfix) with ESMTPSA id 1211220199
 for <Alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 19:07:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CUhlbGxvLAoKVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5ZGY1ZGM3ZGQ2Mjhi
MGQ2OTJjZjg5NmMyMTBhMTM0ZTg1ZTg4OTE1OgoKICBSZWxlYXNlIHYxLjAuMjYgKDIwMTItMDkt
MDYgMDk6NTI6NTggKzAyMDApCgptYWtlIHRoZSBBTFNBPC0+UHVsc2VBdWRpbyBQQ00gcGx1Z2lu
IGFiaWRlIGJ5IHN3X3BhcmFtcy4gVGhpcyBmaXhlcwpmcmVxdWVudGx5IGJyb2tlbiBwbGF5YmFj
ayB3aXRoIFZMQywgb3IgcG90ZW50aWFsbHkgYW55IG90aGVyCmFwcGxpY2F0aW9uIHRoYXQgZXhw
ZWN0cyBwbGF5YmFjayB0byBzdGFydCB3aXRoaW4gYSBzaG9ydCBvciBjb25maWd1cmVkIHRpbWUu
CgpCZXN0IHJlZ2FyZHMsCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClLDqW1pIERlbmlzLUNvdXJtb250ICgyKToKICAgICAg
cGNtX3B1bHNlOiBkbyBub3QgdHJpZ2dlciBpbW1lZGlhdGVseSBhdCBzdGFydAogICAgICBwY21f
cHVsc2U6IHNldCBwcmVidWYgcGFyYW1ldGVyIGFjY29yZGluZyB0byBzb2Z0d2FyZSBwYXJhbWV0
ZXJzCgogcHVsc2UvcGNtX3B1bHNlLmMgfCAgIDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQoKLS0gClLDqW1pIERlbmlzLUNvdXJtb250Cmh0dHA6Ly93d3cucmVtbGFiLm5ldC8KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
