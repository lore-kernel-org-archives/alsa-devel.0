From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC: How to declare volume TLV dB scale?
Date: Fri, 12 Jun 2015 21:47:46 +0200
Message-ID: <557B3762.20603@ladisch.de>
References: <trinity-71513ec1-9daf-4f51-b0b3-8df7a0e9a7ec-1434110572856@3capp-gmx-bs58>
 <557B08C6.7030300@ladisch.de> <557B3260.30001@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DD524266A04
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 21:48:37 +0200 (CEST)
In-Reply-To: <557B3260.30001@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

U2VyZ2VqIFNhd2F6a2kgd3JvdGU6Cj4gT24gRnJpLCAxMiBKdW4gMjAxNSAxODoyODo1NCArMDIw
MCwgQ2xlbWVucyBMYWRpc2NoIHdyb3RlOgo+PiBTZXJnZWogU2F3YXpraSB3cm90ZToKPj4+IGNv
dWxkIHNvbWVvbmUgcGxlYXNlIGhlbHAgbWUgdG8gdW5kZXJzdGFuZCB0aGUgbWl4ZXIgY29udHJv
bHMgVExWIHNjYWxlPwo+Pj4gV2hhdCB3b3VsZCBiZSB0aGUgREVDTEFSRV9UTFZfREJfU0NBTEUg
dmFsdWVzIGZvciB0aGUgZm9sbG93aW5nIGV4YW1wbGU/Cj4+Pgo+Pj4gcmVnLiB2YWx1ZTogIDAg
ICAgLi4gIDB4M2ZmCj4+PiBwaHlzLiB2YWx1ZTogMGRCICAuLiAtMTI4ZEIKPj4+IHZvbHVtZTog
ICAgICAxMDAlIC4uICAwJShtdXRlKQo+Pgo+PiAwJSB2b2x1bWUgd291bGQgYmUgLeKIniBkQi4K
Pj4KPj4gQW5kIGhvdyBhcmUgdGhlIHJlZ2lzdGVyIHZhbHVlcyBtYXBwZWQgYmV0d2VlbiB0aGUg
bWluL21heCB2YWx1ZXM/Cj4+IERvZXMgMHgyMDAgY29ycmVzcG9uZCB0byAtNjQgZEIsIG9yIDUw
ICUgb2YgdGhlIHNhbXBsZSB2YWx1ZSwgb3IKPj4gNTAgJSBvZiB0aGUgdm9sdW1lPwo+Cj4gVGhl
IG91dHB1dCBvZiB0aGUgREFDIGNhbiBiZSBhdHRlbnVhdGVkIGluIDAuMTI1ZEIgc3RlcHMsIHNv
IDB4MjAwCj4gd291bGQgYmUgLTY0ZEIuCj4KPiByZWdpc3RlciB2YWx1ZSB8IGF0dGVudWF0aW9u
IGxldmVsIChkQikgfCB2b2x1bWUgKCUpCj4gLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLQo+ICAgMHgwMDAgICAgICAgIHwgICAgIDAuMCAgICAgICAg
ICAgICAgICB8ICAxMDAKPiAgIDB4MDAxICAgICAgICB8ICAgIC0wLjEyNSAgICAgICAgICAgICAg
fAo+ICAgIC4uLiAgICAgICAgIHwgICAgLi4uICAgICAgICAgICAgICAgICB8ICAuLi4KPiAgIDB4
MjAwICAgICAgICB8ICAgLTY0LjAgICAgICAgICAgICAgICAgfAo+ICAgIC4uLiAgICAgICAgIHwg
ICAgLi4uICAgICAgICAgICAgICAgICB8ICAuLi4KPiAgIDB4M2ZlICAgICAgICB8ICAtMTI3Ljc1
ICAgICAgICAgICAgICAgfAo+ICAgMHgzZmYgICAgICAgIHwgICAgLeKIniAobXV0ZSkgICAgICAg
ICAgIHwgICAgMAoKMC4xMjUgZEIgaXMgdG9vIHNtYWxsIGZvciB0aGUgMC4wMSBkQiByZXNvbHV0
aW9uIG9mIERFQ0xBUkVfVExWX0RCX1NDQUxFLApzbyB5b3UgaGF2ZSB0byB1c2UgREJfTUlOTUFY
IGluc3RlYWQ6ICBUTFZfREJfTUlOTUFYX01VVEVfSVRFTSgtMTI4LCAwKQoKClJlZ2FyZHMsCkNs
ZW1lbnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
