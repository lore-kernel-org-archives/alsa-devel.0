From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] alsa-lib: Add htimestamp operation in
	plugin file
Date: Wed, 30 Nov 2016 00:34:10 +0900
Message-ID: <3c31a911-bf5d-777c-e0a7-f78be000612f@sakamocchi.jp>
References: <1480073797-17667-1-git-send-email-sutar.mounesh@gmail.com>
 <s5hmvgj5s6n.wl-tiwai@suse.de>
 <f3796efe-5870-2f87-77b5-6f932b4b5bac@sakamocchi.jp>
 <s5hfuma5n1d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5F98C266726
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 16:34:13 +0100 (CET)
In-Reply-To: <s5hfuma5n1d.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: sutar.mounesh@gmail.com, alsa-devel@alsa-project.org, mounesh_sutar@mentor.com, Andreas Pape <apape@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDEx5pyIMzDml6UgMDA6MjIsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBUdWUs
IDI5IE5vdiAyMDE2IDE2OjE1OjU3ICswMTAwLAo+Pj4+IC0tLSBhL3NyYy9wY20vcGNtX2ZpbGUu
YwkyMDEzLTA3LTA4IDE0OjMxOjM2LjAwMDAwMDAwMCArMDIwMAo+Pj4+ICsrKyBiL3NyYy9wY20v
cGNtX2ZpbGUuYwkyMDE1LTA1LTA0IDE2OjI2OjEwLjQxMzYxNTQwMyArMDIwMAo+Pj4+IEBAIC02
OTgsNiArNjk4LDcgQEAKPj4+PiAgCS5yZWFkaSA9IHNuZF9wY21fZmlsZV9yZWFkaSwKPj4+PiAg
CS5yZWFkbiA9IHNuZF9wY21fZmlsZV9yZWFkbiwKPj4+PiAgCS5hdmFpbF91cGRhdGUgPSBzbmRf
cGNtX2dlbmVyaWNfYXZhaWxfdXBkYXRlLAo+Pj4+ICsJLmh0aW1lc3RhbXAgPSBzbmRfcGNtX2dl
bmVyaWNfaHRpbWVzdGFtcCwKPj4+PiAgCS5tbWFwX2NvbW1pdCA9IHNuZF9wY21fZmlsZV9tbWFw
X2NvbW1pdCwKPj4+PiAgCS5wb2xsX2Rlc2NyaXB0b3JzX2NvdW50ID0gc25kX3BjbV9nZW5lcmlj
X3BvbGxfZGVzY3JpcHRvcnNfY291bnQsCj4+Pj4gIAkucG9sbF9kZXNjcmlwdG9ycyA9IHNuZF9w
Y21fZ2VuZXJpY19wb2xsX2Rlc2NyaXB0b3JzLAo+Pgo+PiBJIG9wcG9zZSB0aGlzIGFwcGxpY2F0
aW9uLCBiZWNhdXNlIGRlc2lnbmF0ZWQgaW5pdGlhbGl6YXRpb24gaXMKPj4gYWxyZWFkeSBhcHBs
aWVkIHRvIHRoZSAuaHRpbWVzdGFtcCBtZW1iZXIuCj4+Cj4+IC4uLgo+PiAgICAgICAgIC5wb2xs
X2Rlc2NyaXB0b3JzID0gc25kX3BjbV9nZW5lcmljX3BvbGxfZGVzY3JpcHRvcnMsCj4+ICAgICAg
ICAgLnBvbGxfcmV2ZW50cyA9IHNuZF9wY21fZ2VuZXJpY19wb2xsX3JldmVudHMsCj4+ICAgICAg
ICAgLmh0aW1lc3RhbXAgPSBzbmRfcGNtX2dlbmVyaWNfaHRpbWVzdGFtcCwKCk9vcHMsICdzbmRf
cGNtX2dlbmVyaWNfcmVhbF9odGltZXN0YW1wJyBpcyBwcm9wZXIgaGVyZS4uLgoKPj4gfTsKPj4K
Pj4gUGxlYXNlIHNlZSBiZWxvdyBjb21taXQ6Cj4+IHBjbTpmaWxlOiBhZGQgdGhlIG1pc3Npbmcg
aHRpbWVzdGFtcCBjYWxsYmFjawo+PiBodHRwOi8vZ2l0LmFsc2EtcHJvamVjdC5vcmcvP3A9YWxz
YS1saWIuZ2l0O2E9Y29tbWl0O2g9NjhhZTBjNzJhNTM3MDRkNDE2ZmU3N2Q0YzYxMmQxZjg4ZDc5
MWUwMgo+Pgo+PiBUaGlzIG1pc3Rha2UgY2F1c2VzIGJlbG93IHdhcm5pbmcgd2l0aCAtV292ZXJy
aWRlLWluaXQgb3B0aW9uLgo+PiBwY21fZmlsZS5jOjcxNDoxNjogd2FybmluZzogaW5pdGlhbGl6
ZWQgZmllbGQgb3ZlcndyaXR0ZW4gWy1Xb3ZlcnJpZGUtaW5pdF0KPj4gICAuaHRpbWVzdGFtcCA9
IHNuZF9wY21fZ2VuZXJpY19yZWFsX2h0aW1lc3RhbXAsCj4+ICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4+Cj4+IEkgZ3Vlc3MgbWVudG9yL0FESVQgZGV2
ZWxvcGVycyB3b3JrcyBmb3IgZm9ybWVyIHNuYXBzaG90LCB0aGVuIG1pc3NlZAo+PiB0byByZWJh
c2UgdG8gY3VycmVudCBtYWlubGluZSBvZiBhbHNhLWxpYi4gSSBzdWdnZXN0IHRoZW0gdG8gZGkK
Pj4gcmUtZXZhbHVhdGlvbiB3aXRoIGN1cnJlbnQgbWFpbmxpbmUgd2l0aG91dCB0aGlzIHBhdGNo
Lgo+Cj4gSSBvdmVybG9va2VkIGl0LCB0b28uICBOb3cgdGhlIGNvbW1pdCBnb3QgcmV2ZXJ0ZWQu
CgpUaGFua3MuCgoKVGFrYXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
