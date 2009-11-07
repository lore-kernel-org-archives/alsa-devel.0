From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v4 05/12] vsprintf: reduce code size by
	avoiding extra check
Date: Sat,  7 Nov 2009 13:16:13 -0200
Message-ID: <b0346179f5cde5983cd0e020fa1b6f06ba6976d1.1257602781.git.andre.goddard__42169.0474766821$1257837041$gmane$org@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B5CC244CA
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:20:30 +0100 (CET)
Received: by pxi17 with SMTP id 17so551250pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 07:20:27 -0800 (PST)
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-f>
Cc: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
List-Id: alsa-devel@alsa-project.org

Tm8gZnVuY3Rpb25hbCBjaGFuZ2UsIGp1c3QgcmVmYWN0b3IgdGhlIGNvZGUgc28gdGhhdCBpdCBh
dm9pZCBjaGVja2luZwoiaWYgKGhpKSIgdHdvIHRpbWVzIGluIGEgc2VxdWVuY2UsIHRha2luZyBh
ZHZhbnRhZ2Ugb2YgcHJldmlvdXMgY2hlY2sgbWFkZS4KCkl0IGFsc28gcmVkdWNlcyBjb2RlIHNp
emU6CiAgIHRleHQgICAgZGF0YSAgICAgYnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZQogIDE1
NzM1ICAgICAgIDAgICAgICAgOCAgIDE1NzQzICAgIDNkN2YgbGliL3ZzcHJpbnRmLm8tYmVmb3Jl
CiAgMTU3MTkgICAgICAgMCAgICAgICA4ICAgMTU3MjcgICAgM2Q2ZiBsaWIvdnNwcmludGYuby1t
aW51cy1kb3VibGUtY2hlY2sKClNpZ25lZC1vZmYtYnk6IEFuZHLDqSBHb2RkYXJkIFJvc2EgPGFu
ZHJlLmdvZGRhcmRAZ21haWwuY29tPgpBY2tlZC1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8Zndl
aXNiZWNAZ21haWwuY29tPgotLS0KIGxpYi92c3ByaW50Zi5jIHwgICAgMyArKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xp
Yi92c3ByaW50Zi5jIGIvbGliL3ZzcHJpbnRmLmMKaW5kZXggMTRlNDE5Ny4uYWY3OTE1MiAxMDA2
NDQKLS0tIGEvbGliL3ZzcHJpbnRmLmMKKysrIGIvbGliL3ZzcHJpbnRmLmMKQEAgLTc0Nyw4ICs3
NDcsOSBAQCBzdGF0aWMgY2hhciAqaXA2X2NvbXByZXNzZWRfc3RyaW5nKGNoYXIgKnAsIGNvbnN0
IGNoYXIgKmFkZHIpCiAJCQkJcCA9IHBhY2tfaGV4X2J5dGUocCwgaGkpOwogCQkJZWxzZQogCQkJ
CSpwKysgPSBoZXhfYXNjX2xvKGhpKTsKKwkJCXAgPSBwYWNrX2hleF9ieXRlKHAsIGxvKTsKIAkJ
fQotCQlpZiAoaGkgfHwgbG8gPiAweDBmKQorCQllbHNlIGlmIChsbyA+IDB4MGYpCiAJCQlwID0g
cGFja19oZXhfYnl0ZShwLCBsbyk7CiAJCWVsc2UKIAkJCSpwKysgPSBoZXhfYXNjX2xvKGxvKTsK
LS0gCjEuNi41LjIuMTUzLmc2ZTMxZi5kaXJ0eQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
