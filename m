From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v4 01/12] vsprintf: factorize "(null)" string
Date: Sat,  7 Nov 2009 13:16:09 -0200
Message-ID: <643e6260a571b533d8985b377a82410aded4ddae.1257602781.git.andre.goddard__47848.3738065281$1257836996$gmane$org@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id C8E76244CA
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:19:02 +0100 (CET)
Received: by mail-pw0-f53.google.com with SMTP id 11so1898644pwj.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 07:19:02 -0800 (PST)
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

Q2hhbmdlICI8TlVMTD4iIHRvICIobnVsbCkiIGFuZCBtYWtlIGl0IGEgc3RhdGljIGNvbnN0IGNo
YXJbXSBob3BpbmcgdGhhdAp0aGUgY29tcGlsZXIgd2lsbCBtYWtlIG51bGxfc3RyIGEgbGFiZWwg
dG8gYSByZWFkLW9ubHkgYXJlYSBjb250YWluaW5nIGl0LgoKU2VlOgpodHRwOi8vcGVvcGxlLnJl
ZGhhdC5jb20vZHJlcHBlci9kc29ob3d0by5wZGYgcGFydCAyLjQuMgpodHRwOi8vdWRyZXBwZXIu
bGl2ZWpvdXJuYWwuY29tLzEzODUxLmh0bWwKaHR0cDovL3VkcmVwcGVyLmxpdmVqb3VybmFsLmNv
bS8xNTExOS5odG1sCgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5n
b2RkYXJkQGdtYWlsLmNvbT4KQWNrZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZ3ZWlzYmVj
QGdtYWlsLmNvbT4KLS0tCiBsaWIvdnNwcmludGYuYyB8ICAgMTAgKysrKysrLS0tLQogMSBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bGliL3ZzcHJpbnRmLmMgYi9saWIvdnNwcmludGYuYwppbmRleCAzM2JlZDVlLi4wMDJmNDYyIDEw
MDY0NAotLS0gYS9saWIvdnNwcmludGYuYworKysgYi9saWIvdnNwcmludGYuYwpAQCAtMzQsNiAr
MzQsOCBAQAogLyogV29ya3Mgb25seSBmb3IgZGlnaXRzIGFuZCBsZXR0ZXJzLCBidXQgc21hbGwg
YW5kIGZhc3QgKi8KICNkZWZpbmUgVE9MT1dFUih4KSAoKHgpIHwgMHgyMCkKIAorc3RhdGljIGNv
bnN0IGNoYXIgbnVsbF9zdHJbXSA9ICIobnVsbCkiOworCiBzdGF0aWMgdW5zaWduZWQgaW50IHNp
bXBsZV9ndWVzc19iYXNlKGNvbnN0IGNoYXIgKmNwKQogewogCWlmIChjcFswXSA9PSAnMCcpIHsK
QEAgLTU0NiwxMiArNTQ4LDEyIEBAIHN0YXRpYyBjaGFyICpudW1iZXIoY2hhciAqYnVmLCBjaGFy
ICplbmQsIHVuc2lnbmVkIGxvbmcgbG9uZyBudW0sCiAJcmV0dXJuIGJ1ZjsKIH0KIAotc3RhdGlj
IGNoYXIgKnN0cmluZyhjaGFyICpidWYsIGNoYXIgKmVuZCwgY2hhciAqcywgc3RydWN0IHByaW50
Zl9zcGVjIHNwZWMpCitzdGF0aWMgY2hhciAqc3RyaW5nKGNoYXIgKmJ1ZiwgY2hhciAqZW5kLCBj
b25zdCBjaGFyICpzLCBzdHJ1Y3QgcHJpbnRmX3NwZWMgc3BlYykKIHsKIAlpbnQgbGVuLCBpOwog
CiAJaWYgKCh1bnNpZ25lZCBsb25nKXMgPCBQQUdFX1NJWkUpCi0JCXMgPSAiPE5VTEw+IjsKKwkJ
cyA9IG51bGxfc3RyOwogCiAJbGVuID0gc3RybmxlbihzLCBzcGVjLnByZWNpc2lvbik7CiAKQEAg
LTgyMiw3ICs4MjQsNyBAQCBzdGF0aWMgY2hhciAqcG9pbnRlcihjb25zdCBjaGFyICpmbXQsIGNo
YXIgKmJ1ZiwgY2hhciAqZW5kLCB2b2lkICpwdHIsCiAJCQlzdHJ1Y3QgcHJpbnRmX3NwZWMgc3Bl
YykKIHsKIAlpZiAoIXB0cikKLQkJcmV0dXJuIHN0cmluZyhidWYsIGVuZCwgIihudWxsKSIsIHNw
ZWMpOworCQlyZXR1cm4gc3RyaW5nKGJ1ZiwgZW5kLCBudWxsX3N0ciwgc3BlYyk7CiAKIAlzd2l0
Y2ggKCpmbXQpIHsKIAljYXNlICdGJzoKQEAgLTE0NDUsNyArMTQ0Nyw3IEBAIGRvIHsJCQkJCQkJ
CQlcCiAJCQlzaXplX3QgbGVuOwogCQkJaWYgKCh1bnNpZ25lZCBsb25nKXNhdmVfc3RyID4gKHVu
c2lnbmVkIGxvbmcpLVBBR0VfU0laRQogCQkJCQl8fCAodW5zaWduZWQgbG9uZylzYXZlX3N0ciA8
IFBBR0VfU0laRSkKLQkJCQlzYXZlX3N0ciA9ICI8TlVMTD4iOworCQkJCXNhdmVfc3RyID0gbnVs
bF9zdHI7CiAJCQlsZW4gPSBzdHJsZW4oc2F2ZV9zdHIpOwogCQkJaWYgKHN0ciArIGxlbiArIDEg
PCBlbmQpCiAJCQkJbWVtY3B5KHN0ciwgc2F2ZV9zdHIsIGxlbiArIDEpOwotLSAKMS42LjUuMi4x
NTMuZzZlMzFmLmRpcnR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
