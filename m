From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 1/8] ASoC: AD1836:
 drop unnecessary spi register check
Date: Wed, 15 Jun 2011 11:48:41 -0400
Message-ID: <BANLkTim9_=u+9kxkotdK-5_Ry=86WDKSLw@mail.gmail.com>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
	<4DF7D8CA.10909@metafoo.de>
	<BANLkTimPmpCnZSuk9ZtmjLRcg_0gDmH17g@mail.gmail.com>
	<4DF8C833.3030407@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 911D6248F4
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 17:49:02 +0200 (CEST)
Received: by fxm5 with SMTP id 5so534624fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 08:49:02 -0700 (PDT)
In-Reply-To: <4DF8C833.3030407@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gMTUsIDIwMTEgYXQgMTA6NTYsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToK
PiBPbiAwNi8xNS8yMDExIDA0OjQwIFBNLCBNaWtlIEZyeXNpbmdlciB3cm90ZToKPj4gT24gVHVl
LCBKdW4gMTQsIDIwMTEgYXQgMTc6NTUsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToKPj4+IE9u
IDA2LzE0LzIwMTEgMTE6MzQgUE0sIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOgo+Pj4+IFRoZSBvbmx5
IHRoaW5nIHRoZSBpbml0IGZ1bmMgZG9lcyBpcyByZWdpc3RlciBhIHNwaSBkcml2ZXIsIHNvIGlm
IHRoYXQKPj4+PiBmYWlscywgd2UgcmV0dXJuIHRoZSB2YWx1ZSBiYWNrIHVwIHRvIHRoZSBjYWxs
ZXIgd2hvIHdpbGwgZGlzcGxheSBhbgo+Pj4+IGVycm9yIG1lc3NhZ2UgZm9yIHVzLiDCoFNvIGRy
b3AgdGhlIHJlZHVuZGFudCBjaGVja2luZy9tZXNzYWdlLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1i
eTogTWlrZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPgo+Pj4+IC0tLQo+Pj4+IMKgc291
bmQvc29jL2NvZGVjcy9hZDE4MzYuYyB8IMKgIDEwICstLS0tLS0tLS0KPj4+PiDCoDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvYWQxODM2LmMgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTgz
Ni5jCj4+Pj4gaW5kZXggNzU0YzQ5Ni4uZDM2ODUzOSAxMDA2NDQKPj4+PiAtLS0gYS9zb3VuZC9z
b2MvY29kZWNzL2FkMTgzNi5jCj4+Pj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9hZDE4MzYuYwo+
Pj4+IFsuLi5dCj4+Pgo+Pj4gbW9zdCBvZiB0aGVzZSBwYXRjaGVzIHdvbid0IGFwcGx5LCBzaW5j
ZSBJIGFscmVhZHkgc3VibWl0dGVkIHN1cHBvcnQgZm9yIHRoZQo+Pj4gb3RoZXIgQUQxODNYIGNo
aXBzIGxhc3Qgd2Vlay4gUGxlYXNlIGNoZWNrIE1hcmsncyBmb3ItbmV4dCBicmFuY2guCj4+Cj4+
IGkgZGlkbnQgc2VlIHRob3NlIHBhdGNoZXMgb24gdGhlIGRldmljZS1kcml2ZXJzLWRldmVsIG1h
aWxpbmcgbGlzdC4KPj4gZGlkIHlvdSBjYyB0aGVtIHRoZXJlID8KPgo+IFllcy4gU2VlCj4gaHR0
cDovL2JsYWNrZmluLnVjbGludXgub3JnL2dmL3Byb2plY3QvZGV2aWNlLWRyaXZlcnMvbWFpbG1h
bi8/X2ZvcnVtX2FjdGlvbj1Gb3J1bU1lc3NhZ2VCcm93c2UmdGhyZWFkX2lkPTQ1NTEwJmFjdGlv
bj1MaXN0VGhyZWFkcyZtYWlsbWFuX2lkPTczCgpvaywgaSBndWVzcyBpIHNjcmV3ZWQgdXAuICB3
aGVuIHVwZGF0aW5nIHRvIDMuMC1yYzMsIGkgc2F3IG9uZSBmaXgsCmFuZCBnb3QgdGlyZWQgb2Yg
aGF2aW5nIHRvIHVwZGF0ZSB0aGUgbG9jYWwgY3JhcCBpbiBteSB0cmVlLgoKc29tZSBvZiBteSBm
aXhlcyBoZXJlIGFyZSBuZXcsIHNvIGknbGwgbG9vayBhdCBNYXJrJ3MgZm9yLW5leHQgYnJhbmNo
CnRvIHNlZSB3aGljaCBhcmUgc3RpbGwgcmVsZXZhbnQuCgp0aGFua3MgIQotbWlrZQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
