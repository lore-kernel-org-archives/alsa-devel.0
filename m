From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH] ASoC: max98090: add shutdown callback for
	max98090
Date: Fri, 10 Apr 2015 08:46:44 +0800
Message-ID: <55271D74.30300@rock-chips.com>
References: <mailman.2466.1428559383.807.alsa-devel@alsa-project.org>,
 <CAK7N6vow0D8i6jQdjGbZ5L+VdyOtmSWSFdpyiE5JRH7SGtv=Dw@mail.gmail.com>
 <B03A893ADFE80748942D13AFAF28451924E3198860@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.139])
 by alsa0.perex.cz (Postfix) with ESMTP id A27012605BD
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 02:46:49 +0200 (CEST)
In-Reply-To: <B03A893ADFE80748942D13AFAF28451924E3198860@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <Anish.Kumar@maximintegrated.com>, Matthew Mowdy <Matthew.Mowdy@maximintegrated.com>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "wxt@rock-chips.com" <wxt@rock-chips.com>, Nitin Mittal <nitin.mittal@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

SGkgQW5pc2ggS3VtYXIKCuWcqCAwNC8xMC8yMDE1IDAzOjM4IEFNLCBBbmlzaCBLdW1hciDlhpnp
gZM6Cj4+IFRvIGZpeCBwb3Agbm9pc2Ugd2hlbiBzaHV0ZG93bix0aGUgcG9wIG5vaXNlIGR1cmlu
ZyBzaHV0ZG93bgo+PiBpcyB0aGUgcG1pYyBjdXRvZmYgcG93ZXIgb2YgY29kZWMgd2l0aG91dCBh
bnkgbm90aWNlLgo+IElzIHRoZSBwb3dlciB0dXJuZWQgb2ZmIHdpdGhvdXQgYW55IGludGltYXRp
b24gdG8gdGhlIGNvZGVjIGRyaXZlcj8KPiBPciBpcyBpdCBwaHlzaWNhbGx5IHJlbW92ZWQ/IENh
biB5b3UgZGVzY3JpYmUgdGhlIHByb2JlbG0gCj4gYmV0dGVyPwpXaGVuIGRldmljZSBpcyBzaHV0
ZG93biB3aXRoIHBsYXlpbmcgbXVzaWMsIHRoZSBvcmlnaW4gZHJpdmVyIGRvZXMgbm90aGluZyBm
b3Igc2h1dGRvd24gb3BlcmF0aW9uLAphcyBhIHJlc3VsdCwgcG1pYyB3aWxsIGN1dCBvZmYgdGhl
IHBvd2VyIG9mIGNvZGVjIElDLCB0aHVzIGNhdXNlIGEgcG9wIG5vaXNlIGZyb20gc3BlYWtlciBh
bmQgaGVhZHBob25lLgoKU28gdGhlIHBhdGNoIGFkZGVkIGEgc2h1dGRvd24gY2FsbGJhY2sgZm9y
IGRyaXZlciwgZW5hYmxlIHZvbHVtZSBzbW9vdGhpbmcgYW5kIGRpc2FibGUgemVybyBjcm9zcywK
dGhpcyBpcyByZWZlcmVuY2VkIGZyb20gbWljX2lucHV0IHdoaWNoIGRvZXMgdGhlIHNhbWV0aGlu
ZyBiZWZvcmUgbWljIHN3aXRjaC4KCkknbSB2ZXJ5IGhhcHB5IGlmIHNvbWUgc3VnZ2VzdGlvbiBm
cm9tIG1heGltaW50ZWdyYXRlIC4gOi0pCj4KPiArc3RhdGljIHZvaWQgbWF4OTgwOTBfaTJjX3No
dXRkb3duKHN0cnVjdCBpMmNfY2xpZW50ICppMmMpCj4gK3sKPiArICAgICAgIHN0cnVjdCBtYXg5
ODA5MF9wcml2ICptYXg5ODA5MCA9IGRldl9nZXRfZHJ2ZGF0YSgmaTJjLT5kZXYpOwo+ICsKPiAr
ICAgICAgIGRldl9pbmZvKCZpMmMtPmRldiwgInNodXQgZG93biBkZXZpY2VcbiIpOwo+ICsKPiAr
ICAgICAgIC8qIEVuYWJsZSB2b2x1bWUgc21vb3RoaW5nLCBkaXNhYmxlIHplcm8gY3Jvc3MuICBU
aGlzIHdpbGwgY2F1c2UKPiArICAgICAgICAqIGEgcXVpY2sgNDBtcyByYW1wIHRvIG11dGUgb24g
c2h1dGRvd24uCj4gKyAgICAgICAgKi8KPiArICAgICAgIHJlZ21hcF93cml0ZShtYXg5ODA5MC0+
cmVnbWFwLAo+ICsgICAgICAgICAgICAgICBNOTgwOTBfUkVHX0xFVkVMX0NPTlRST0wsIE05ODA5
MF9WU0VOTl9NQVNLKTsKPiArICAgICAgIHJlZ21hcF93cml0ZShtYXg5ODA5MC0+cmVnbWFwLAo+
ICsgICAgICAgICAgICAgICBNOTgwOTBfUkVHX0RFVklDRV9TSFVURE9XTiwgMHgwMCk7Cj4gKyAg
ICAgICBtc2xlZXAoNDApOwo+ICt9Cj4gKwo+Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
