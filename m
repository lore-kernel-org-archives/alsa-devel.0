From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: sst-bxt-da7219_max98357a: fix
 obsoleted initializer for array
Date: Tue, 18 Oct 2016 20:16:38 +0900
Message-ID: <98283b5c-0ddb-c2c6-0ac7-352c47ed5835@sakamocchi.jp>
References: <20161017220256.32008-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E85792614A0
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 13:16:42 +0200 (CEST)
In-Reply-To: <20161017220256.32008-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Vinod Koul <vinod.koul@intel.com>, Yong Zhi <yong.zhi@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDEw5pyIMTjml6UgMDc6MDIsIENvbGluIEtpbmcgd3JvdGU6Cj4gRnJvbTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPiAKPiBTbWF0Y2ggcmVwb3J0
cyBiZWxvdyB3YXJuaW5nczoKPiAKPiAgICAgYnh0X2RhNzIxOV9tYXg5ODM1N2EuYzozNTI6OTog
d2FybmluZzogb2Jzb2xldGUgYXJyYXkgaW5pdGlhbGl6ZXIsCj4gICAgIHVzZSBDOTkgc3ludGF4
Cj4gCj4gQW4gZWFybGllciBjb21taXQgY2xlYW5lZCB1cCBzaW1pbGFyIHdhcm5pbmdzLCBob3dl
dmVyLCBhIHJlY2VudAo+IGNvbW1pdCA0M2MwMmVkZTc2YTYwZGUgKCJBU29DOiBJbnRlbDogQWRk
IERNSUMgY2hhbm5lbCBjb25zdHJhaW50IGZvcgo+IGJ4dCBtYWNoaW5lIikgcmUtaW50cm9kdWNl
ZCB0aGUgb2xkZXIgaW5pdGlhbGl6ZXIgc3R5bGUuIFNvIGZpeAo+IHRoaXMgd2FybmluZyB0byBt
YWtlIHRoZSBjb2RlIGNvbnNpc3RlbnQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPiAtLS0KPiAgc291bmQvc29jL2ludGVsL2Jv
YXJkcy9ieHRfZGE3MjE5X21heDk4MzU3YS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKClJldmlld2VkLWJ5OiBUYWthc2hpIFNha2Ftb3Rv
IDxvLXRha2FzaGlAc2FrYW1vY2NoaS5qcD4KCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbnRl
bC9ib2FyZHMvYnh0X2RhNzIxOV9tYXg5ODM1N2EuYyBiL3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMv
Ynh0X2RhNzIxOV9tYXg5ODM1N2EuYwo+IGluZGV4IDg2NWEyMWUuLmJmZjgwYjQgMTAwNjQ0Cj4g
LS0tIGEvc291bmQvc29jL2ludGVsL2JvYXJkcy9ieHRfZGE3MjE5X21heDk4MzU3YS5jCj4gKysr
IGIvc291bmQvc29jL2ludGVsL2JvYXJkcy9ieHRfZGE3MjE5X21heDk4MzU3YS5jCj4gQEAgLTM0
OCw3ICszNDgsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgYnJveHRvbl9kYWlz
W10gPSB7Cj4gIAkJLmR5bmFtaWMgPSAxLAo+ICAJCS5vcHMgPSAmYnJveHRvbl9yZWZjYXBfb3Bz
LAo+ICAJfSwKPiAtCVtCWFRfRFBDTV9BVURJT19ETUlDX0NQXQo+ICsJW0JYVF9EUENNX0FVRElP
X0RNSUNfQ1BdID0KPiAgCXsKPiAgCQkubmFtZSA9ICJCeHQgQXVkaW8gRE1JQyBjYXAiLAo+ICAJ
CS5zdHJlYW1fbmFtZSA9ICJkbWljY2FwIiwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
