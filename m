From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] [PATCH] ASoC: acpi: fix machine driver
	selection based on quirk
Date: Wed,  3 Jan 2018 11:02:40 -0600
Message-ID: <20180103170242.5363-2-pierre-louis.bossart@linux.intel.com>
References: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 70C8B2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 18:02:51 +0100 (CET)
In-Reply-To: <20180103170242.5363-1-pierre-louis.bossart@linux.intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jeremy@jcline.org, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

VGhlIEFDUEkvbWFjaGluZS1kcml2ZXIgY29kZSByZWZhY3RvcmluZyBpbnRyb2R1Y2VkIGluIDQu
MTMgaW50cm9kdWNlZAphIHJlZ3Jlc3Npb24gZm9yIGNhc2VzIHdoZXJlIHdlIG5lZWQgYSBETUkt
YmFzZWQgcXVpcmsgdG8gc2VsZWN0IHRoZQptYWNoaW5lIGRyaXZlciAodGhlIEJJT1MgcmVwb3J0
cyBhbiBpbnZhbGlkIEhJRCkuIFRoZSBmaXggaXMganVzdCB0bwptYWtlIHN1cmUgdGhlIHJlc3Vs
dHMgb2YgdGhlIHF1aXJrIGFyZSBhY3R1YWxseSB1c2VkLgoKRml4ZXM6IDU0NzQ2ZGFiZjc3MCAo
J0FTb0M6IEltcHJvdmUgbWFjaGluZSBkcml2ZXIgc2VsZWN0aW9uIGJhc2VkIG9uIHF1aXJrIGRh
dGEnKQpCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD05NjY5MQpUZXN0ZWQtYnk6IE5pY29sZSBGw6ZyYmVyIDxuaWNvbGUuZmFlcmJlckBkcGluLmRl
PgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3Nh
cnRAbGludXguaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9zb2MtYWNwaS5jIHwgNiArKy0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL3NvYy1hY3BpLmMgYi9zb3VuZC9zb2Mvc29jLWFjcGkuYwppbmRleCBm
MjFkZjI4YmMyOGUuLmUxMDNmMzU3MWI1NSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3NvYy1hY3Bp
LmMKKysrIGIvc291bmQvc29jL3NvYy1hY3BpLmMKQEAgLTg0LDExICs4NCw5IEBAIHNuZF9zb2Nf
YWNwaV9maW5kX21hY2hpbmUoc3RydWN0IHNuZF9zb2NfYWNwaV9tYWNoICptYWNoaW5lcykKIAog
CWZvciAobWFjaCA9IG1hY2hpbmVzOyBtYWNoLT5pZFswXTsgbWFjaCsrKSB7CiAJCWlmIChzbmRf
c29jX2FjcGlfY2hlY2tfaGlkKG1hY2gtPmlkKSA9PSB0cnVlKSB7Ci0JCQlpZiAobWFjaC0+bWFj
aGluZV9xdWlyayA9PSBOVUxMKQotCQkJCXJldHVybiBtYWNoOwotCiAJCQlpZiAobWFjaC0+bWFj
aGluZV9xdWlyayhtYWNoKSAhPSBOVUxMKQotCQkJCXJldHVybiBtYWNoOworCQkJCW1hY2ggPSBt
YWNoLT5tYWNoaW5lX3F1aXJrKG1hY2gpOworCQkJcmV0dXJuIG1hY2g7CiAJCX0KIAl9CiAJcmV0
dXJuIE5VTEw7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
