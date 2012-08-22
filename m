From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] Documentation for how
	rewinding works
Date: Wed, 22 Aug 2012 09:14:54 +0800
Message-ID: <CAN8cciY=T4vXbwW-Hsz7dDkrCoLgMyvHKStnzhzf_XBSss50fg@mail.gmail.com>
References: <1345374419.4864.64.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 65BEF265EA9
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:14:54 +0200 (CEST)
Received: by qadz3 with SMTP id z3so471890qad.17
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 18:14:55 -0700 (PDT)
In-Reply-To: <1345374419.4864.64.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjAxMi04LTE5IOS4i+WNiDc6MTcg5pa8ICJUYW51IEthc2tpbmVuIiA8dGFudWtAaWtpLmZpPiDl
r6vpgZPvvJoKPgo+IEhpLAo+Cj4gV2hpbGUgcmV2aWV3aW5nIGEgcmV3aW5kIHJlbGF0ZWQgcGF0
Y2gsIEkgbm90aWNlZCB0aGF0IEkgZG9uJ3QKPiB1bmRlcnN0YW5kIHRoZSByZXdpbmRpbmcgY29k
ZSB0aG9yb3VnaGx5LCBldmVuIHRob3VnaCBJIGhhdmUgc3R1ZGllZCBpdAo+IGEgZmV3IHRpbWVz
IGluIHRoZSBwYXN0LiBJIGRlY2lkZWQgdGhhdCBJIHNob3VsZCB3cml0ZSBhIHdpa2kgcGFnZSBm
b3IKPiB0aGUgY29kZSBzbyB0aGF0IHdvcmtpbmcgd2l0aCBpdCB3b3VsZCBiZSBlYXNpZXIgaW4g
dGhlIGZ1dHVyZSBmb3IgbWUKPiBhbmQgZXZlcnlib2R5IGVsc2UuCj4KPiBTbywgaGVyZSdzIHRo
ZSByZXN1bHQ6Cj4KaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvd2lraS9Tb2Z0d2FyZS9QdWxz
ZUF1ZGlvL0RvY3VtZW50YXRpb24vRGV2ZWxvcGVyL1Jld2luZGluZwo+Cj4gV2hpbGUgZG9pbmcg
dGhhdCwgSSBmb3VuZCBxdWl0ZSBhIGZldyBidWdzLCB3aGljaCBhcmUgbm90ZWQgb24gdGhhdAo+
IHBhZ2UuIEkgZG9uJ3QgcGxhbiBmaXhpbmcgdGhlbSBhbnkgdGltZSBzb29uIChoZWxwIHdpdGgg
dGhhdCB3b3VsZCBiZQo+IHZlcnkgd2VsY29tZSksIHNvIEkgd2lsbCBqdXN0IGZpbGUgYnVncyBh
Ym91dCB0aGUgaXNzdWVzIHNvIHRoYXQgdGhleQo+IGFyZSBub3QgZm9yZ290dGVuLgo+Cml0IHNl
ZW0gdGhhdCB0aGUgYWxzYSBzaW5rIGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiB5b3VyIGZpZ3Vy
ZS4KClJlZmVyIHRvIGZpZ3VyZSAxNCBIRCBBdWRpbyBETUEgYW5kIGJ1ZmZlcmluZyAsIHNlY3Rp
b24gNC42IEVuZXJneQpFZmZpY2llbnQgSEEgYXVkaW8gbWVjaGFuaXNtCgptb3N0IHNvdW5kIGNh
cmRzIGhhdmUgZml4ZWQgc2l6ZSBGSUZPIGJ1ZmZlciBpbnN0ZWFkIG9mIGR5bmFtaWMgRklGTyBh
bmQKbWluaW11bSB0cmFuc2ZlciBzaXplKGJydXN0KSBzaW1pbGFyIHRvIGhkYSBjb250cm9sbGVy
IHdoaWNoIHNuZF9wY21fcmV3aW5kCmNhbm5vdCByZXdpbmQgYW55IGF1ZGlvIGRhdGEgaW4gdGhv
c2UgZmlyc3QgaW4gZmlyc3Qgb3V0IGJ1ZmZlci4KCmh0dHA6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9y
Zy9wdWxzZWF1ZGlvL3B1bHNlYXVkaW8vY29tbWl0L3NyYy9tb2R1bGVzL2Fsc2E/aWQ9NGRmNDQz
YmJlNjgyMDU1YTQxZTdjMjI0ODg3N2RjYzc2ODJhNjliOAoKMSkgZG8gdGhlIHNlcnZlciByZWFs
bHkgbmVlZCB0byByZXdpbmQgd2hlbiB0aGVyZSBpcyBvbmx5IG9uZSBwdWxzZSBjbGllbnQgPwoK
MikgZG9lcyBwdWxzZWF1ZGlvIGFkZCB0aGlzIHJld2luZCBzYWZlZ3VhcmQgZGVsYXkgdG8gdGhl
IGxhdGVuY3kgPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
