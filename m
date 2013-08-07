From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND] mfd: arizona: Move regulator
 disable to after marking cache only
Date: Wed, 7 Aug 2013 09:34:37 +0100
Message-ID: <20130807083437.GJ5100@lee--X1>
References: <1375805915-24009-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f175.google.com (mail-ea0-f175.google.com
 [209.85.215.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A79326084D
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 10:34:43 +0200 (CEST)
Received: by mail-ea0-f175.google.com with SMTP id m14so686783eaj.34
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 01:34:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375805915-24009-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwNiBBdWcgMjAxMywgQ2hhcmxlcyBLZWVwYXggd3JvdGU6Cgo+IElmIHdlIGRpc2Fi
bGUgRENWREQgYmVmb3JlIHdlIG1hcmsgdGhlIGNhY2hlIGFzIGNhY2hlIG9ubHksIHdlIG1pZ2h0
Cj4gYXR0ZW1wdCB0byB3cml0ZSB0byB0aGUgY2hpcCB3aGlsc3QgaXQgaXMgcG93ZXJlZCBkb3du
IGFuZCBsb3NlIGEgd3JpdGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlcyBLZWVwYXggPGNr
ZWVwYXhAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+ICBkcml2ZXJzL21mZC9h
cml6b25hLWNvcmUuYyB8ICAgIDIgKy0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpBcHBsaWVkLCB0aGFua3MuCgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJj
ZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVy
IHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
