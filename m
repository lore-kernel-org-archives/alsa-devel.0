From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Again about regression introduced by commit
 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
Date: Fri, 17 Nov 2017 15:32:09 +0100
Message-ID: <1510929129.8104.1.camel@pengutronix.de>
References: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4C53126721A
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 15:32:09 +0100 (CET)
In-Reply-To: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kalle Kankare <kalle.kankare@vincit.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgS2FsbGUsCgpBbSBGcmVpdGFnLCBkZW4gMTcuMTEuMjAxNywgMTY6MjcgKzAyMDAgc2Nocmll
YiBLYWxsZSBLYW5rYXJlOgo+IEhpLAo+IAo+IFRoZSByZWdyZXNzaW9uIHdhcyBwcmV2aW91c2x5
IGRpc2N1c3NlZCBvbiB0aGlzIG1haWxpbmcgbGlzdCBsYXN0Cj4gbW9udGggKDIwMTctMTAtMDQp
Lgo+IAo+IEFzIGluIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uLCB0aGlzIGNvbW1pdCByZXN0cmlj
dHMgdGhlIHN1cHBvcnRlZAo+IHNvdW5kIGZvcm1hdHMgdG8gUzI0X0xFLiBUaGlzIHByb2JsZW0g
aXMgZXhwZXJpZW5jZWQgaW4gb3VyIGlNWDZxCj4gYmFzZWQgaGFyZHdhcmUgd2l0aCBTR1RMNTAw
MCBzb3VuZCBjaGlwLiBJLmUuOgo+IAo+ICMgYXJlY29yZCAtbCB8IGdyZXAgJ2NhcmQgMCcgLUEy
Cj4gY2FyZCAwOiBpbXg2cWJhMTZzZ3RsNTAgW2lteDZxLWJhMTYtc2d0bDUwMDBdLCBkZXZpY2Ug
MDogSGlGaQo+IHNndGw1MDAwLTAgW10KPiDCoCBTdWJkZXZpY2VzOiAxLzEKPiDCoCBTdWJkZXZp
Y2UgIzA6IHN1YmRldmljZSAjMAo+IAo+IEluIGtlcm5lbCA0LjExLjA6Cj4gCj4gIyBhcmVjb3Jk
IC0tZHVtcC1ody1wYXJhbXMgLUQgaHc6MCwwIDI+JjEgfCBncmVwICdeRk9STUFUJwo+IEZPUk1B
VDrCoCBTMTZfTEUKPiAKPiBBbmQgaW4gbm93IGluIGtlcm5lbCA0LjEzLjM6Cj4gCj4gIyBhcmVj
b3JkIC0tZHVtcC1ody1wYXJhbXMgLUQgaHc6MCwwIDI+JjEgfCBncmVwICdeRk9STUFUJwo+IEZP
Uk1BVDrCoCBTMjRfTEUKPiAKPiBCeSByZXZlcnRpbmcgdGhlIG1lbnRpb25lZCBjb21taXQgNzBk
NDM1YmExY2Q2LCB0aGUgZm9ybWF0IHJldHVybmVkCj4gdG8gUzE2X0xFLiBIb3dldmVyLCBJJ20g
dW5zdXJlIGlmIHRoYXQgaXMgdGhlIHByb3BlciB3YXkgdG8gc29sdmUKPiB0aGlzIGlzc3VlLiBJ
LmUuIGRvZXMgcmV2ZXJ0aW5nIHRoZSBtZW50aW9uZWQgY29tbWl0IGNhdXNlIHNvbWUgb3RoZXIK
PiB1bndhbnRlZCBlZmZlY3QgPwo+IAo+IFdoYXQgd291bGQgYmUgdGhlIGJlc3Qgc29sdXRpb24g
dGhhdCB3b3VsZCBtYWtlIHRoZSBTMTZfTEUgZm9ybWF0Cj4gc3VwcG9ydGVkIGFnYWluIGZvciBT
R1RMNTAwMCA/CgpQbGVhc2UgY2hlcnJ5LXBpY2sgZjlkNGEzOThmMTIxIChkbWFlbmdpbmU6IGlt
eC1zZG1hOiBDb3JyZWN0CnNyY19hZGRyX3dpZHRocyBhbmQgZGlyZWN0aW9ucykgZnJvbSBjdXJy
ZW50IExpbnVzIG1haW5saW5lIHRyZWUuCgpSZWdhcmRzLApMdWNhcwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
