From: =?utf-8?Q?Jean-Fran=C3=A7ois_T=C3=AAtu?=
 <jean-francois.tetu@savoirfairelinux.com>
Subject: Re: [RESEND PATCH] ASoC: codecs: msm8916-wcd-digital:
 fix RX2 MIX1 and RX3 MIX1
Date: Tue, 10 Oct 2017 10:02:30 -0400 (EDT)
Message-ID: <1309357099.59181.1507644150099.JavaMail.zimbra@savoirfairelinux.com>
References: <20171006180951.10930-1-jean-francois.tetu@savoirfairelinux.com>
 <20171009083147.iwugpdgx2zcw6fyu@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 46715266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 16:02:31 +0200 (CEST)
In-Reply-To: <20171009083147.iwugpdgx2zcw6fyu@sirena.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpPbiBNb24sIE9jdCAwOSwgMjAxNyA0OjMxOjQ2IEFNLCBNYXJrIEJyb3duIHdyb3Rl
Ogo+T24gRnJpLCBPY3QgMDYsIDIwMTcgYXQgMDI6MDk6NTFQTSAtMDQwMCwgSmVhbi1GcmFuw6dv
aXMgVMOqdHUgd3JvdGU6Cj4+IFRoZSBrY29udHJvbCBmb3IgdGhlIHRoaXJkIGlucHV0IChyeE5f
bWl4MV9pbnAzKSBvZiBib3RoIFJYMgo+PiBhbmQgUlgzIG1peGVycyBhcmUgbm90IHVzaW5nIHRo
ZSBjb3JyZWN0IGNvbnRyb2wgcmVnaXN0ZXIuIFRoaXMgc2ltcGxlCj4+IHBhdGNoIGZpeGVzIHRo
aXMuCj4gCj4gUGxlYXNlIGRvbid0IHJlc3VibWl0IHBhdGNoZXMgdGhhdCBoYXZlIGFscmVhZHkg
YmVlbiBhcHBsaWVkLCB5b3Ugc2hvdWxkCj4gc3VibWl0IHBhdGNoZXMgYWdhaW5zdCBjdXJyZW50
IGNvZGUgaW4gdGhlIHRyZWUgeW91J3JlIGV4cGVjdGluZyB0aGluZ3MKPiB0byBiZSBhcHBsaWVk
IHRvLiAgSWYgYW55IHVwZGF0ZXMgYXJlIG5lZWRlZCB0byBhIHBhdGNoIHRoYXQncyBhbHJlYWR5
Cj4gYmVlbiBhcHBsaWVkIHlvdSBzaG91bGQgc3VibWl0IGluY3JlbWVudGFsIHBhdGNoZXMgd2hp
Y2ggbWFrZSB0aG9zZQo+IHVwZGF0ZXMuICBUaGlzIGF2b2lkcyBoYXZpbmcgdG8gY2hhbmdlIHB1
Ymxpc2hlZCBnaXQgY29tbWl0cyB3aGljaCBjb3VsZAo+IGNhdXNlIHByb2JsZW1zIGZvciBwZW9w
bGUgd29ya2luZyBhZ2FpbnN0IGdpdC4KCk9vcHMsIEknbSBzb3JyeS4gIEkgZGlkIGxvb2sgaW4g
Zm9yLW5leHQgYW5kIHNhdyB0aGF0IHRoZSBwYXRjaCB3YXMgdGhlcmUuCkJ1dCwgc2luY2UgSSBk
aWQgbm90IHJlY2VpdmUgdGhlICJBcHBsaWVkIiBlbWFpbCBvciBhbiBhY2sgZnJvbSBTcmluaXZh
cywgSQphc3N1bWVkIHRoYXQgdGhlIHBhdGNoIHdhcyBzaW1wbHkgaWdub3JlZCBhbmQgZmVsdCBJ
IHNob3VsZCByZXNlbmQgaXQuCgotLQpKZWFuLUZyYW7Dp29pcyBUw6p0dQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
