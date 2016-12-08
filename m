From: Vinod Koul <vinod.koul@intel.com>
Subject: =?utf-8?q?=5BPATCH_07/14=5D_ASoC=3A_AMD=3A_remove_un?=
	=?utf-8?b?dXNlZCDigJhkbWFfYnVmZmVy4oCZ?=
Date: Thu,  8 Dec 2016 23:01:30 +0530
Message-ID: <1481218297-17568-8-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id D0BBF267519
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:31 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
List-Id: alsa-devel@alsa-project.org

SW4gYWNwX2RtYV9od19wYXJhbXMoKSwgJ2RtYV9idWZmZXInIGlzIGluaXRpYWxpemVkLCBidXQg
bm90IHVzZWQuIFNvCnJlbW92ZSBpdC4KCnNvdW5kL3NvYy9hbWQvYWNwLXBjbS1kbWEuYzogSW4g
ZnVuY3Rpb24g4oCYYWNwX2RtYV9od19wYXJhbXPigJk6CnNvdW5kL3NvYy9hbWQvYWNwLXBjbS1k
bWEuYzo2NzM6MjU6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGRtYV9idWZmZXLigJkgc2V0IGJ1dCBu
b3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KICBzdHJ1Y3Qgc25kX2RtYV9idWZm
ZXIgKmRtYV9idWZmZXI7CgpDYzogTWFydXRoaSBCYXl5YXZhcmFwdSA8bWFydXRoaS5iYXl5YXZh
cmFwdUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBWaW5vZCBLb3VsIDx2aW5vZC5rb3VsQGludGVs
LmNvbT4KLS0tCiBzb3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMgfCAzIC0tLQogMSBmaWxlIGNo
YW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2FtZC9hY3AtcGNt
LWRtYS5jIGIvc291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jCmluZGV4IDUwNGM3Y2Q3ZjU4YS4u
ODE4YjA1MjM3N2YzIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvYW1kL2FjcC1wY20tZG1hLmMKKysr
IGIvc291bmQvc29jL2FtZC9hY3AtcGNtLWRtYS5jCkBAIC02NzAsMTMgKzY3MCwxMCBAQCBzdGF0
aWMgaW50IGFjcF9kbWFfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLAogewogCWludCBzdGF0dXM7CiAJdWludDY0X3Qgc2l6ZTsKLQlzdHJ1Y3Qgc25kX2RtYV9i
dWZmZXIgKmRtYV9idWZmZXI7CiAJc3RydWN0IHBhZ2UgKnBnOwogCXN0cnVjdCBzbmRfcGNtX3J1
bnRpbWUgKnJ1bnRpbWU7CiAJc3RydWN0IGF1ZGlvX3N1YnN0cmVhbV9kYXRhICpydGQ7CiAKLQlk
bWFfYnVmZmVyID0gJnN1YnN0cmVhbS0+ZG1hX2J1ZmZlcjsKLQogCXJ1bnRpbWUgPSBzdWJzdHJl
YW0tPnJ1bnRpbWU7CiAJcnRkID0gcnVudGltZS0+cHJpdmF0ZV9kYXRhOwogCi0tIAoxLjkuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
