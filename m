From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3 v4] mfd: arizona: Export function to
 control subsystem DVFS
Date: Fri, 25 Jul 2014 15:17:55 +0100
Message-ID: <20140725141755.GJ7063@lee--X1>
References: <1404313973-1030-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1404313973-1030-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140709140801.GA2635@lee--X1>
 <20140709144624.GB21251@opensource.wolfsonmicro.com>
 <20140725130520.GB2391@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA4E2651EE
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 16:18:06 +0200 (CEST)
Received: by mail-ig0-f180.google.com with SMTP id l13so838315iga.13
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 07:18:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140725130520.GB2391@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: sameo@linux.intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAyNSBKdWwgMjAxNCwgQ2hhcmxlcyBLZWVwYXggd3JvdGU6Cgo+IE9uIFdlZCwgSnVs
IDA5LCAyMDE0IGF0IDAzOjQ2OjI0UE0gKzAxMDAsIENoYXJsZXMgS2VlcGF4IHdyb3RlOgo+ID4g
T24gV2VkLCBKdWwgMDksIDIwMTQgYXQgMDM6MDg6MDFQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gPiBPbiBXZWQsIDAyIEp1bCAyMDE0LCBDaGFybGVzIEtlZXBheCB3cm90ZToKPiA+ID4g
Cj4gPiA+ID4gRnJvbTogUmljaGFyZCBGaXR6Z2VyYWxkIDxyZkBvcGVuc291cmNlLndvbGZzb25t
aWNyby5jb20+Cj4gPiA+ID4gCj4gPiA+ID4gTW92aW5nIHRoaXMgY29udHJvbCBmcm9tIGJlaW5n
IGEgc2lkZS1lZmZlY3Qgb2YgdGhlIExETzEKPiA+ID4gPiByZWd1bGF0b3IgZHJpdmVyIHRvIGEg
c3BlY2lmaWMgZXhwb3J0ZWQgZnVuY3Rpb24uCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBGaXR6Z2VyYWxkIDxyZkBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+Cj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlcyBLZWVwYXggPGNrZWVwYXhAb3BlbnNvdXJjZS53
b2xmc29ubWljcm8uY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL21mZC9hcml6b25h
LWNvcmUuYyAgICAgICB8ICAgODkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiA+ID4gPiAgaW5jbHVkZS9saW51eC9tZmQvYXJpem9uYS9jb3JlLmggfCAgIDEyICsrKysr
Cj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCj4gPiA+IAo+ID4gPiBQYXRjaCBsb29rcyBva2F5IHRvIG1lIG5vdy4gIElzIGl0IG9rYXkg
dG8gYXBwbHkgaXQgb24gaXRzIG93bj8KPiA+IAo+ID4gVGhlIGxhdGVyIHR3byBwYXRjaGVzIGRl
cGVuZCBvbiBpdCAoYnVpbGQgd2lsbCBicmVhayBvdGhlcndpc2UpCj4gPiBzbyBpdCBtaWdodCBi
ZSBlYXNpZXN0IGlmIHRoZXkgYWxsIGdvIHRocm91Z2ggdGhlIHNhbWUgdHJlZS4KPiAKPiBQcm9i
YWJseSBkdWUgYSByZXNlbmQgb24gdGhpcyBzZXJpZXMuIERvZXMgYW55b25lIGhhdmUgYW55IHN0
cm9uZwo+IG9waW5pb25zIG9uIHdoYXQgdHJlZSB0aGV5IHdhbnQgaXQgdG8gZ28gdGhyb3VnaD8K
CkkgY2FuIHRha2UgaXQgd2l0aCBNYWludGFpbmVyIEFja3MuCgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
