From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about device recovery when under/over run
	error case
Date: Mon, 18 Jan 2016 14:03:17 +0900
Message-ID: <569C7215.2000801@sakamocchi.jp>
References: <87twmbfqio.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 907D9260481
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 06:03:20 +0100 (CET)
In-Reply-To: <87twmbfqio.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>
List-Id: alsa-devel@alsa-project.org

SGksCgpJJ20gbm90IE1hcmsgYnV0IG1pZ2h0IGFuc3dlciBpdC4KCk9uIDIwMTblubQwMeaciDE4
5pelIDEzOjQ1LCBLdW5pbm9yaSBNb3JpbW90byB3cm90ZToKPiBPdXIgc291bmQgZGV2aWNlIG5l
ZWRzIHJlY292ZXJ5IGlmIHVuZGVyL292ZXIgcnVuIGVycm9yIGhhcHBlbi4KPiBCYXNpY2FsbHks
IHRoaXMgInJlY292ZXJ5IiBtZWFucyAicmVzdGFydCBoYXJkd2FyZSIuCj4gQnV0LCBpbiBzdWNo
IGNhc2UsIHdobyBzaG91bGQgcmVjb3ZlcnMgc291bmQgZGV2aWNlLCBLZXJuZWwgb3IgVXNlcmxh
bmQgPwo+Cj4gQ3VycmVudCBvdXIgc291bmQgZHJpdmVyIHJlY292ZXJzIGl0IGJ5IGtlcm5lbCBh
dXRvbWF0aWNhbGx5Lgo+IChCdXQgSSBuZWVkIGRvIHdvcmsgbW9yZSBmb3IgaXQpCgpJIHRoaW5r
IHlvdSBzaG91bGQgbm90IHJlY292ZXIgaXQgaW4ga2VybmVsIHNwYWNlLCBiZWNhdXNlICdod19w
dHInIGluIAptYXBwZWQgcGFnZSBpbmNsdWRlcyB2YWx1ZXMgdW5leHBlY3RlZCBieSB1c2Vyc3Bh
Y2UgYXBwbGljYXRpb24uIChUaGUgCnZhbHVlIG1heSBzdWRkZW5seSBqdW1wIHVwIHRvIHVuZXhw
ZWN0ZWQgdmFsdWUgYWZ0ZXIgcmVjb3ZlcmVkLikKCldoYXQgZHJpdmVyIGluIGtlcm5lbCBsYW5k
IGlzIHRvIG5vdGlmeSBYUlVOIHRvIHRoZSBhcHBsaWNhdGlvbnMgaW4geW91ciAKY2FzZS4gSWYg
cmVjb3ZlcmluZyBwcm9jZXNzaW5nIGluY2x1ZGVzIGV2ZW50IHdhaXRpbmcsIGl0IHNob3VsZCBu
b3QgYmUgCmV4ZWN1dGVkIGluIGludGVycnVwdCBjb250ZXh0LgoKPiBXZSBjb25zaWRlcmVkIHRo
YXQgdXNlcmxhbmQgc2hvdWxkIGtub3cgaXQsIG9yLCBydW4gaXQgYnkgaGltc2VsZiAoPykKPiBJ
ZiB1c2VybGFuZCBzaG91bGQgZG8gaXQsIHdoaWNoIGZ1bmN0aW9uIHNob3VsZCBiZSBjYWxsZWQg
dG8gYW5ub3VuY2UKPiBlcnJvciB0byB1c2VybGFuZCBmcm9tIGtlcm5lbCA/CgpVc2Vyc3BhY2Ug
Y2FuIGdldCB0byBrbm93IHRoZSBYUlVOIHN0YXRlIGJ5IGNhbGxpbmcgc29tZSBBUElzLiBUaGVu
LCBpdCAKY2FuIHJlY292ZXIgUENNIHN1YnN0cmVhbSBieSBleGVjdXRpbmcgU05EUlZfUENNX0lP
Q1RMX1BSRVBBUkUgaW9jdGwuCgoKUmVnYXJkcwoKVGFrYXNoaSBTYWthbW90bwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
