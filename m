From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about the buffer length in the
	transfer	callback of the PCM External Plugin
Date: Thu, 3 Nov 2016 15:44:29 +0100
Message-ID: <23292d9e-2fb6-1805-96c8-b2d5fa336665@ladisch.de>
References: <a68475dd084f4a45b224791224c7c244@LGNMSXB01.prod.bk.dfs>
 <19904f93-f0ba-56a9-2980-ed52fe2a32bb@ladisch.de>
 <6c2af613d3b64138bc6e7c6cf69486cf@LGNMSXB01.prod.bk.dfs>
 <2dc2c73c-9d7c-3d3e-4d23-9797de2d1ec4@ladisch.de>
 <165e6496dc554e18836006a6b77461ce@LGNMSXB01.prod.bk.dfs>
 <93708608-9498-de05-9256-d650a44e18d8@ladisch.de>
 <1ce46f88056b4b2caa2ecf770da07d76@LGNMSXB01.prod.bk.dfs>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E7F2D26648D
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 15:44:30 +0100 (CET)
In-Reply-To: <1ce46f88056b4b2caa2ecf770da07d76@LGNMSXB01.prod.bk.dfs>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bach, Andrea" <andrea.bach@dfs.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SSBtZWFuLCB3aGF0IGlzIHRoYXQgdGhpbmcgdGhhdCB5b3UncmUgaW50ZXJmYWNpbmcgQUxTQSB3
aXRoPwpPYnZpb3VzbHksIGl0IHNvbWVob3cgZ2VuZXJhdGVzIHNhbXBsZXMsIGJ1dCBob3cgZXhh
Y3RseT8KCgpSZWdhcmRzLApDbGVtZW5zCgpCYWNoLCBBbmRyZWEgd3JvdGU6Cj4gTW1oIC0gSSBn
ZXQgdGhlbSBmcm9tIHRoZSBidWZmZXIgYXJndW1lbnQgb2YgdGhlIHRyYW5zZmVyIGNhbGxiYWNr
IG9mIHRoZSBQQ00gZXh0ZXJuYWwgcGx1Z2luLgo+IEkgZG8gbm90IGhhdmUgYSBzZWNvbmQgc291
cmNlLi4uIG1heWJlIEkgbWlzc2VkIHRoZSAibWFpbiB0aGluZyIgc28gaXMgdGhlcmUgYW4gZXhh
bXBsZSBvZiBhIFBDTSBleHRlcm5hbCBwbHVnaW4gSSBjYW4gbG9vayBhdD8KPgo+IFRoYW5rIHlv
dQo+IEFuZHJlYQo+Cj4+IGhvdyBjYW4gSSB3YWl0IGluc2lkZSB0aGUgdHJhbnNmZXIgY2FsbGJh
Y2sgdW50aWwgdGhlIG5leHQgYnl0ZXMgYXJlIGF2YWlsYWJsZS4uLgo+Cj4gVGhhdCBkZXBlbmRz
IG9uIHdoZXJlIHlvdSBnZXQgdGhlIGJ5dGVzIGZyb20uCj4KPgo+IFJlZ2FyZHMsCj4gQ2xlbWVu
cwo+IERGUyBEZXV0c2NoZSBGbHVnc2ljaGVydW5nIEdtYkgKPiBBbSBERlMtQ2FtcHVzCj4gRCAt
IDYzMjI1IExhbmdlbgo+Cj4gVGVsLjogKzQ5LSgwKTYxMDMtNzA3LTAKPgo+IFNpdHogZGVyIEdl
c2VsbHNjaGFmdDogTGFuZ2VuL0hlc3Nlbgo+IFp1c3TDpG5kaWdlcyBSZWdpc3RlcmdlcmljaHQ6
IEFHIE9mZmVuYmFjaCBhbSBNYWluLCBIUkIgMzQ5NzcKPiBWb3JzaXR6ZW5kZSBkZXMgQXVmc2lj
aHRzcmF0czogRHIuIE1hcnRpbmEgSGlucmljaGVyCj4gR2VzY2jDpGZ0c2bDvGhyZXI6IFByb2Yu
IEtsYXVzLURpZXRlciBTY2hldXJsZSAoVm9ycy4pLCBSb2JlcnQgU2NoaWNrbGluZywgRHIuIE1p
Y2hhZWwgSGFubgo+Cj4gSW50ZXJuZXQ6IGh0dHA6Ly93d3cuZGZzLmRlCj4gUHVibGljLUtleSBk
ZXIgREZTOiBodHRwOi8vd3d3LmRmcy5kZS9kZnMvcHVibGljX2tleS5hc2MKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
