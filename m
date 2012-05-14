From: Barratis <barratis@gmail.com>
Subject: Re: snd_device_register / snd_device_disconnect
Date: Tue, 15 May 2012 08:07:41 +1000
Message-ID: <CAM+d0w+zq1Lo4FOJbu33V0dWA_F8+AQ=oZ7LyCcPhRBrs_pvpg@mail.gmail.com>
References: <CAM+d0wJoZiooOAVMD97ETefnTZfwvA3Xbx9DF7D8M4_5k_YQdg@mail.gmail.com>
	<s5h7gweyfca.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7FD7124B3F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 00:08:02 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so4922641yhn.38
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2012 15:08:01 -0700 (PDT)
In-Reply-To: <s5h7gweyfca.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGkgVGFrYXNoaSwKCkkgaGF2ZSBhIHZpcnR1YWwgY2FyZCB3aXRoIHBjbSB3aGljaCBjYW4gdGVt
cG9yYXJpbHkgZ28gb2ZmbGluZSwgSQp3YW50ZWQgYSB3YXkgdG8gcHJldmVudCB0aGUgdXNlciBz
ZWVpbmcgdGhlbSB1bnRpbCB0aGV5IGNvbWUgYmFjawpvbmxpbmUgd2l0aG91dCBoYXZpbmcgdG8g
ZGVzdHJveS9yZWNyZWF0ZSB0aGUgcGNtIGV2ZXJ5dGltZS4gU2luY2UKdGhlcmUgd2FzIGEgZGlz
Y29ubmVjdCBjYWxsIHNlcGFyYXRlIGZyb20gdGhlIGZyZWUsIEkgdGhvdWdodCB0aGlzIHdhcwpt
ZWFudCB0byBiZSBwb3NzaWJsZS4KCkkgZ3Vlc3MgSSdsbCBzaW1wbHkgZGVzdHJveS9yZWNyZWF0
ZSBteSBwY21zIHRoZW4uCgpUaGFua3MgZm9yIHlvdXIgYW5zd2VyLgoKCk9uIFR1ZSwgTWF5IDE1
LCAyMDEyIGF0IDE6MDMgQU0sIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6Cj4g
QXQgTW9uLCAxNCBNYXkgMjAxMiAwODoyMzo0NyArMTAwMCwKPiBCYXJyYXRpcyB3cm90ZToKPj4K
Pj4gSGkgQWxsLAo+Pgo+PiBJIHdvdWxkIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcgdGhlIGJl
aGF2aW9yIG9mIHNuZF9kZXZpY2VfcmVnaXN0ZXIuCj4+Cj4+IEN1cnJlbnRseSwgdGhlIHJlZ2lz
dGVyIG9wZXJhdGlvbiB3aWxsIG9ubHkgYmUgY2FycmllZCBvdXQgaWYgdGhlCj4+IHN0YXRlIGlz
IFNORFJWX0RFVl9CVUlMRC4gVGhpcyBlZmZlY3RpdmVseSBwcmV2ZW50cyBkZXZpY2Ugd2hpY2gg
aGF2ZQo+PiBiZWVuIGRpc2Nvbm5lY3RlZCB2aWEgc25kX2RldmljZV9kaXNjb25uZWN0IChhbmQg
dGh1cyBoYXZpbmcgdGhlIHN0YXRlCj4+IFNORFJWX0RFVl9ESVNDT05ORUNURUQpIHRvIGJlIHJl
Z2lzdGVyZWQgYWdhaW4uCj4+Cj4+IElzIHRoaXMgYSB3YW50ZWQgYmVoYXZpb3I/IElmIHNvLCBJ
IGNhbid0IHNlZW0gdG8gZmluZCBhIHJlYXNvbiBmb3IKPj4gdGhpcyBhcyBwZXIgbXkgdGVzdGlu
ZyBhbmQgY29kZSByZWFkaW5nIHJlZ2lzdGVyaW5nIGEgZGV2aWNlIGluCj4+IERJU0NPTk5FQ1RF
RCBzYXRlIHdvcmtzIGp1c3QgZmluZS4KPgo+IFRoZSBkaXNjb25uZWN0ZWQgZGV2aWNlIGlzIGRp
c2Nvbm5lY3RlZC4gwqBXaHkgaXQgbXVzdCBiZSByZWdpc3RlcmVkCj4gYWdhaW4/IMKgSW4gb3Ro
ZXIgd29yZHMsIHRoZSBkaXNjb25uZWN0ZWQgZGV2aWNlIHNob3VsZCBiZSBmcmVlZAo+IGV2ZW50
dWFsbHkgbGF0ZXIuIMKgVGhlIGRpc2Nvbm5lY3RlZCBzdGF0ZSBpcyBhbiBpbnRlcm1lZGlhdGUg
c3RhdGUsCj4gdGh1cyBpdCdzIG5ldmVyIGEgc3RhdGUgcmVhZHkgZm9yIGFueSB1c2UuCj4KPgo+
IFRha2FzaGkKCgoKLS0gCkJhcnJhdGlzCkFueSBzb2NpZXR5IHRoYXQgd291bGQgZ2l2ZSB1cCBh
IGxpdHRsZSBsaWJlcnR5IHRvIGdhaW4gYSBsaXR0bGUKc2VjdXJpdHkgd2lsbCBkZXNlcnZlIG5l
aXRoZXIgYW5kIGxvc2UgYm90aC4gKEJlbmphbWluIEZyYW5rbGluKQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
