From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 21:22:18 +0200
Message-ID: <CA+sos78W2Ni2b3naiunBm5Z83XiDp=rd+D1jvVPoLcousCinFg@mail.gmail.com>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
 <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
 <20150930181004.GN15635@sirena.org.uk>
 <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 792A7266415
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:22:39 +0200 (CEST)
Received: by obbda8 with SMTP id da8so40022563obb.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 12:22:38 -0700 (PDT)
In-Reply-To: <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiBXZWQsIFNlcCAzMCwgMjAxNSBhdCA5OjA4IFBNLCBBbmF0b2wgUG9tb3pvdgo8YW5h
dG9sLnBvbW96b3ZAZ21haWwuY29tPiB3cm90ZToKPiBIaQo+Cj4gT24gV2VkLCBTZXAgMzAsIDIw
MTUgYXQgMTE6MTAgQU0sIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6Cj4+
IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIHRydWUsIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IGEgbGVm
dC9yaWdodCBzYW1wbGUKPj4gcGFpciBpcyB0aW1lIGFsaWduZWQgc28gdGhlIGxlZnQgY2hhbm5l
bCBpcyBkZWZpbml0ZWx5IHRoZSBzdGFydCBvZgo+PiBmcmFtZSBmb3IgYWxsIG1lYW5pbmdmdWwg
cHVycG9zZXMuICBJdCdzIGNlcnRhaW5seSB3aGF0IEknZCBleHBlY3QgbW9zdAo+PiBwZW9wbGUg
dG8gdW5kZXJzdGFuZCAtIGNob29zaW5nIGEgY291bnRlcmludHVpdGl2ZSBkZWZpbml0aW9uIHRv
IG1ha2UKPj4gdGhpcyBvbmUgc3RhdGVtZW50IGNvbnZlbmllbnQgaXMgZ29pbmcgdG8gbGVhZCB0
byBjb25zdGFudCBjb25mdXNpb24gZm9yCj4+IHRoZSBtb2RlIHdoaWNoIGlzIGNsZWFyZXN0Lgo+
Cj4gVG8gY2xhcmlmeSwgeW91IHByb3Bvc2UgZm9sbG93aW5nIGRlZmluaXRpb24gb2Ygbm9ybWFs
IEZTWU5DIHBvbGFyaXR5Ogo+ICAtIGZvciBJMlMvbGVmdC9yaWdodCBqdXN0aWZpZWQgLSBmcmFt
ZSBzdGFydHMgd2l0aCBmYWxsaW5nIEZTWU5DIGVkZ2UKPiAgLSBmb3IgRFNQIEEvQiAtIGZyYW1l
IHN0YXJ0cyB3aXRoIHJpc2luZyBlZGdlIG9mIEZTWU5DIGVkZ2UgKHBsdXMgb2Zmc2V0KQo+ICAt
IGZvciBBQzk3IG15IGd1ZXNzIGl0IGlzIHRoZSBzYW1lIGFzIERTUCAtIGZyYW1lIHN0YXJ0cyB3
aXRoIHJpc2luZwo+IEZTWU5DIGVkZ2UuCj4KPiBJcyBpdCBjb3JyZWN0PwoKTW9zdCBDT0RFQyBk
YXRhc2hlZXRzIGRlc2NyaWJlIHRoZSByZWd1bGFyIGxlZnQvcmlnaHQganVzdGlmaWVkCmZvcm1h
dHMgYXMgaGF2aW5nIHRoZSBsZWZ0IGNoYW5uZWwgc3RhcnRpbmcgb24gdGhlIHJpc2luZyBlZGdl
IG9mCkZTWU5DLCBsaWtlIGZvciBEU1AgQS9CIGFuZCBBQyc5Ny4gScKyUyBpcyB0aGUgb25seSBl
eGNlcHRpb24gaGVyZS4KCkJlc3QgcmVnYXJkcywKQmVub8OudApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
