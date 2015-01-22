From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/10] ASoC: sta32x: Add device tree binding
Date: Thu, 22 Jan 2015 14:05:50 +0100
Message-ID: <54C0F5AE.7060702@metafoo.de>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-074.synserver.de (smtp-out-074.synserver.de
 [212.40.185.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D292651CE
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 14:05:50 +0100 (CET)
In-Reply-To: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, broonie@kernel.org, zonque@gmail.com, brandau@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDEvMjIvMjAxNSAxMjowMSBBTSwgVGhvbWFzIE5pZWRlcnByw7xtIHdyb3RlOgo+IFRoaXMg
cGF0Y2hzZXQgaXMgdGhlIHJlc3VsdCBvZiBjb21wYXJpbmcgdGhlIHN0YTMyeCBkcml2ZXIgd2l0
aCB0aGUgc3RhMzUwCj4gZHJpdmVyIHdpdGggdGhlIGdvYWwgdG8gbWFrZSB0aGUgc3RhMzJ4IGRy
aXZlciBkZXZpY2UgdHJlZSBjYXBhYmxlLiBJbiB0aGUKPiBtZXJnaW5nIHByb2Nlc3MgdGhlIGNv
ZGluZyBzdHlsZSBvZiB0aGUgc3RhMzUwIGRyaXZlciB3YXMgYWRvcHRlZCBzaW5jZSBpdAo+IHNl
ZW1lZCBtb3JlIHVwIHRvIGRhdGUuIEkgZGlkIG15IGJlc3QgdG8gYnJlYWsgdXAgdGhlIGNoYW5n
ZXMgaW4gbG9naWNhbAo+IGNodW5rcy4gQWRkaXRpb25hbGx5IHNvbWUgc21hbGwgZml4ZXMgd2Vy
ZSBhZGRlZC4KPgo+IFRoZSBjb21wYXJpc29uIHdpdGggdGhlIHN0YTM1MCBsZWFkIHRvIHRoZSBm
b2xsb3dpbmcgY2hhbmdlczoKPiAtIFN3aXRjaCB0byBkaXJlY3QgdXNhZ2Ugb2YgdGhlIHJlZ21h
cCBBUEkKPiAtIFVzZSB0aGUga2VybmVsIGdwaW8gZnJhbWV3b3JrIHRvIGNvbnRyb2wgdGhlIHJl
c2V0IHBpbiBvZiB0aGUgc3RhMzJ4Cj4gLSBhZG9wdCBjYWxjdWxhdGlvbiBvZiBtbGNrIGRpdmlk
ZXIgYW5kIGV4dHJhcG9sYXRpb24gcmF0aW8gZnJvbSBzdGEzNTAKPiAtIGFkZCBkZXZpY2UgdHJl
ZSBiaW5kaW5ncwo+IC0gQ2hhbmdlIHRoZSBDb2RlY3MgREFJIG5hbWUgdG8gYmUgY29oZXJlbnQg
d2l0aCB0aGUgc3RhMzUwIGRyaXZlcgo+Cj4gTW9yZW92ZXIgc29tZSBtaW5vciBmaXhlcyB3ZXJl
IGFkZGVkOgo+IC0gQWRkIHRoZSBzdGF0dXMgcmVnaXN0ZXIKPiAtIEZpeCBiaXQgc2hpZnQgdmFs
dWUgZm9yIHRoZSBJREUgYml0IGluIHRoZSBDT05GRiByZWdpc3Rlcgo+IC0gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgZHJpdmVyIGFuZCBJMkMgZGVwZW5kZW5jeSBpbiBLY29uZmlnCj4KCkdvb2Qg
c3R1ZmYuCgpEbyB5b3UgdGhpbmsgd2UgY2FuIGFjdHVhbGx5IG1lcmdlIHRoZSB0aGUgdHdvIGRy
aXZlcnMgaW50byBvbmUuIFRoZXkgc2VlbSAKdG8gYmUgOTAlIGxpbmUtYnktbGluZSBpZGVudGlj
YWwuCgpUaGFua3MsCi0gTGFycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
