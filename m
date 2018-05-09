From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: davinci-mcasp: Use
 'snd_pcm_format_t' type
Date: Wed, 9 May 2018 23:49:34 +0300
Message-ID: <9b959bbd-9e66-ed45-e595-93e4ec6f62bd@ti.com>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
 <1525621665-11022-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 889C12676A7
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 22:50:56 +0200 (CEST)
In-Reply-To: <1525621665-11022-2-git-send-email-festevam@gmail.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAwNS8wNi8yMDE4IDA2OjQ3IFBNLCBGYWJpbyBFc3RldmFtIHdyb3RlOgo+IEZyb206
IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4KPiAKPiAnc25kX3BjbV9mb3Jt
YXRfdCcgdHlwZSBpcyBiZXR0ZXIgc3VpdGVkIGZvciBpdGVyYXRpbmcgdGhyb3VnaCB0aGUKPiBT
TkRSVl9QQ01fRk9STUFUIG1lbWJlcnMuCj4gCj4gQWxzbywgdXNlIFNORFJWX1BDTV9GT1JNQVRf
RklSU1QgZm9yIHRoZSBmaXJzdCBlbGVtZW50Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVz
dGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4KPiAtLS0KPiAgc291bmQvc29jL2RhdmluY2kv
ZGF2aW5jaS1tY2FzcC5jIHwgNSArKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZGF2aW5jaS9k
YXZpbmNpLW1jYXNwLmMgYi9zb3VuZC9zb2MvZGF2aW5jaS9kYXZpbmNpLW1jYXNwLmMKPiBpbmRl
eCAwM2JhMjE4Li5iZGUyMjUyIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9kYXZpbmNpL2Rhdmlu
Y2ktbWNhc3AuYwo+ICsrKyBiL3NvdW5kL3NvYy9kYXZpbmNpL2RhdmluY2ktbWNhc3AuYwo+IEBA
IC0xMjE0LDExICsxMjE0LDEyIEBAIHN0YXRpYyBpbnQgZGF2aW5jaV9tY2FzcF9od19ydWxlX2Zv
cm1hdChzdHJ1Y3Qgc25kX3BjbV9od19wYXJhbXMgKnBhcmFtcywKPiAgCXN0cnVjdCBzbmRfbWFz
ayBuZm10Owo+ICAJaW50IHJhdGUgPSBwYXJhbXNfcmF0ZShwYXJhbXMpOwo+ICAJaW50IHNsb3Rz
ID0gcmQtPm1jYXNwLT50ZG1fc2xvdHM7Cj4gLQlpbnQgaSwgY291bnQgPSAwOwo+ICsJc25kX3Bj
bV9mb3JtYXRfdCBpOwo+ICsJaW50IGNvdW50ID0gMDsKPiAgCj4gIAlzbmRfbWFza19ub25lKCZu
Zm10KTsKPiAgCj4gLQlmb3IgKGkgPSAwOyBpIDw9IFNORFJWX1BDTV9GT1JNQVRfTEFTVDsgaSsr
KSB7Cj4gKwlmb3IgKGkgPSBTTkRSVl9QQ01fRk9STUFUX0ZJUlNUOyBpIDw9IFNORFJWX1BDTV9G
T1JNQVRfTEFTVDsgaSsrKSB7Cj4gIAkJaWYgKHNuZF9tYXNrX3Rlc3QoZm10LCBpKSkgewoKc25k
X21hc2tfdGVzdChmbXQsIChfX2ZvcmNlIHVuc2lnbmVkIGludClpKQoKYW5kIHRoZSBzYW1lIGZv
ciB0aGUgc25kX21hc2tfc2V0KCkKCj4gIAkJCXVpbnQgc2JpdHMgPSBzbmRfcGNtX2Zvcm1hdF93
aWR0aChpKTsKPiAgCQkJaW50IHBwbTsKPiAKClBsZWFzZSBDQyBtZSBmb3IgZGF2aW5jaSBwYXRj
aGVzLCBJIHdvdWxkIGhhdmUgbWlzc2VkIHRoaXMgcGF0Y2ggaWYgTWFyayBkaWQKbm90IENDZCBt
ZS4KCi0tIApQw6l0ZXIKClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmth
dHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBL
b3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
