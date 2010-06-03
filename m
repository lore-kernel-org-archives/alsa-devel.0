From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
	account for a write being currently in progress
Date: Thu, 3 Jun 2010 17:34:30 +0100
Message-ID: <AANLkTilcRfntO-8vmOCIlFdlLSeyNxd3fJR_8RgfmWNa@mail.gmail.com>
References: <1275514176.8032.42.camel@satellite>
	<AANLkTind6KbV7bpBhG1WK716EsTVCYrjIso3nuuOuBdo@mail.gmail.com>
	<1275581413.15555.2.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CC2A1103809
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:34:30 +0200 (CEST)
Received: by fxm18 with SMTP id 18so246409fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 09:34:30 -0700 (PDT)
In-Reply-To: <1275581413.15555.2.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMyBKdW5lIDIwMTAgMTc6MTAsIEpvaG4gTGluZGdyZW4gPGpvaG4ubGluZGdyZW5AdGRzLm5l
dD4gd3JvdGU6Cj4KPiBJIHVuZGVyc3RhbmQgdGhhdCBzbmRfcGNtX2RlbGF5IGFuZCBzbmRfcGNt
X3dyaXRlaSBjdXJyZW50bHkgImludGVyZmVyZQo+IHdpdGggZWFjaCBvdGhlciIgaW4gdGhhdCBz
bmRfcGNtX2RlbGF5IHJldHVybnMgd3JvbmcgdmFsdWVzIGlmIGNhbGxlZAo+IGR1cmluZyBzbmRf
cGNtX3dyaXRlaS4gwqBUaGF0IGlzIHRoZSBwcm9ibGVtIG15IHBhdGNoIHRyaWVzIHRvIGNvcnJl
Y3QuCj4gRG8geW91IGRpc2FncmVlIHdpdGggdGhpcyBpbXByb3ZlbWVudD8gwqBJZiBzbywgd2h5
Pwo+CgpJIGRpc2FncmVlIGJlY2F1c2UgSSBiZWxpZXZlIHRoZSBjaGFuZ2VzIGFyZSB1bm5lY2Vz
c2FyeS4KVGhlIGFsc2EgYXBpIGlzIGJpZyBlbm91Z2ggYWxyZWFkeSwgc28gYWRkaW5nIGFueXRo
aW5nIGV4dHJhIG11c3QgaGF2ZQphbiBleHRyZW1lbHkgZ29vZCByZWFzb24gZm9yIGl0LgpzbmRf
cGNtX3dyaXRlaSBhbmQgc25kX3BjbV9kZWxheSB3ZXJlIGFsd2F5cyBpbnRlbmRlZCB0byBiZSB1
c2VkIGluCnRoZSBzYW1lIHRocmVhZC4KQ2FsbGluZyBzbmRfcGNtX3dyaXRlaSBhbmQgc25kX3Bj
bV9kZWxheSBhdCB0aGUgc2FtZSB0aW1lIGlzCm5vbi1kZXRlcm1pbmlzdGljIHNvIGZhaXJseSBw
b2ludGxlc3MgdG8gZG8uCkFkZGluZyBtb3JlIGxvY2tzIGp1c3QgbWFrZXMgYW5vdGhlciBoaXQg
b24gcGVyZm9ybWFuY2VzIHNvIHNob3VsZCBiZSBhdm9pZGVkLgpMb2NrcyByZWFsbHkga2lsbCBw
ZXJmb3JtYW5jZSBvbiBhIG11bHRpIHByb2Nlc3NvciBTTVAgbWFjaGluZS4KCkkgd291bGQgYXJn
dWUgdGhhdCBtb2RpZnlpbmcgeW91ciBwcm9ncmFtIHRvIGZpdCBpbiB0aGUgdGhlIGFib3ZlCmNv
bnRyYWludHMgaXMgdGhlIHdheSB0byBnby4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
