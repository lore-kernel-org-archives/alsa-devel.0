From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [asoc:for-4.19 199/204]
 sound/soc//meson/axg-tdm-interface.c:225:8: error: implicit declaration of
 function 'clk_set_duty_cycle'; did you mean 'clk_set_rate'?
Date: Tue, 31 Jul 2018 15:16:40 -0700
Message-ID: <CAEG3pNDwK2kdp5L=uqGP6v+dLsxqwreyYefV83M=bFad493xuA@mail.gmail.com>
References: <201807210204.l9GJCtSI%fengguang.wu@intel.com>
 <1532112058.26720.62.camel@baylibre.com>
 <1c2a42498ea90428fb6504414154fe3663258ed6.camel@baylibre.com>
 <20180731140222.GE5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A00267763
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 00:17:07 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so30929331oib.10
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 15:17:07 -0700 (PDT)
In-Reply-To: <20180731140222.GE5719@sirena.org.uk>
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
Cc: Stephen Boyd <sboyd@kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux-ALSA <alsa-devel@alsa-project.org>, =?UTF-8?B?SsOpcsO0bWUgQnJ1bmV0?= <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywgSsOpcsO0bWUsCgpPbiBUdWUsIEp1bCAzMSwgMjAxOCBhdCA3OjAyIEFNIE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1bCAzMSwgMjAx
OCBhdCAxMDozOTowM0FNICswMjAwLCBKZXJvbWUgQnJ1bmV0IHdyb3RlOgo+Cj4gPiBUaGUgY29t
bWl0IGFkZGluZyB0aGUgZHV0eS1jeWNsZSBmZWF0dXJlIGluIENDRiBpcyBkaXJlY3RseSBiYXNl
ZCBvbiB2NC4xOC1yYzEKPiA+IERvIHlvdSBwbGFuIG9uIHB1bGxpbmcgdGhpcyBpbiB5b3VyIGJy
YW5jaCA/IG9yIHdhaXQgZm9yIGRlcGVuZGVuY3kgdG8gYmUgc29ydGVkCj4gPiBvdXQgZHVyaW5n
IHRoZSBtZXJnZSB3aW5kb3cgbWF5YmUgPwo+Cj4gSSdkIGxpa2UgdG8gYnV0IEknZCByYXRoZXIg
aGF2ZSBhbiBleHBsaWNpdCBhY2sgZnJvbSB0aGUgY2xvY2sKPiBtYWludGFpbmVycyB0aGF0IHRo
YXQncyBPSyBhbmQgaWRlYWxseSBhIHNpZ25lZCB0YWcuICBUaG91Z2ggaXQncyB0YWtlbgo+IHNv
IGxvbmcgdGhhdCBhdCB0aGlzIHBvaW50IGl0J3Mgbm90IGdvaW5nIHRvIGJlIG11Y2ggd29yc2Ug
dGhhbiBqdXN0Cj4gaG9waW5nIGl0IGdldHMgc29ydGVkIG91dCBpbiBtYWlubGluZSBnaXZlbiB0
aGUgbGFjayBvZiBicmFuY2hlcywgaXQncwo+IG5vdCBhZmZlY3RpbmcgY29tbW9uIHBsYXRmb3Jt
cy4KCkNvbnNpZGVyIHRoaXMgbXkgZXhwbGljaXQgQWNrLiBTaWduZWQgdGFnOgoKZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Nsay9saW51eC5naXQKY2xrLWNv
cmUtZHV0eS1jeWNsZS1mb3ItbWFyawoKTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55dGhpbmcg
ZWxzZS4KCkJlc3QgcmVnYXJkcywKTWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
