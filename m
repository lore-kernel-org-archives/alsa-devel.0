From: "Rémi Denis-Courmont" <remi@basile.remlab.net>
Subject: [PATCH alsa-lib 3/3] Define _GNU_SOURCE so that
	<fcntl.h> gives O_CLOEXEC
Date: Thu, 22 Oct 2009 17:49:17 +0300
Message-ID: <1256222957-24059-3-git-send-email-remi@remlab.net>
References: <1256222957-24059-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 58CB124399
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:49:22 +0200 (CEST)
Received: from basile.remlab.net (localhost.localdomain [127.0.0.1])
	by yop.chewa.net (Postfix) with SMTP id 1A1357A5
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:49:21 +0200 (CEST)
In-Reply-To: <1256222957-24059-1-git-send-email-remi@remlab.net>
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

VGhpcyBlbmFibGVzIHRocmVhZC1zYWZlIGNsb3NlLW9uLWV4ZWMgZmlsZSBkZXNjcmlwdG9yIGZs
YWcgc2V0dGluZyBpZgp0aGUgdW5kZXJseWluZyBrZXJuZWwgc3VwcG9ydHMgaXQuCgpTaWduZWQt
b2ZmLWJ5OiBSw6ltaSBEZW5pcy1Db3VybW9udCA8cmVtaUByZW1sYWIubmV0PgotLS0KIGNvbmZp
Z3VyZS5pbiB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5pbiBiL2NvbmZpZ3VyZS5pbgppbmRl
eCBhNDU1ZGUxLi5jYzg5NTBmIDEwMDY0NAotLS0gYS9jb25maWd1cmUuaW4KKysrIGIvY29uZmln
dXJlLmluCkBAIC0zOCw2ICszOCw4IEBAIHRoZW4KICAgQUNfTVNHX1JFU1VMVCgkQ0MpCiBmaQog
CSAgICAKK0NGTEFHUz0iJENGTEFHUyAtRF9HTlVfU09VUkNFIgorCiAKIEFDX1BST0dfQ0MKIEFD
X1BST0dfQ1BQCi0tIAoxLjYuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
