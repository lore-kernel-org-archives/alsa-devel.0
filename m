From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs
 about the sgt15000 codec.
Date: Mon, 21 Oct 2013 10:11:17 +0200
Message-ID: <20131021101117.5c0c71aa@ipc1.ka-ro>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017121721.43e1b34b@ipc1.ka-ro>
 <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0C92655F2
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 10:11:36 +0200 (CEST)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li-B47053 <B47053@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Guo Shawn-R65073 <r65073@freescale.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>, Es
List-Id: alsa-devel@alsa-project.org

SGksCgo+ID4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIGIvc291
bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jCj4gPiA+IGluZGV4IDFmNDA5M2YuLjRlMmU0YzkgMTAw
NjQ0Cj4gPiA+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYwo+ID4gPiArKysgYi9z
b3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMKPiA+ID4gQEAgLTg4MywxNCArODgzLDE5IEBAIHN0
YXRpYyBpbnQgbGRvX3JlZ3VsYXRvcl9yZWdpc3RlcihzdHJ1Y3QKPiA+IHNuZF9zb2NfY29kZWMg
KmNvZGVjLAo+ID4gPiAgCQkJCXN0cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRhICppbml0X2RhdGEs
Cj4gPiA+ICAJCQkJaW50IHZvbHRhZ2UpCj4gPiA+ICB7Cj4gPiA+ICsjaWZkZWYgQ09ORklHX1NO
RF9TT0NfRlNMX1NHVEw1MDAwCj4gPiA+ICsJcmV0dXJuIDA7Cj4gPiA+ICsjZWxzZQo+ID4gPiAg
CWRldl9lcnIoY29kZWMtPmRldiwgInRoaXMgc2V0dXAgbmVlZHMgcmVndWxhdG9yIHN1cHBvcnQg
aW4gdGhlCj4gPiBrZXJuZWxcbiIpOwo+ID4gPiAgCXJldHVybiAtRUlOVkFMOwo+ID4gPiArI2Vu
ZGlmCj4gPiA+Cj4gPiBUaGlzIGxvb2tzIHdyb25nIHRvIG1lLCBhcyB0aGlzIHdpbGwgZGlzYWJs
ZSB0aGUgZXJyb3IgZm9yIHVuc29saWNpdGVkCj4gPiBwbGF0Zm9ybXMgaW4gYSBtdWx0aSBhcmNo
IGtlcm5lbCEKPiA+IAo+IAo+IFRoZSBDT05GSUdfU05EX1NPQ19GU0xfU0dUTDUwMDAgbWljcm8g
d2lsbCBiZSByZW5hbWVkIHRvIENPTkZJR19TTkRfU09DX0ZTTF9TR1RMNTAwMF9WRjYxMC4KPiBJ
biBWRjYxMCwgdGhlcmUgaGFzIG5vdCBQb3dlciBNYW5hZ2VyIE1vZHVsZSwgc28gd2hldGhlciB0
aGUgQ09ORklHX1JFR1VMQVRPUiBpcyBlbmFibGUgb3IgCj4gRGlzYWJsZWQsIHRoZXJlIHdpbGwg
YWx3YXlzIHNvbWUgZXJyb3JzIGJvb3RpbmcuLi4KPiAKWWVzLCBidXQgeW91IGFyZSBhbHRlcmlu
ZyBjb2RlIHRoYXQgbWF5IGJlIHJ1biBvbiBhIGRpZmZlcmVudCBtYWNoaW5lCnRoYW4gVkY2MTAg
aW4gYSBtdWx0aWFyY2gga2VybmVsISBZb3Ugc2hvdWxkIGhhdmUgYSBSVU5USU1FIGNoZWNrIGZv
cgp0aGUgbWFjaGluZSB0eXBlIGlmIHlvdSBuZWVkIHRvIGRvIG1hY2hpbmUgdHlwZSBzcGVjaWZp
YyBzdHVmZi4KCgpMb3RoYXIgV2HDn21hbm4KLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCgpLYS1SbyBlbGVjdHJvbmljcyBHbWJI
IHwgUGFzY2Fsc3RyYcOfZSAyMiB8IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6ICs0OSAyNDA4IDE0
MDItMCB8IEZheDogKzQ5IDI0MDggMTQwMi0xMApHZXNjaMOkZnRzZsO8aHJlcjogTWF0dGhpYXMg
S2F1c3NlbgpIYW5kZWxzcmVnaXN0ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBBYWNoZW4sIEhSQiA0
OTk2Cgp3d3cua2Fyby1lbGVjdHJvbmljcy5kZSB8IGluZm9Aa2Fyby1lbGVjdHJvbmljcy5kZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
