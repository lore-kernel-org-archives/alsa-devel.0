From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Sat, 17 Dec 2016 09:39:01 +0900
Message-ID: <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id D9A6626760F
 for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2016 01:39:10 +0100 (CET)
In-Reply-To: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

UGluZyB0byBMaWFtLiBJIHdpc2ggdGhpcyBwYXRjaCB3b3VsZCBiZSBpbmNsdWRlZCB0byBuZXh0
IHJlbGVhc2Ugb2YKdGhpcyBsaWJyYXJ5LgoKT24gMjAxNuW5tDEx5pyIMzDml6UgMDA6NDQsIFRh
a2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gTGFzdCB5ZWFyLCB1bnVzZWQgc3RhdGljIGNvbnN0IHZh
cmlhYmxlIHdhcyBhZGRlZCwgdGhlbiBjb21waWxlciBnZW5lcmF0ZXMKPiBhIGJlbG93IHdhcm5p
bmcuCj4gCj4gZGFwbS5jOjQzOjMwOiB3YXJuaW5nOiDigJh3aWRnZXRfY29udHJvbF9tYXDigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtYXBfZWxlbSB3aWRnZXRfY29udHJvbF9tYXBbXSA9IHsKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPiAKPiBUaGlzIGNvbW1p
dCByZW1vdmVzIGl0Lgo+IAo+IEZpeGVzOiAwMWEwZTFhMWMyMTkgKCJ0b3BvbG9neTogQWRkIERB
UE0gb2JqZWN0IHBhcnNlciIpCj4gU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBTYWthbW90byA8by10
YWthc2hpQHNha2Ftb2NjaGkuanA+Cj4gLS0tCj4gIHNyYy90b3BvbG9neS9kYXBtLmMgfCA4IC0t
LS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9zcmMvdG9wb2xvZ3kvZGFwbS5jIGIvc3JjL3RvcG9sb2d5L2RhcG0uYwo+IGluZGV4IGU4MzA3
NTEuLjhjNTg1YTcgMTAwNjQ0Cj4gLS0tIGEvc3JjL3RvcG9sb2d5L2RhcG0uYwo+ICsrKyBiL3Ny
Yy90b3BvbG9neS9kYXBtLmMKPiBAQCAtMzksMTQgKzM5LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtYXBfZWxlbSB3aWRnZXRfbWFwW10gPSB7Cj4gIAl7ImRhaV9saW5rIiwgU05EX1NPQ19UUExH
X0RBUE1fREFJX0xJTkt9LAo+ICB9Owo+ICAKPiAtLyogbWFwcGluZyBvZiB3aWRnZXQga2NvbnRy
b2wgdGV4dCBuYW1lcyB0byB0eXBlcyAqLwo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG1hcF9lbGVt
IHdpZGdldF9jb250cm9sX21hcFtdID0gewo+IC0JeyJ2b2xzdyIsIFNORF9TT0NfVFBMR19EQVBN
X0NUTF9WT0xTV30sCj4gLQl7ImVudW1fZG91YmxlIiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX0VO
VU1fRE9VQkxFfSwKPiAtCXsiZW51bV92aXJ0IiwgU05EX1NPQ19UUExHX0RBUE1fQ1RMX0VOVU1f
VklSVH0sCj4gLQl7ImVudW1fdmFsdWUiLCBTTkRfU09DX1RQTEdfREFQTV9DVExfRU5VTV9WQUxV
RX0sCj4gLX07Cj4gLQo+ICBzdGF0aWMgaW50IGxvb2t1cF93aWRnZXQoY29uc3QgY2hhciAqdykK
PiAgewo+ICAJdW5zaWduZWQgaW50IGk7Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
