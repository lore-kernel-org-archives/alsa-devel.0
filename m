From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v4 07/12] vsprintf: factor out skip_space code
	in a separate function
Date: Sat,  7 Nov 2009 13:16:15 -0200
Message-ID: <7206ef594e67a240a842339f520284de6569b1fc.1257602781.git.andre.goddard__4529.77375030077$1257837059$gmane$org@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A921244F9
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:21:14 +0100 (CET)
Received: by pxi17 with SMTP id 17so551435pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 07:21:13 -0800 (PST)
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

SXQgZGVjcmVhc2VzIGNvZGUgc2l6ZToKICAgdGV4dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAg
ICAgaGV4IGZpbGVuYW1lCiAgMTU3MTkgICAgICAgMCAgICAgICA4ICAgMTU3MjcgICAgM2Q2ZiBs
aWIvdnNwcmludGYuby1iZWZvcmUKICAxNTU0MyAgICAgICAwICAgICAgIDggICAxNTU1MSAgICAz
Y2JmIGxpYi92c3ByaW50Zi5vLWFmdGVyCgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBS
b3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4KQWNrZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNr
ZXIgPGZ3ZWlzYmVjQGdtYWlsLmNvbT4KLS0tCiBsaWIvdnNwcmludGYuYyB8ICAgMTkgKysrKysr
KysrKystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi92c3ByaW50Zi5jIGIvbGliL3ZzcHJpbnRmLmMKaW5k
ZXggZjcwM2ZkZi4uNTY2Yzk0NyAxMDA2NDQKLS0tIGEvbGliL3ZzcHJpbnRmLmMKKysrIGIvbGli
L3ZzcHJpbnRmLmMKQEAgLTE3MzYsNiArMTczNiwxMyBAQCBFWFBPUlRfU1lNQk9MX0dQTChicHJp
bnRmKTsKIAogI2VuZGlmIC8qIENPTkZJR19CSU5BUllfUFJJTlRGICovCiAKK3N0YXRpYyBub2lu
bGluZSBjb25zdCBjaGFyICpza2lwX3NwYWNlKGNvbnN0IGNoYXIgKnN0cikKK3sKKwl3aGlsZSAo
aXNzcGFjZSgqc3RyKSkKKwkJKytzdHI7CisJcmV0dXJuIHN0cjsKK30KKwogLyoqCiAgKiB2c3Nj
YW5mIC0gVW5mb3JtYXQgYSBidWZmZXIgaW50byBhIGxpc3Qgb2YgYXJndW1lbnRzCiAgKiBAYnVm
OglpbnB1dCBidWZmZXIKQEAgLTE3NTcsMTAgKzE3NjQsOCBAQCBpbnQgdnNzY2FuZihjb25zdCBj
aGFyICpidWYsIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCBhcmdzKQogCQkgKiB3aGl0ZSBzcGFj
ZSwgaW5jbHVkaW5nIG5vbmUsIGluIHRoZSBpbnB1dC4KIAkJICovCiAJCWlmIChpc3NwYWNlKCpm
bXQpKSB7Ci0JCQl3aGlsZSAoaXNzcGFjZSgqZm10KSkKLQkJCQkrK2ZtdDsKLQkJCXdoaWxlIChp
c3NwYWNlKCpzdHIpKQotCQkJCSsrc3RyOworCQkJZm10ID0gc2tpcF9zcGFjZShmbXQpOworCQkJ
c3RyID0gc2tpcF9zcGFjZShzdHIpOwogCQl9CiAKIAkJLyogYW55dGhpbmcgdGhhdCBpcyBub3Qg
YSBjb252ZXJzaW9uIG11c3QgbWF0Y2ggZXhhY3RseSAqLwpAQCAtMTgzMCw4ICsxODM1LDcgQEAg
aW50IHZzc2NhbmYoY29uc3QgY2hhciAqYnVmLCBjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJn
cykKIAkJCWlmIChmaWVsZF93aWR0aCA9PSAtMSkKIAkJCQlmaWVsZF93aWR0aCA9IElOVF9NQVg7
CiAJCQkvKiBmaXJzdCwgc2tpcCBsZWFkaW5nIHdoaXRlIHNwYWNlIGluIGJ1ZmZlciAqLwotCQkJ
d2hpbGUgKGlzc3BhY2UoKnN0cikpCi0JCQkJc3RyKys7CisJCQlzdHIgPSBza2lwX3NwYWNlKHN0
cik7CiAKIAkJCS8qIG5vdyBjb3B5IHVudGlsIG5leHQgd2hpdGUgc3BhY2UgKi8KIAkJCXdoaWxl
ICgqc3RyICYmICFpc3NwYWNlKCpzdHIpICYmIGZpZWxkX3dpZHRoLS0pCkBAIC0xODczLDggKzE4
NzcsNyBAQCBpbnQgdnNzY2FuZihjb25zdCBjaGFyICpidWYsIGNvbnN0IGNoYXIgKmZtdCwgdmFf
bGlzdCBhcmdzKQogCQkvKiBoYXZlIHNvbWUgc29ydCBvZiBpbnRlZ2VyIGNvbnZlcnNpb24uCiAJ
CSAqIGZpcnN0LCBza2lwIHdoaXRlIHNwYWNlIGluIGJ1ZmZlci4KIAkJICovCi0JCXdoaWxlIChp
c3NwYWNlKCpzdHIpKQotCQkJc3RyKys7CisJCXN0ciA9IHNraXBfc3BhY2Uoc3RyKTsKIAogCQlk
aWdpdCA9ICpzdHI7CiAJCWlmIChpc19zaWduICYmIGRpZ2l0ID09ICctJykKLS0gCjEuNi41LjIu
MTUzLmc2ZTMxZi5kaXJ0eQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
