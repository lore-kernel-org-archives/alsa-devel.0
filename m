From: =?UTF-8?Q?Micha=c5=82_Wadowski?= <wadosm@gmail.com>
Subject: Re: [PATCH] Fix for Lenovo B50-70 inverted internal
 microphone bug.
Date: Tue, 14 May 2019 16:18:38 +0200
Message-ID: <de267744-b620-ff52-4bbc-696bc74aa789@gmail.com>
References: <158b63b9-ff73-7f53-de83-5a7b8a21b250@gmail.com>
 <s5h4l5xrxxm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 612ABF8961A
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2019 16:18:42 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id z1so14497812ljb.3
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2019 07:18:42 -0700 (PDT)
In-Reply-To: <s5h4l5xrxxm.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMTQuMDUuMjAxOSAxNTowMiwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIE1vbiwgMTMgTWF5
IDIwMTkgMjM6MjU6MzYgKzAyMDAsCj4gTWljaGFYMiBXYWRvd3NraSB3cm90ZToKPj4KPj4gQWRk
IHBhdGNoIGZvciByZWFsdGVrIGNvZGVjIGluIExlbm92byBCNTAtNzAuCj4+IEJ1Z3ppbGxhOiBo
dHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9hbHNhLWRyaXZlci8rYnVn
LzE1MjQyMTUKPj4KPj4gU2lnbmVkLW9mZi1ieTogTWljaGHFgiBXYWRvd3NraSA8d2Fkb3NtQGdt
YWlsLmNvbT4KPiAKPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4KPiAKPiBBY3R1YWxseSB0aGlzIHNl
ZW1zIHByb2JsZW1hdGljOiB0aGUgYWRkZWQgUENJIFNTSUQgKDE3YWE6Mzk3OCkgZG9lcwo+IGFs
cmVhZHkgZXhpc3QgZm9yIElkZWFwYWQgWTQxMFAuICBUaGF0IGlzLCB3ZSBuZWVkIHRvIHJlcGxh
Y2UgdGhlCj4gZW50cnksIG5vdCBqdXN0IGFkZGluZy4gIFRoZSBleGlzdGluZyBxdWlyayBpcyBv
bmx5IGFib3V0IHRoZSBub2lzZQo+IGZpeCBhbmQgaXQgZGlkbid0IHNlZW0gaGVscCBpbiBhIGxh
dGVyIGtlcm5lbCB2ZXJzaW9uLCBpbiBhbnl3YXksIHNvCj4gaXQgc2hvdWxkIGJlIE9LIHRvIHJl
cGxhY2Ugd2l0aCB0aGUgbmV3IHF1aXJrLgoKSSBhbHNvIHNhdyB0aGlzIGNvbmZsaWN0LCBidXQg
SSBkaWRuJ3Qga25vdyB3aGF0IHNob3VsZCBJIGRvIHdpdGggdGhpcy4KSWYgeW91IHNheSB0aGF0
IGV4aXN0aW5nIGZpeCBmb3IgSWRlYXBhZCBZNDEwUCBpcyBub3QgbmVjZXNzYXJ5IG5vdywgSSBy
ZXBsYWNlIHRoaXMgd2l0aCBMZW5vdm8gQjUwLTcwIGZpeC4KCj4gQWxzbywgSSB3b25kZXIgd2hl
dGhlciB0aGUgZXhpc3RpbmcgcXVpcmsKPiBBTEMyNjlfRklYVVBfRE1JQ19USElOS1BBRF9BQ1BJ
IHdvcmtzIG9uIHlvdXIgZGV2aWNlLiAgQ291bGQgeW91IGNoZWNrCj4gaXQ/Cj4gCj4gCj4gdGhh
bmtzLAo+IAo+IFRha2FzaGkKClllcywgcXVpcmsgQUxDMjY5X0ZJWFVQX0RNSUNfVEhJTktQQURf
QUNQSSB3b3JrcyBmaW5lIG9uIG15IGRldmljZS4KTXkgbGFwdG9wIHVzZXMgQUxDMjMzLCBzbyBJ
IGNyZWF0ZWQgc2VwYXJhdGVkIHF1aXJrLCBidXQgZmluYWxseSBpdCBkb2VzIHRoZSBzYW1lIHRo
aW5nLgpTaG91bGQgSSByZW1vdmUgQUxDMjMzX0ZJWFVQX0lOVl9ETUlDIGFuZCByZXBsYWNlIGl0
IHdpdGggQUxDMjY5X0ZJWFVQX0RNSUNfVEhJTktQQURfQUNQST8KCnRoYW5rcywKTWljaGHFggpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
