From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 3/3] Define _GNU_SOURCE so that <fcntl.h> gives
	O_CLOEXEC
Date: Thu,  5 Nov 2009 21:17:42 +0200
Message-ID: <1257448662-5124-3-git-send-email-remi@remlab.net>
References: <200911052116.53251.remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id A7300103978
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:17:46 +0100 (CET)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 40A56510
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:17:45 +0100 (CET)
In-Reply-To: <200911052116.53251.remi@remlab.net>
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
List-Id: alsa-devel@alsa-project.org

U2lnbmVkLW9mZi1ieTogUsOpbWkgRGVuaXMtQ291cm1vbnQgPHJlbWlAcmVtbGFiLm5ldD4KLS0t
CiBjb25maWd1cmUuaW4gfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb25maWd1cmUuaW4gYi9jb25maWd1cmUu
aW4KaW5kZXggYTQ1NWRlMS4uY2M4OTUwZiAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmluCisrKyBi
L2NvbmZpZ3VyZS5pbgpAQCAtMzgsNiArMzgsOCBAQCB0aGVuCiAgIEFDX01TR19SRVNVTFQoJEND
KQogZmkKIAkgICAgCitDRkxBR1M9IiRDRkxBR1MgLURfR05VX1NPVVJDRSIKKwogCiBBQ19QUk9H
X0NDCiBBQ19QUk9HX0NQUAotLSAKMS42LjUuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
