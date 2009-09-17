From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/5] ASoC: Blackfin
	I2S: fix resuming when device hasn't been used
Date: Thu, 17 Sep 2009 10:02:26 -0400
Message-ID: <8bd0f97a0909170702q41b6081ch32566976f339344e@mail.gmail.com>
References: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
	<1253147112-5801-5-git-send-email-vapier@gentoo.org>
	<20090917095202.GB30736@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f189.google.com (mail-yw0-f189.google.com
	[209.85.211.189])
	by alsa0.perex.cz (Postfix) with ESMTP id ADC061037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 16:02:47 +0200 (CEST)
Received: by ywh27 with SMTP id 27so85025ywh.2
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2009 07:02:46 -0700 (PDT)
In-Reply-To: <20090917095202.GB30736@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBTZXAgMTcsIDIwMDkgYXQgMDU6NTIsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gV2Vk
LCBTZXAgMTYsIDIwMDkgYXQgMDg6MjU6MTJQTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+IEZyb206IENsaWZmIENhaSA8Y2xpZmYuY2FpQGFuYWxvZy5jb20+Cj4KPj4gSWYgdGhlIHNv
dW5kIHN5c3RlbSBoYXNuJ3QgYmVlbiB1dGlsaXplZCB5ZXQgYW5kIHdlIHN1c3BlbmQsIHRoZW4g
d2UKPj4gYXR0ZW1wdCB0byBzYXZlL3Jlc3RvcmUgdXNpbmcgc3RhdGUgdGhhdCBkb2Vzbid0IGV4
aXN0LiDCoFNvIHVzZSBhIGdsb2JhbAo+PiBoYW5kbGUgaW5zdGVhZCB0byByZWNvbmZpZ3VyZSBw
cm9wZXJseS4KPgo+IEkgZXhwZWN0IHRoYXQgdGhpcyB3aWxsIGJyZWFrIGlmIG1vcmUgdGhhbiBv
bmUgREFJIGlzIGluIHVzZSwgd2hpY2ggY2FuCj4gaGFwcGVuIGlmIHBlb3BsZSBhcmUgdXNpbmcg
bXVsdGlwbGUgREFDcyB0byBkbyA1LjEgb3IgaGFyZHdhcmUgbWl4aW5nLgo+IFdvdWxkIGl0IG5v
dCBtYWtlIHNlbnNlIHRvIGFsbG9jYXRlIHRoZSBTUE9SVCB3aGVuIHRoZSBEQUkgaXMgcHJvYmVk
PwoKdW5mb3J0dW5hdGVseSwgdGhlIHN5c3RlbSBpcyBhbHJlYWR5IGNvbXBsZXRlbHkgYnJva2Vu
IHdoZW4gbW9yZSB0aGFuCm9uZSBpcyB1c2VkLiAgaXZlIG9wZW5lZCBhbiBpdGVtIHRvIGdldCB0
aGlzIGZpeGVkLCBidXQgaXQncyBnb2luZyB0bwpyZXF1aXJlIGEgZmV3IGNvcmUgcGllY2VzIHRv
IGJlIHJld3JpdHRlbi4gIHNvIGknZCBsaWtlIHRvIGhhdmUgdGhpcwptZXJnZWQgc2luY2UgaXQg
aW1wcm92ZXMgdGhlIGN1cnJlbnQgc2l0dWF0aW9uLgotbWlrZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
