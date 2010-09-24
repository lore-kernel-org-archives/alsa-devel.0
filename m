From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Fri, 24 Sep 2010 09:27:02 +0900
Message-ID: <AANLkTiksrurq_GQOp7gmZ=NeWX8NQFq2W2cA7hvwPveP@mail.gmail.com>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
	<20100923145614.GJ25663@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B2310396D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 02:27:07 +0200 (CEST)
Received: by bwz13 with SMTP id 13so1128083bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 17:27:03 -0700 (PDT)
In-Reply-To: <20100923145614.GJ25663@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBTZXAgMjMsIDIwMTAgYXQgMTE6NTYgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBUaHUsIFNlcCAyMywgMjAxMCBh
dCAxMTo1MzowMFBNICswOTAwLCBKYXNzaSBCcmFyIHdyb3RlOgo+PiBPbiBUaHUsIFNlcCAyMywg
MjAxMCBhdCAxMTo0MCBQTSwgTWFyayBCcm93bgo+Cj4+ID4gwqBzdGF0aWMgdm9pZCBfX2V4aXQg
c21ka19leGl0KHZvaWQpCj4+ID4gwqB7Cj4+ID4gwqAgwqAgwqAgwqBwbGF0Zm9ybV9kZXZpY2Vf
dW5yZWdpc3RlcihzbWRrX3NuZF9hYzk3X2RldmljZSk7Cj4+ID4gKyDCoCDCoCDCoCBwbGF0Zm9y
bV9kZXZpY2VfdW5yZWdpc3RlcihzbWRrX3NuZF93bTk3MTNfZGV2aWNlKTsKPj4gPiDCoH0KPj4g
Pgo+PiA+IMKgbW9kdWxlX2luaXQoc21ka19pbml0KTsKPgo+PiBJIHRoaW5rIHdlIG5lZWQgbW9y
ZSB0aGFuIHRoaXMgdG8gbWFrZSBtb2R1bGUgbG9hZC91bmxvYWQvbG9hZCB3b3JrLgo+PiBMaWtl
IHRoZSBzb2MtYXVkaW8gZGV2aWNlIGFkZGVkLiBXb3VsZG4ndCB0aGF0IHNwb2lsIHRoZSBwYXJ0
eSBuZXh0IHRpbWUKPj4gdGhlIG1vZHVsZSBpcyB0cmllZCB0byBsb2FkZWQgPwo+Cj4gWWVzLCB0
aGUgc29jLWF1ZGlvIGRldmljZSBkb2VzIG5lZWQgdG8gYmUgdW5yZWdpc3RlcmVkIC0gaXQncyB0
aGUKPiBzbWRrX3NuZF9hYzk3X2RldmljZSB0aGF0IHdhcyBhbHJlYWR5IGJlaW5nIHVucmVnaXN0
ZXJlZCBoZXJlLgoKRXZlbiB0aG91Z2ggbW9yZSBuZWVkcyB0byBiZSBkb25lIHRvIGFjaGlldmUg
cHVycG9zZSBvZiB0aGlzIHBhdGNoLAp0aGlzIGNoYW5nZSBpcyBoYXJtbGVzcy4KU28gYXMgaXMg
b3Igd2l0aCBtb3JlIGNoYW5nZXMuLi4uCgpBY2tlZC1ieTogSmFzc2kgQnJhciA8amFzc2kuYnJh
ckBzYW1zdW5nLmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
