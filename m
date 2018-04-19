From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] cplay: remove dead code
	codec_name_from_id()
Date: Thu, 19 Apr 2018 12:06:17 +0530
Message-ID: <1524119780-21206-2-git-send-email-vinod.koul@intel.com>
References: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B422672B4
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 08:31:53 +0200 (CEST)
In-Reply-To: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

VGhlIGNvZGVjX25hbWVfZnJvbV9pZCgpIHdhcyBhZGRlZCBidXQgbmV2ZXIgdXNlZCBzbyByZW1v
dmUgaXQgYW5kCmVsaW1pbmF0ZSB1bnVzZWQgZnVuY3Rpb24gd2FybmluZwoKY3BsYXkuYzoxMDM6
MjA6IHdhcm5pbmc6IOKAmGNvZGVjX25hbWVfZnJvbV9pZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNl
ZCBbLVd1bnVzZWQtZnVuY3Rpb25dCgpXZSBjYW4gdGFrZSBmcm9tIGdpdCBpZiB1c2VyIGFwcGVh
cnMKClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwgPHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0K
Q0M6IEthdHN1aGlybyBTdXp1a2kgPHN1enVraS5rYXRzdWhpcm9Ac29jaW9uZXh0LmNvbT4KCiBz
cmMvdXRpbHMvY3BsYXkuYyB8IDE0IC0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3V0aWxzL2NwbGF5LmMgYi9zcmMvdXRpbHMv
Y3BsYXkuYwppbmRleCA5OGQ3MWEyMTk5ZGEuLmIwMjY0NGEzZjJlYSAxMDA2NDQKLS0tIGEvc3Jj
L3V0aWxzL2NwbGF5LmMKKysrIGIvc3JjL3V0aWxzL2NwbGF5LmMKQEAgLTEwMCwyMCArMTAwLDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7CiB9OwogI2RlZmluZSBDUExBWV9OVU1fQ09ERUNfSURT
IChzaXplb2YoY29kZWNfaWRzKSAvIHNpemVvZihjb2RlY19pZHNbMF0pKQogCi1zdGF0aWMgY29u
c3QgY2hhciAqY29kZWNfbmFtZV9mcm9tX2lkKHVuc2lnbmVkIGludCBpZCkKLXsKLQlzdGF0aWMg
Y2hhciBoZXhuYW1lWzEyXTsKLQlpbnQgaTsKLQotCWZvciAoaSA9IDA7IGkgPCBDUExBWV9OVU1f
Q09ERUNfSURTOyArK2kpIHsKLQkJaWYgKGNvZGVjX2lkc1tpXS5pZCA9PSBpZCkKLQkJCXJldHVy
biBjb2RlY19pZHNbaV0ubmFtZTsKLQl9Ci0KLQlzbnByaW50ZihoZXhuYW1lLCBzaXplb2YoaGV4
bmFtZSksICIweCV4IiwgaWQpOwotCXJldHVybiBoZXhuYW1lOyAvKiBhIHN0YXRpYyBpcyBzYWZl
IGJlY2F1c2Ugd2UncmUgc2luZ2xlLXRocmVhZGVkICovCi19Ci0KIHN0YXRpYyB2b2lkIHVzYWdl
KHZvaWQpCiB7CiAJaW50IGk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
