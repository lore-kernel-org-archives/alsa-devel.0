From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 1/8] ASoC: AD1836:
 drop unnecessary spi register check
Date: Wed, 15 Jun 2011 10:40:58 -0400
Message-ID: <BANLkTimPmpCnZSuk9ZtmjLRcg_0gDmH17g@mail.gmail.com>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
	<4DF7D8CA.10909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5678B103800
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 16:41:21 +0200 (CEST)
Received: by fxm5 with SMTP id 5so476233fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 07:41:18 -0700 (PDT)
In-Reply-To: <4DF7D8CA.10909@metafoo.de>
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

T24gVHVlLCBKdW4gMTQsIDIwMTEgYXQgMTc6NTUsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToK
PiBPbiAwNi8xNC8yMDExIDExOjM0IFBNLCBNaWtlIEZyeXNpbmdlciB3cm90ZToKPj4gVGhlIG9u
bHkgdGhpbmcgdGhlIGluaXQgZnVuYyBkb2VzIGlzIHJlZ2lzdGVyIGEgc3BpIGRyaXZlciwgc28g
aWYgdGhhdAo+PiBmYWlscywgd2UgcmV0dXJuIHRoZSB2YWx1ZSBiYWNrIHVwIHRvIHRoZSBjYWxs
ZXIgd2hvIHdpbGwgZGlzcGxheSBhbgo+PiBlcnJvciBtZXNzYWdlIGZvciB1cy4gwqBTbyBkcm9w
IHRoZSByZWR1bmRhbnQgY2hlY2tpbmcvbWVzc2FnZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWlr
ZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPgo+PiAtLS0KPj4gwqBzb3VuZC9zb2MvY29k
ZWNzL2FkMTgzNi5jIHwgwqAgMTAgKy0tLS0tLS0tLQo+PiDCoDEgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2NvZGVjcy9hZDE4MzYuYyBiL3NvdW5kL3NvYy9jb2RlY3MvYWQxODM2LmMKPj4gaW5kZXggNzU0
YzQ5Ni4uZDM2ODUzOSAxMDA2NDQKPj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9hZDE4MzYuYwo+
PiArKysgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTgzNi5jCj4+IFsuLi5dCj4KPiBtb3N0IG9mIHRo
ZXNlIHBhdGNoZXMgd29uJ3QgYXBwbHksIHNpbmNlIEkgYWxyZWFkeSBzdWJtaXR0ZWQgc3VwcG9y
dCBmb3IgdGhlCj4gb3RoZXIgQUQxODNYIGNoaXBzIGxhc3Qgd2Vlay4gUGxlYXNlIGNoZWNrIE1h
cmsncyBmb3ItbmV4dCBicmFuY2guCgppIGRpZG50IHNlZSB0aG9zZSBwYXRjaGVzIG9uIHRoZSBk
ZXZpY2UtZHJpdmVycy1kZXZlbCBtYWlsaW5nIGxpc3QuCmRpZCB5b3UgY2MgdGhlbSB0aGVyZSA/
Ci1taWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
