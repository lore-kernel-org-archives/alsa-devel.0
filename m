From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/3] new ad1836 codec
	driver based on asoc
Date: Thu, 13 Aug 2009 05:22:18 -0400
Message-ID: <8bd0f97a0908130222x7ad7e57bw5d61c9ec6c826dde@mail.gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
	<20090813090801.GA31504@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 25CBC243D1
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:22:39 +0200 (CEST)
Received: by yxe6 with SMTP id 6so804084yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 02:22:38 -0700 (PDT)
In-Reply-To: <20090813090801.GA31504@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBdWcgMTMsIDIwMDkgYXQgMDU6MDgsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVGh1
LCBBdWcgMTMsIDIwMDkgYXQgMTE6NDE6MTNBTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPj4g
T24gV2VkLCBBdWcgMTIsIDIwMDkgYXQgOTo0NiBQTSwgTWFyayBCcm93biB3cm90ZToKPj4gPiBK
dXN0ICJhZDE4MzYiIC0gdGhlIGZhY3QgdGhhdCBpdCdzIGNvbnRyb2xsZWQgdmlhIFNQSSBpcyBj
bGVhciBmcm9tIHRoZQo+PiA+IGZhY3QgdGhhdCB0aGlzIGlzIGEgc3RydWN0IHNwaV9kcml2ZXIu
Cj4+Cj4+IEkgYWdyZWUgdGhlIHNwaSBzdHJ1Y3R1cmUgaW1wbGllcyB0aGUgbWVhbmluZyBvZiBz
cGkuIMKgQnV0IGZpbGVzIGluCj4+IGFyY2gvYmxhY2tmaW4vbWFjaC4uLiBhcmUgdXNpbmcgbmFt
ZXMgbGlrZSAieHh4LXNwaSIgZm9yIGFsbW9zdCBhbGwKPj4gc3BpIGRldmljZXMuIEhvdyBhYm91
dCBrZWVwaW5nIHRoZSBjb2hlcmVuY2U/Cj4KPiBPaCBkZWFyLiDCoExvb2tzIGxpa2UgeW91J3Zl
IGVzc2VudGlhbGx5IGdvdCBhIGNob2ljZSBiZXR3ZWVuIGJlaW5nCj4gY29uc2lzdGVudCB3aXRo
IHRoZSByZXN0IG9mIHRoZSB3b3JsZCBhbmQgYmVpbmcgY29uc2lzdGVudCB3aXRoIHdoYXQgdGhl
Cj4gYmxhY2tmaW4gc3R1ZmYgaXMgZG9pbmcuCgppdCByZWFsbHkgaXNudCB0aGF0IGJhZC4gIHRo
ZSBkcml2ZXJzIHRoYXQgdXNlICItc3BpIiBzdWZmaXg6CiAgICAgICAgICAgICAgICAubW9kYWxp
YXMgPSAiYWQxODM2LXNwaSIsICAgIyBhdWRpbwogICAgICAgICAgICAgICAgLm1vZGFsaWFzID0g
ImFkMTkzOC1zcGkiLCAgICMgYXVkaW8KICAgICAgICAgICAgICAgIC5tb2RhbGlhcyA9ICJhZDcx
NDctc3BpIiwgICAjIGlucHV0CiAgICAgICAgICAgICAgICAubW9kYWxpYXMgPSAiYWQ5OTYwLXNw
aSIsICAgIyBkZWFkCiAgICAgICAgICAgICAgICAubW9kYWxpYXMgPSAiYmZpbi1scTAzNXExLXNw
aSIsICAjIHZpZGVvCiAgICAgICAgICAgICAgICAubW9kYWxpYXMgPSAiZnhvLXNwaSIsICAgIyBk
ZWFkCiAgICAgICAgICAgICAgICAubW9kYWxpYXMgPSAiZnhzLXNwaSIsICAgIyBkZWFkCgpkcm9w
cGluZyB0aGUgZGVhZCBkZXZpY2VzIGxlYXZlcyB1cyB3aXRoIDQgZHJpdmVycyB0byBmaXgsIHR3
byBvZgp3aGljaCBhcmUgYXVkaW8uICBzaG91bGQgYmUgZWFzeSBmb3IgdXMgdG8gZml4LgotbWlr
ZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
