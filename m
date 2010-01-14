From: Singaravelan Nallasellan <singaravelann@gmail.com>
Subject: Re: snd_pcm_avail_update returns 0
Date: Thu, 14 Jan 2010 21:47:45 +0530
Message-ID: <3baf3d761001140817y393f0dc3i585da337f26df96f@mail.gmail.com>
References: <3baf3d761001140641x41854ecax4012d8342ea22aaf@mail.gmail.com>
	<alpine.LNX.2.00.1001141604100.4324@eeebox2.perex-int.cz>
	<3baf3d761001140717j755c13bbg4f682ac6940911a2@mail.gmail.com>
	<alpine.LNX.2.00.1001141624260.4324@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A4DA103903
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 17:17:46 +0100 (CET)
Received: by pxi3 with SMTP id 3so458243pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 08:17:45 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001141624260.4324@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhhbmtzIGFnYWluLgoKU29ycnksIEkgbWlzc2VkIHRvIGFzayB5b3UgYW5vdGhlciBxdWVzdGlv
bi4KCkhvdyBkb2VzIHRoZSByaW5nIGJ1ZmZlciBmdWxsIGRldGVjdGVkIGluIHRoZSBjb3JlPwoK
Pgo+IGh3X3B0ciBhbmQgYXBwbF9wdHIgYXJlIGZyb20gcmFuZ2UgMC4uYm91bmRhcnkgdG8gZGV0
ZWN0IHhydW5zLiBUaGUgZHJpdmVyCj4gc2hvdWxkIG5vdCB3cml0ZSB0byB0aGVzZSB2YWx1ZXMg
YW5kIHNob3VsZCB0cmFjayBvd24gcG9pbnRlcnMuCgpUaGUgZHJpdmVyIGRvZXMgbm90IHVwZGF0
ZSB0aGUgcG9pbnRlcnMuIEl0IGhhcyBpdHMgb3duIHBvaW50ZXJzCndoZXJldmVyIHJlcXVpcmVk
LgoKPgo+PiBNb3Jlb3ZlciBvdXIgZHJpdmVyIHVzZXMgdGhlIGJhdGNoIG1vZGUgYW5kIHVwZGF0
ZXMgdGhlIGhhcmR3YXJlCj4+IHBvaW50ZXIgZm9yIGV2ZXJ5IHBlcmlvZC4gSXMgaXQgdGhlIHJp
Z2h0IHdheSB0byBkbz8KPgo+Cj4+IE1vcmVvdmVyIG91ciBkcml2ZXIgdXNlcyB0aGUgYmF0Y2gg
bW9kZSBhbmQgdXBkYXRlcyB0aGUgaGFyZHdhcmUKPj4gcG9pbnRlciBmb3IgZXZlcnkgcGVyaW9k
LiBJcyBpdCB0aGUgcmlnaHQgd2F5IHRvIGRvPwo+Cj4gSSdtIG5vdCBzdXJlIGFib3V0IHdoYXQg
cG9pbnRlcnMgeW91J3JlIHRhbGtpbmcuIElmIGl0J3MgaHdfcHRyIGFuZAo+IGFwcGxfcHRyLCB0
aGVuIGRyaXZlciBzaG91bGRuJ3Qgd3JpdGUgdG8gdGhlc2UgcG9pbnRlcnMuIFRoZQo+IHNuZF9w
Y21fcGVyaW9kX2VsYXBzZWQoKSBmdW5jdGlvbiBzaG91bGQgYmUgY2FsbGVkIHRvIHN5bmNocm9u
aXplIGh3X3B0cgo+IHdoZW4gcGxheWJhY2sgb2YgcGVyaW9kIGlzIGZpbmlzaGVkLgo+ClRoZSBk
cml2ZXIgZG9lcyBub3QgdXBkYXRlIHRoZSBhcHBsX3B0ciBhbmQgaHdfcHRyLiAucG9pbnRlciBm
dW5jdGlvbgpqdXN0IHJldHVybnMgdGhlIHBvcyByZXR1cm5lZCBieSB0aGUgc25kX3BjbV9pbmRp
cmVjdF9wbGF5YmFja19wb2ludGVyCmZ1bmN0aW9uLiBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCB3
aXRoIHRoZSBwb2ludGVyIHJldHVybmVkIGZyb20gdGhlCmF1ZGlvIGVuZ2luZS4KPiBNYXliZSB5
b3UgY2FuIHB1dCB5b3VyIGNvZGUgdG8gYSBwdWJsaWMgcGxhY2Ugc28gd2UgY2FuIGNoZWNrIGl0
Lgo+ClN1cmUsIGNhbiBJIHNlbmQgdGhlIGNvbXBsZXRlIGNvZGUgdG8gdGhpcyBtbD8KPgo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgSmFyb3NsYXYKPgo+IC0tLS0tCj4gSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBw
ZXJleC5jej4KPiBMaW51eCBLZXJuZWwgU291bmQgTWFpbnRhaW5lcgo+IEFMU0EgUHJvamVjdCwg
UmVkIEhhdCwgSW5jLgo+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
