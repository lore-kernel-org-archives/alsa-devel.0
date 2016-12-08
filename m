From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/14] ASoC: max98090: remove superflous check
	for 'micbias'
Date: Thu,  8 Dec 2016 23:01:29 +0530
Message-ID: <1481218297-17568-7-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 681432674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:30 +0100 (CET)
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

SW4gbWF4OTgwOTBfcHJvYmUoKSwgY29kZSBjaGVja3MgZm9yIG1pY2JpYXMgYmVpbmcgb3V0IG9m
IHJhbmdlLiBUaGUKJ21pY2JpYXMnIHZhcmlhYmxlIGluIHVuc2lnbmVkIGFuZCBjaGVja2VkIGFn
YWluc3QgTTk4MDkwX01CVlNFTF8yVjIgd2hpY2gKaXMgemVybywgc28gcmVtb3ZlIHRoaXMgY2hl
Y2suCgpzb3VuZC9zb2MvY29kZWNzL21heDk4MDkwLmM6IEluIGZ1bmN0aW9uIOKAmG1heDk4MDkw
X3Byb2Jl4oCZOgpzb3VuZC9zb2MvY29kZWNzL21heDk4MDkwLmM6MjQ1OToyOiB3YXJuaW5nOiBj
b21wYXJpc29uIG9mIHVuc2lnbmVkIGV4cHJlc3Npb24gPCAwIGlzIGFsd2F5cyBmYWxzZSBbLVd0
eXBlLWxpbWl0c10KICB9IGVsc2UgaWYgKG1pY2JpYXMgPCBNOTgwOTBfTUJWU0VMXzJWMiB8fCBt
aWNiaWFzID4gTTk4MDkwX01CVlNFTF8yVjgpIHsKClNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwg
PHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvbWF4OTgwOTAuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgwOTAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mv
bWF4OTgwOTAuYwppbmRleCA1ODRhYWI4M2U0NzguLjY2ODI4NDgwZDQ4NCAxMDA2NDQKLS0tIGEv
c291bmQvc29jL2NvZGVjcy9tYXg5ODA5MC5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvbWF4OTgw
OTAuYwpAQCAtMjQ1Niw3ICsyNDU2LDcgQEAgc3RhdGljIGludCBtYXg5ODA5MF9wcm9iZShzdHJ1
Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMpCiAJaWYgKGVycikgewogCQltaWNiaWFzID0gTTk4MDkw
X01CVlNFTF8yVjg7CiAJCWRldl9pbmZvKGNvZGVjLT5kZXYsICJ1c2UgZGVmYXVsdCAyLjh2IG1p
Y2JpYXNcbiIpOwotCX0gZWxzZSBpZiAobWljYmlhcyA8IE05ODA5MF9NQlZTRUxfMlYyIHx8IG1p
Y2JpYXMgPiBNOTgwOTBfTUJWU0VMXzJWOCkgeworCX0gZWxzZSBpZiAobWljYmlhcyA+IE05ODA5
MF9NQlZTRUxfMlY4KSB7CiAJCWRldl9lcnIoY29kZWMtPmRldiwgIm1pY2JpYXMgb3V0IG9mIHJh
bmdlIDB4JXhcbiIsIG1pY2JpYXMpOwogCQltaWNiaWFzID0gTTk4MDkwX01CVlNFTF8yVjg7CiAJ
fQotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
