From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <rem@videolan.org>
Subject: [PATCH alsa-lib 3/3] Define _GNU_SOURCE so that
	<fcntl.h> gives O_CLOEXEC
Date: Thu, 22 Oct 2009 18:01:28 +0300
Message-ID: <1256223688-3501-3-git-send-email-rem@videolan.org>
References: <1256223688-3501-1-git-send-email-rem@videolan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id B650E24407
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:01:32 +0200 (CEST)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 6C6777A5
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:01:31 +0200 (CEST)
In-Reply-To: <1256223688-3501-1-git-send-email-rem@videolan.org>
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

RnJvbTogUsOpbWkgRGVuaXMtQ291cm1vbnQgPHJlbWlAcmVtbGFiLm5ldD4KClRoaXMgZW5hYmxl
cyB0aHJlYWQtc2FmZSBjbG9zZS1vbi1leGVjIGZpbGUgZGVzY3JpcHRvciBmbGFnIHNldHRpbmcg
aWYKdGhlIHVuZGVybHlpbmcga2VybmVsIHN1cHBvcnRzIGl0LgoKU2lnbmVkLW9mZi1ieTogUsOp
bWkgRGVuaXMtQ291cm1vbnQgPHJlbWlAcmVtbGFiLm5ldD4KLS0tCiBjb25maWd1cmUuaW4gfCAg
ICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9jb25maWd1cmUuaW4gYi9jb25maWd1cmUuaW4KaW5kZXggYTQ1NWRlMS4u
Y2M4OTUwZiAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmluCisrKyBiL2NvbmZpZ3VyZS5pbgpAQCAt
MzgsNiArMzgsOCBAQCB0aGVuCiAgIEFDX01TR19SRVNVTFQoJENDKQogZmkKIAkgICAgCitDRkxB
R1M9IiRDRkxBR1MgLURfR05VX1NPVVJDRSIKKwogCiBBQ19QUk9HX0NDCiBBQ19QUk9HX0NQUAot
LSAKMS42LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
