From: Jordi Mallach <jordi@debian.org>
Subject: Re: [PATCH] Remove an obsolete macro in configure.in
Date: Mon, 27 May 2013 17:00:50 +0200
Message-ID: <1369666850.14101.22.camel@penyagolosa.oskuro.net>
References: <1368693178-30659-1-git-send-email-olivier@trillion01.com>
 <s5hhai3jate.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B5E26036A
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 17:00:59 +0200 (CEST)
Received: from [192.168.1.140] (168.19.15.37.dynamic.jazztel.es [37.15.19.168])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 122E761EE3
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 17:00:53 +0200 (CEST)
In-Reply-To: <s5hhai3jate.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpFbCBkaiAxNiBkZSAwNSBkZSAyMDEzIGEgbGVzIDE1OjQ3ICswMjAwLCBlbi9uYSBUYWth
c2hpIEl3YWkgdmEKZXNjcml1cmU6Cj4gQXQgVGh1LCAxNiBNYXkgMjAxMyAwNDozMjo1OCAtMDQw
MCwKPiBvbGl2aWVyQHRyaWxsaW9uMDEuY29tIHdyb3RlOgo+ID4gCj4gPiBGcm9tOiBPbGl2aWVy
IExhbmdsb2lzIDxvbGl2aWVyQHRyaWxsaW9uMDEuY29tPgo+ID4gCj4gPiBSZXBsYWNlZCBBTV9D
T05GSUdfSEVBREVSIHdpdGggQUNfQ09ORklHX0hFQURFUlMKPiA+IAo+ID4gbGFubzExMDZAd2hp
cHBldDIgfi9kZXYvYWxzYS1saWIgJCAuL2dpdGNvbXBpbGUKPiA+IGFjbG9jYWw6IHdhcm5pbmc6
IGF1dG9jb25mIGlucHV0IHNob3VsZCBiZSBuYW1lZCAnY29uZmlndXJlLmFjJywgbm90ICdjb25m
aWd1cmUuaW4nCj4gPiBjb25maWd1cmUuaW46NTY6IGVycm9yOiAnQU1fQ09ORklHX0hFQURFUic6
IHRoaXMgbWFjcm8gaXMgb2Jzb2xldGUuCj4gPiAgICAgWW91IHNob3VsZCB1c2UgdGhlICdBQ19D
T05GSUdfSEVBREVSUycgbWFjcm8gaW5zdGVhZC4KPiA+IC91c3Ivc2hhcmUvYWNsb2NhbC0xLjEz
L29ic29sZXRlLWVyci5tNDoxMjogQU1fQ09ORklHX0hFQURFUiBpcyBleHBhbmRlZCBmcm9tLi4u
Cj4gPiBjb25maWd1cmUuaW46NTY6IHRoZSB0b3AgbGV2ZWwKPiA+IGF1dG9tNHRlOiAvdXNyL2Jp
bi9tNCBmYWlsZWQgd2l0aCBleGl0IHN0YXR1czogMQo+ID4gYWNsb2NhbDogZXJyb3I6IGVjaG8g
ZmFpbGVkIHdpdGggZXhpdCBzdGF0dXM6IDEKPiAKPiBTaWdoLCBhdXRvbWFrZSBzaG91bGQgYmUg
cmVuYW1lZCB0byBhdXRvbWFzb2NoaXNtLi4uCgpXb3VsZCB5b3UgYWNjZXB0IHBhdGNoZXMgZm9y
IHNvbWUgb3RoZXIgaW1wcm92ZW1lbnRzLCBsaWtlIGdlbmVyYXRpbmcgeHoKdGFyYmFsbHMgYW5k
IG1vZGVybmlzaW5nIHNvbWUgYml0cyBvZiB0aGUgYXV0b3Rvb2xzIGluZnJhc3RydWN0dXJlPwoK
SW4gcGFydGljdWxhciwgaWYgd2FudGVkLCBnZXR0aW5nIHJpZCBvZiB0aGUgcGFja2FnZS1vZi1w
YWNrYWdlcyBsYXlvdXQKaW4gYWxzYS10b29scyBhbmQgaGF2ZSBpdCBiZSBhIHNpbmdsZSBwYWNr
YWdlIHdpdGggYSBzaW5nbGUgY29uZmlndXJlCnNjcmlwdCBsaWtlIGFsc2EtdXRpbHMgaXMgc29t
ZXRoaW5nIEknZCBsaWtlIHRvIGdldCBkb25lIGluIG15IGNvcGlvdXMKZnJlZSB0aW1lLgoKSm9y
ZGkKCi0tIApKb3JkaSBNYWxsYWNoIFDDqXJleiAgLS0gIERlYmlhbiBkZXZlbG9wZXIgICAgIGh0
dHA6Ly93d3cuZGViaWFuLm9yZy8Kam9yZGlAc2luZG9taW5pby5uZXQgICAgIGpvcmRpQGRlYmlh
bi5vcmcgICAgIGh0dHA6Ly93d3cuc2luZG9taW5pby5uZXQvCkdudVBHIHB1YmxpYyBrZXkgaW5m
b3JtYXRpb24gYXZhaWxhYmxlIGF0IGh0dHA6Ly9vc2t1cm8ubmV0LwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
