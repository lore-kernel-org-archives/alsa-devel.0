From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] ASoC: Add
	ADAU1701 codec driver
Date: Fri, 10 Jun 2011 14:15:34 -0400
Message-ID: <BANLkTingQSnzmhqS8HOqmeQjRMRVAE020w@mail.gmail.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<BANLkTimLAfEj+tgNMWjTsanccgfEt9UW1g@mail.gmail.com>
	<4DF25AF5.6070909@metafoo.de>
	<BANLkTikSqdHDzQUZdh87YX3y+=GtKDe27g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 480B6103D5A
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:15:54 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1940670fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 11:15:54 -0700 (PDT)
In-Reply-To: <BANLkTikSqdHDzQUZdh87YX3y+=GtKDe27g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMTAsIDIwMTEgYXQgMTQ6MDgsIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOgo+IE9u
IEZyaSwgSnVuIDEwLCAyMDExIGF0IDEzOjU3LCBMYXJzLVBldGVyIENsYXVzZW4gd3JvdGU6Cj4+
IE9uIDA2LzEwLzIwMTEgMDc6NDMgUE0sIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOgo+Pj4gT24gRnJp
LCBKdW4gMTAsIDIwMTEgYXQgMTM6MTgsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToKPj4+PiAr
TU9EVUxFX0FVVEhPUigiTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Iik7Cj4+
Pgo+Pj4gZGlkIHlvdSBhY3R1YWxseSByZXdyaXRlIHRoaXMgdGhpbmcgZnJvbSBzY3JhdGNoID8g
wqBzZWVtcyBsaWtlIHlvdQo+Pj4gc2hvdWxkIGtlZXAgQ2xpZmYgYXMgdGhlIGF1dGhvciBpbiBn
aXQvTU9EVUxFX0FVVEhPUiwgYW5kIHRoZW4gYWRkCj4+PiB5b3VyIG5hbWUgdG8gdGhlIHMtby1i
IGxpc3QgYW5kIHRoaXMgbWFjcm8uCj4+Cj4+IE5vdCBmcm9tIHNjcmF0Y2gsIGJ1dCBJIGd1ZXNz
IGV4Y2VwdCBmb3IgdGhlIHJlZ2lzdGVyIGRlZmluaXRpb25zIGFuZCB0aGUKPj4gY29weXJpZ2h0
IGhlYWRlciBub3QgbXVjaCBvZiB0aGUgb3JpZ2luYWwgZHJpdmVyIGlzIGxlZnQ6Cj4+IHNvdW5k
L3NvYy9jb2RlY3MvYWRhdTE3MDEuYyB8IMKgNjYyICsrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4gwqAxIGZpbGVzIGNoYW5nZWQsIDM3MSBpbnNlcnRpb25zKCsp
LCAyOTEgZGVsZXRpb25zKC0pCj4KPiBiYXNlZCBwdXJlbHkgb24gTG9DLCBDbGlmZiB3cm90ZSA0
NjcsIHNvIHlvdSB0b29rIHRoYXQgYW5kIHB1bnRlZCAyOTEKPiAoNjIlKSBhbmQgdGhlbiBhZGRl
ZCAzNzEuIMKgdGhhdCBsZWF2ZXMgdGhlIGZpbmFsIGZpbGUgd2l0aCAzMiUgQ2xpZmYKPiBhbmQg
NjglIHlvdS4KPgo+IGhvd2V2ZXIsIHNvbWUgb2YgdGhhdCB3YXMgcmVnaXN0ZXIgcmVuYW1pbmcg
YW5kIHNodWZmbGluZyBiZXR3ZWVuIHRoZQo+IGFkYXUxNzAxLmMgYW5kIGFkYXUxNzAxLmgsIGFu
ZCBpdCdzIGVhc2llciB0byBzdGFydCB3aXRoIGEgYmFzZSBhbmQKPiBjbGVhbiB1cCB0aGFuIGZy
b20gc2NyYXRjaC4KPgo+IHNvIGknbSBkZWZpbml0ZWx5IG5vdCBjb21mb3J0YWJsZSBkcm9wcGlu
ZyBDbGlmZidzIGNvbXBsZXRlbHkgZnJvbSB0aGUKPiBmaWxlIGFuZCB0aGUgbG9nICh3aGljaCBt
ZWFucyBoZSBuZWVkcyB0byBiZSByZWFkZGVkIGFuZCBtYWRlIHN1cmUgdG8KPiBiZSByZXRhaW5l
ZCBpbiBhbGwgdGhlIG90aGVyIEFEQVUgZHJpdmVycyBnb2luZyBmb3J3YXJkKSwgYW5kIGknbSBu
b3QKPiBlbnRpcmVseSBzb2xkIGFib3V0IGNoYW5naW5nIG9mIHRoZSBBdXRob3IgZmllbGQgaW4g
dGhlIGdpdCBjb21taXQuCj4KPiBkb24ndCBnZXQgbWUgd3JvbmcgLi4uIGknbSBub3QgYSBmYW5i
b2kgb2YgQ2xpZmYgb3Igc29tZXRoaW5nLCBpIGp1c3QKPiB0aGluayBjcmVkaXQgaXMgZHVlIHRv
IGhpbSBmb3IgaGlzIHdvcmsuCgp0byBiZSBjbGVhciwgaSdtIGxpa2UgNTAvNTAgb24gdGhlIGdp
dCBhdXRob3IgZmllbGQuICBtYXliZSBzb21lb25lCmVsc2UgaGVyZSBoYXMgYW4gb3Bpbmlvbiwg
b3IgeW91IGZlZWwgc3Ryb25nbHkgZW5vdWdoIHRoYXQgeW91cgpyZXdyaXRlIHN1cGVyc2VkZXMg
aGlzIHNlZWRpbmcgd29yay4gIGJ1dCBwbGVhc2Ugc2VuZCBhIHYyIHdpdGgKdXBkYXRlZCBzb3Vy
Y2UvY2hhbmdlbG9nIHdpdGggaGlzIG5hbWUgaW4gaXQuCi1taWtlCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
