From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: remove duplicated remove
 callback
Date: Mon, 19 Mar 2018 13:15:45 +0200
Message-ID: <c51fd950-0f7a-15f7-afdf-7acdf13aaad6@ti.com>
References: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DA8D267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 12:15:41 +0100 (CET)
In-Reply-To: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE4LTAzLTE5IDA5OjUwLCBLdW5pbm9yaSBNb3JpbW90byB3cm90ZToKPiAKPiBGcm9t
OiBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+Cj4g
Cj4gV2UgZG9uJ3QgbmVlZCAyIC5yZW1vdmUgY2FsbGJhY2sKPiAKPiBGaXhlczogNzQ4MDM4OWZi
MGQ4ICgiQVNvQzogdHdsNjA0MDogcmVwbGFjZSBjb2RlYyB0byBjb21wb25lbnQiKQo+IFJlcG9y
dGVkLWJ5OiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBsaXA2LmZyPgo+IFJlcG9ydGVkLWJ5
OiBrYnVpbGQgdGVzdCByb2JvdCA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+
CgpBY2tlZC1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KCj4gLS0t
Cj4gIHNvdW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5jIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5j
IGIvc291bmQvc29jL2NvZGVjcy90d2w2MDQwLmMKPiBpbmRleCBiNTZhNjQ3Li5iZmQxYWJkIDEw
MDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvdHdsNjA0MC5jCj4gKysrIGIvc291bmQvc29j
L2NvZGVjcy90d2w2MDQwLmMKPiBAQCAtMTE1OCw3ICsxMTU4LDYgQEAgc3RhdGljIHZvaWQgdHds
NjA0MF9yZW1vdmUoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpCj4gIAkucmVt
b3ZlCQkJPSB0d2w2MDQwX3JlbW92ZSwKPiAgCS5yZWFkCQkJPSB0d2w2MDQwX3JlYWQsCj4gIAku
d3JpdGUJCQk9IHR3bDYwNDBfd3JpdGUsCj4gLQkucmVtb3ZlCQkJPSB0d2w2MDQwX3JlbW92ZSwK
PiAgCS5zZXRfYmlhc19sZXZlbAkJPSB0d2w2MDQwX3NldF9iaWFzX2xldmVsLAo+ICAJLmNvbnRy
b2xzCQk9IHR3bDYwNDBfc25kX2NvbnRyb2xzLAo+ICAJLm51bV9jb250cm9scwkJPSBBUlJBWV9T
SVpFKHR3bDYwNDBfc25kX2NvbnRyb2xzKSwKPiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50
cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMv
QnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
