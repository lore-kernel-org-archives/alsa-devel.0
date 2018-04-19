From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/5] crecord: fix incorrect print specifier
	warning
Date: Thu, 19 Apr 2018 12:06:20 +0530
Message-ID: <1524119780-21206-5-git-send-email-vinod.koul@intel.com>
References: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E3D2676A6
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 08:31:57 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

V2UgZ2V0IGEgd2FybmluZyBpbiBjcmVjb3JkIGZvciBpbmNvcnJlY3QgcHJpbnQgc3BlY2lmaWVy
LCBmaXggaXQgYnkgdXNpbmcKcmlnaHQgb25lICV1IGZvciB1bnNpZ25lZCBpbnQKCmNyZWNvcmQu
YzozODA6MTc6IHdhcm5pbmc6IGZvcm1hdCDigJglbHXigJkgZXhwZWN0cyBhcmd1bWVudCBvZiB0
eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgNiBoYXMgdHlwZSDigJh1
bnNpZ25lZCBpbnTigJkgWy1XZm9ybWF0PV0KICBmcHJpbnRmKGZpbmZvLCAiUmVjb3JkaW5nIGZp
bGUgJXMgT24gQ2FyZCAldSBkZXZpY2UgJXUsIHdpdGggYnVmZmVyIG9mICVsdSBieXRlc1xuIiwK
ClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwgPHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0KIHNy
Yy91dGlscy9jcmVjb3JkLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvdXRpbHMvY3JlY29yZC5jIGIvc3JjL3V0
aWxzL2NyZWNvcmQuYwppbmRleCA4NzI4YzVkOWEzNmUuLmM1NWJhZTlmOGQ2ZSAxMDA2NDQKLS0t
IGEvc3JjL3V0aWxzL2NyZWNvcmQuYworKysgYi9zcmMvdXRpbHMvY3JlY29yZC5jCkBAIC0zNzcs
NyArMzc3LDcgQEAgc3RhdGljIHZvaWQgY2FwdHVyZV9zYW1wbGVzKGNoYXIgKm5hbWUsIHVuc2ln
bmVkIGludCBjYXJkLCB1bnNpZ25lZCBpbnQgZGV2aWNlLAogCQlnb3RvIGNvbXBfZXhpdDsKIAl9
CiAKLQlmcHJpbnRmKGZpbmZvLCAiUmVjb3JkaW5nIGZpbGUgJXMgT24gQ2FyZCAldSBkZXZpY2Ug
JXUsIHdpdGggYnVmZmVyIG9mICVsdSBieXRlc1xuIiwKKwlmcHJpbnRmKGZpbmZvLCAiUmVjb3Jk
aW5nIGZpbGUgJXMgT24gQ2FyZCAldSBkZXZpY2UgJXUsIHdpdGggYnVmZmVyIG9mICV1IGJ5dGVz
XG4iLAogCSAgICAgICBuYW1lLCBjYXJkLCBkZXZpY2UsIHNpemUpOwogCWZwcmludGYoZmluZm8s
ICJDb2RlYyAldSBGb3JtYXQgJXUgQ2hhbm5lbHMgJXUsICV1IEh6XG4iLAogCSAgICAgICBjb2Rl
Yy5pZCwgY29kZWMuZm9ybWF0LCBjb2RlYy5jaF9vdXQsIHJhdGUpOwotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
