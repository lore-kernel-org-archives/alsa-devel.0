From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/14] ASoC: Intel: sst: remove unused 'ops'
Date: Thu,  8 Dec 2016 23:01:26 +0530
Message-ID: <1481218297-17568-4-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D33267519
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:22 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4gc3N0X2ZyZWVfc3RyZWFtKCksIGEgdmFyaWFibGUgJ29wcycgaXMgaW5pdGlhbGl6ZWQgYnV0
Cm5vdCB1c2VkLiBTbyByZW1vdmUgaXQuCgpzb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3Qvc3N0X3N0
cmVhbS5jOiBJbiBmdW5jdGlvbiDigJhzc3RfZnJlZV9zdHJlYW3igJk6CnNvdW5kL3NvYy9pbnRl
bC9hdG9tL3NzdC9zc3Rfc3RyZWFtLmM6Mzk3OjI0OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhvcHPi
gJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KICBzdHJ1Y3Qg
aW50ZWxfc3N0X29wcyAqb3BzOwoKU2lnbmVkLW9mZi1ieTogVmlub2QgS291bCA8dmlub2Qua291
bEBpbnRlbC5jb20+Ci0tLQogc291bmQvc29jL2ludGVsL2F0b20vc3N0L3NzdF9zdHJlYW0uYyB8
IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9pbnRlbC9hdG9tL3NzdC9zc3Rfc3RyZWFtLmMgYi9zb3VuZC9zb2MvaW50ZWwvYXRvbS9z
c3Qvc3N0X3N0cmVhbS5jCmluZGV4IDUxYmRlZWVjYjdjOC4uODNkOGRkYTE1MjMzIDEwMDY0NAot
LS0gYS9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3Qvc3N0X3N0cmVhbS5jCisrKyBiL3NvdW5kL3Nv
Yy9pbnRlbC9hdG9tL3NzdC9zc3Rfc3RyZWFtLmMKQEAgLTM5NCw3ICszOTQsNiBAQCBpbnQgc3N0
X2ZyZWVfc3RyZWFtKHN0cnVjdCBpbnRlbF9zc3RfZHJ2ICpzc3RfZHJ2X2N0eCwgaW50IHN0cl9p
ZCkKIHsKIAlpbnQgcmV0dmFsID0gMDsKIAlzdHJ1Y3Qgc3RyZWFtX2luZm8gKnN0cl9pbmZvOwot
CXN0cnVjdCBpbnRlbF9zc3Rfb3BzICpvcHM7CiAKIAlkZXZfZGJnKHNzdF9kcnZfY3R4LT5kZXYs
ICJTU1QgREJHOnNzdF9mcmVlX3N0cmVhbSBmb3IgJWRcbiIsIHN0cl9pZCk7CiAKQEAgLTQwNyw3
ICs0MDYsNiBAQCBpbnQgc3N0X2ZyZWVfc3RyZWFtKHN0cnVjdCBpbnRlbF9zc3RfZHJ2ICpzc3Rf
ZHJ2X2N0eCwgaW50IHN0cl9pZCkKIAlzdHJfaW5mbyA9IGdldF9zdHJlYW1faW5mbyhzc3RfZHJ2
X2N0eCwgc3RyX2lkKTsKIAlpZiAoIXN0cl9pbmZvKQogCQlyZXR1cm4gLUVJTlZBTDsKLQlvcHMg
PSBzc3RfZHJ2X2N0eC0+b3BzOwogCiAJbXV0ZXhfbG9jaygmc3RyX2luZm8tPmxvY2spOwogCWlm
IChzdHJfaW5mby0+c3RhdHVzICE9IFNUUkVBTV9VTl9JTklUKSB7Ci0tIAoxLjkuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
