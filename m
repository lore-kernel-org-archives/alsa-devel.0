From: =?UTF-8?Q?Ren=c3=a9_Santing?= <rene.santing@wearespindle.com>
Subject: Re: Bug report - Dell-WD15-Dock not working caused by
 ucm profile in alsa-lib 1.1.7
Date: Tue, 30 Oct 2018 16:55:31 +0100
Message-ID: <851df24c-f461-8469-95d1-282d73ac267c@wearespindle.com>
References: <16a7a277-0677-9ca6-6765-1e109d6dc3be@wearespindle.com>
 <s5hwopzixog.wl-tiwai@suse.de>
 <4ddb1706-d2ba-d5e0-8729-0fa139270e49@wearespindle.com>
 <s5htvl3ix3p.wl-tiwai@suse.de> <s5hk1lzwi8b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C8E526751A
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 16:55:33 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id d6-v6so2863739edi.2
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 08:55:33 -0700 (PDT)
In-Reply-To: <s5hk1lzwi8b.wl-tiwai@suse.de>
Content-Language: en-US-large
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QXMgYSB1c2VyIEkgZG8gdGhpbmsgdGhlIHVjbSBwcm9maWxlIHdvcmtzIGFzIGludGVuZGVkIHdp
dGggdGhlIGxhdGVzdApnaXQuIFB1bHNlYXVkaW8gaXMgbm93IGFibGUgdG8gdXNlIHRoZSBoZWFk
cGhvbmUgYW5kIHNwZWFrZXIgb3V0cHV0IG9mCnRoZSBkb2NraW5nIHN0YXRpb24gYXQgdGhlIHNh
bWUgdGltZSBhbmQgSSB3YXNuJ3QgYWJsZSB0byBkbyB0aGF0CmJlZm9yZS4gQWxzbyBmb3IgbWUg
aW4gS0RFIHRoZSB2b2x1bWUvbXV0ZSBjb250cm9scyBhcmUgd29ya2luZyBhcwppbnRlbmRlZC4g
QnV0IGlmIHRoZSBwcm9maWxlIGdpdmVzIG1vcmUgaXNzdWVzIGZvciBvdGhlciB1c2VycyBJIGNh
bgpjb25maXJtIHRoYXQgbXkgbm9ybWFsIHVzZWNhc2UgYWxzbyB3b3JrcyBmaW5lIHdpdGhvdXQg
dGhlIHByb2ZpbGUgb24gbXkKc2V0dXAuCgpSZW7DqQoKT24gMzAtMTAtMTggMTY6NDUsIFRha2Fz
aGkgSXdhaSB3cm90ZToKPiBPbiBUdWUsIDMwIE9jdCAyMDE4IDEwOjQ4OjI2ICswMTAwLAo+IFRh
a2FzaGkgSXdhaSB3cm90ZToKPj4gT24gVHVlLCAzMCBPY3QgMjAxOCAxMDo0MToxMCArMDEwMCwK
Pj4gUmVuOSBTYW50aW5nIHdyb3RlOgo+Pj4gSSB0b3RhbGx5IG1pc3NlZCB0aGF0IGNvbW1pdCBz
b3JyeSBmb3IgdGhlIHJlZHVuZGFudCBidWcgcmVwb3J0LiBZZXMgaXQKPj4+IHdvcmtzIHdpdGgg
dGhlIHVwZGF0ZWQgY29uZiBmaWxlLgo+PiBHb29kIHRvIGhlYXIsIHRoYW5rcyBmb3IgcXVpY2sg
dGVzdGluZyEKPj4KPj4gSmFyb3NsYXYsIHdoYXQgZG8geW91IHRoaW5rIG9mIDEuMS43LjEgcmVs
ZWFzZSBhZGRyZXNzaW5nIHJlZ3Jlc3Npb24/Cj4+IElJUkMsIHdlIGhhZCBhbiBpc3N1ZSB3aXRo
IGFsc2EtcGx1Z2lucyBhcyB3ZWxsLgo+IE9yIG1heWJlIHdlIHNob3VsZCBkcm9wIHRoaXMgVUNN
IHByb2ZpbGUuCj4KPiBTaW5jZSBQQSBzZWVtcyBhZGRyZXNzaW5nIHRoZSBpc3N1ZSBieSBpdHNl
bGYgdmlhIGl0cyBvd24gc3BlY2lmaWMKPiBwcm9maWxlLCB3ZSBtYXkgbGVhdmUgdGhlIHRoaW5n
cyB0byBQQSBhbG9uZS4KPgo+IEkgaG9wZWQgdGhhdCBVQ00gcHJvZmlsZSBzdXBwb3J0IGNhbiBp
bXByb3ZlIHRoZSB0aGluZ3MgaW4gYSBjbGVhbmVyCj4gd2F5LCBidXQgUEEtVUNNIGludGVncmF0
aW9uIGlzbid0IGZ1bGx5IGRvbmUgKGUuZy4gdGhlIHZvbHVtZSAvIG11dGUKPiBjb250cm9scyBz
ZWVtIGlnbm9yZWQpLCBhbmQgVUNNIG92ZXJyaWRlcyB0aGUgUEEgcHJvZmlsZSwgaXQgY2FuIGJl
Cj4gbW9yZSBoYXJtIHRoYW4gZ29vZCBhcyBvZiBub3cuCj4KPgo+IFRha2FzaGkKPgo+Pgo+PiBU
YWthc2hpCj4+Cj4+PiBUaGFua3MsCj4+Pgo+Pj4gUmVuw6kgU2FudGluZwo+Pj4KPj4+IE9uIDMw
LTEwLTE4IDEwOjM1LCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4+Pj4gT24gVHVlLCAzMCBPY3QgMjAx
OCAxMDoxMDowNyArMDEwMCwKPj4+PiBSZW45IFNhbnRpbmcgd3JvdGU6Cj4+Pj4+IEhlbGxvIEFs
c2EgZGV2ZWxvcGVycywKPj4+Pj4KPj4+Pj4gSSB3b3VsZCBsaWtlIHRvIGZpbGUgYSBidWcgcmVw
b3J0IGFib3V0IHRoZSBEZWxsLVdEMTUtRG9jay4gVGhpcyBkb2NrCj4+Pj4+IHN0b3BwZWQgd29y
a2luZyBmb3IgbWUgb24gYXJjaGxpbnV4L2tkZS4gVGhlIGRldmljZSB3YXMgbm90IHBpY2tlZCB1
cCBhdAo+Pj4+PiBhbGwgYnkgcHVsc2UgYXVkaW8gYWZ0ZXIgc29tZSB1cGRhdGVzIEkgaW5zdGFs
bGVkIGxhc3Qgd2Vlay4KPj4+Pj4gQnkgdHJpYWwgYW5kIGVycm9yIEkgZm91bmQgb3V0IGl0IHdh
cyBjYXVzZWQgYnkgdGhlIHVjbSBwcm9maWxlIHRoYXQgd2FzCj4+Pj4+IGFkZGVkIGluIGFsc2Et
bGliIDEuMS43Lgo+Pj4+IENvdWxkIHlvdSB0cnkgdGhlIGFsc2EtbGliIGdpdCByZXBvPyAgVGhl
IGZpeCBpcyBhbHJlYWR5IGluY2x1ZGVkLgo+Pj4+Cj4+Pj4KPj4+PiB0aGFua3MsCj4+Pj4KPj4+
PiBUYWthc2hpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
