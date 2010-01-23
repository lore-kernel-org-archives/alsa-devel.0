From: Aleksandar Kostadinov <akostadinov@friendofpooh.com>
Subject: Re: default alsa pcm improvement
Date: Sat, 23 Jan 2010 07:08:52 +0200
Message-ID: <a886f3c11001222108yb29cbcbra4621b8e6fe83ebe@mail.gmail.com>
References: <a886f3c11001201120x66595796y2ca5f3af35fef8c2@mail.gmail.com>
	<s5h3a1y8ltr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 69AE11037FC
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 06:08:54 +0100 (CET)
Received: by ewy21 with SMTP id 21so2192866ewy.22
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 21:08:53 -0800 (PST)
In-Reply-To: <s5h3a1y8ltr.wl%tiwai@suse.de>
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

T24gRnJpLCBKYW4gMjIsIDIwMTAgYXQgMTI6NDAgUE0sIFRha2FzaGkgSXdhaSA8dGl3YWlAc3Vz
ZS5kZT4gd3JvdGU6Ci4uLi4KPj4gU28gSSB3b3VsZCBzdWdnZXN0IHRoZSAiZGVmYXVsdCIgUENN
IGFzIGRlZmluZWQgbm93IGluIHRoZQo+PiBkZWZhdWx0LmNvbmYgZmlsZSB0byBiZSByZW5hbWVk
IHRvIHNvbWV0aGluZyBsaWtlICJhbHNhZGVmYXVsdCIuIFRoZW4KPj4gImRlZmF1bHQiIFBDTSBz
aG91bGQgYmUgYW4gYWxpYXMgdG8gdGhlIGFsc2FkZWZhdWx0IHBjbS4gVGhpcyB3aWxsIGJlCj4+
IGJhY2t3YXJkcyBjb21wYXRpYmxlIHRvIHdoYXQgdXNlcnMgaGF2ZSBub3cgYW5kIG93bmVycyBv
ZiBtdWx0aXBsZQo+PiBzb3VuZCBkZXZpY2VzIGNhbiBkZWZpbmUgdGhlaXIgImRlZmF1bHQiIHBj
bSBpbiBhc291bmRyYyByZWZlcmVuY2luZwo+PiB0aGUgYWxzYWRlZmF1bHQgcGNtIGJlbmVmaXRp
bmcgZnJvbSB0aGUgZ29vZCB3b3JrIGFscmVhZHkgZG9uZSBhbmQgbm90Cj4+IGhhdmUgdG8gbWVz
cyB3aXRoIGEgY29tcGxleCBhc291bmRyYyBmaWxlIG9yIG1ha2UgY2hhbmdlcyB0byB0aGUKPj4g
c3lzdGVtIGNvbmZpZ3VyYXRpb25zIGZpbGVzLgo+Cj4gQWdyZWVkLCBJJ3ZlIGhhZCBhbHNvIHRo
ZSBzYW1lIGlkZWEuIMKgQnV0LCBhIGdvb2QgbmFtZSBkaWRuJ3QgY29tZSB0bwo+IG15IG1pbmQs
IHNvIEkgZGlkbid0IGFjdHVhbGx5IGltcGxlbWVudCBpdC4KPgo+ICJhbHNhZGVmYXVsdCIgUENN
IGFsc28gc291bmRzIHNvbWV3aGF0IGEgc3lzdGVtLXdpZGUgZGVmYXVsdCwgdGh1cwo+IG1pZ2h0
IGJlIGEgYml0IGNvbmZ1c2luZy4gwqBCYXNpY2FsbHkgaXQgc2hvdWxkIGJlIGEgZGVmYXVsdCBQ
Q00KCldlbGwsIEkgdGhvdWdodCBpdCBvdXQgdG8gZGlmZmVyZW50aWF0ZSB3aXRoIHVzZXJmZWZh
dWx0IGJlY2F1c2UKImRlZmF1bHQiIGFjdHVhbGx5IHNob3VsZCBtZWFuICJ1c2VyZGVmYXVsdCIu
IEFuZCBhbHNhZGVmYXVsdCBpcyB3aGF0CmFsc2EgbGliIHB1dHMgYXMgZGVmYXVsdCAocmVhbGx5
IGEgc3lzdGVtIGRlZmF1bHQgdnMgdXNlciBkZWZhdWx0KS4gU28KSSBzdGlsbCBsaWtlIHRoZSBu
YW1lIGJ1dCBJIHNlZSB5b3VyIHBvaW50IGFsc28uCgpoZXJlIGFyZSBmZXcgbW9yZSBzdWdnZXN0
aW9uczoKYXV0bzo8Q0FSRD4KYXV0b3NlbnNlOjxDQVJEPgphdXRvY29uZjo8Q0FSRD4KcGx1Z2Fu
ZHBsYXk6PENBUkQ+ICNtYXkgcHJvdm9rZSBiYWQgYXNzb2NpYXRpb25zCmF1dG9wbHVnOjxDQVJE
PiAjbWF5IGNvbmZ1c2Ugd2l0aCB0aGUgcGx1ZyBQQ00gdHltZQphbHNhYXV0bzo8Q0FSRD4KCj4g
ZGVmaW5pdGlvbiBmb3IgZWFjaCBjYXJkLiDCoFdlbGwuLi4gYSBnb29kIGdvZGZhdGhlciAvIGdv
ZG1vdGhlciBpcwo+IHdhbnRlZCA7KQoKUmVnYXJkcywKQWxla3NhbmRhcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
