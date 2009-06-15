From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH,
	RFC 3/3] pxa/magician: add I2C board info and platform data for
	UDA1380
Date: Mon, 15 Jun 2009 10:06:21 +0800
Message-ID: <f17812d70906141906p4e5a2e28j2f95dcd8f0455660@mail.gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-5-git-send-email-philipp.zabel@gmail.com>
	<20090614150023.GC4482@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 84F5D24477
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 04:06:24 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4325113qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 19:06:21 -0700 (PDT)
In-Reply-To: <20090614150023.GC4482@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBKdW4gMTQsIDIwMDkgYXQgMTE6MDAgUE0sIE1hcmsKQnJvd248YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFN1biwgSnVuIDE0LCAyMDA5IGF0
IDEyOjUxOjMyUE0gKzAyMDAsIFBoaWxpcHAgWmFiZWwgd3JvdGU6Cj4+IENvbmZpZ3VyZXMgSTJD
IGFkZHJlc3MsIHBvd2VyL3Jlc2V0IEdQSU9zIGFuZCBEQUMgY2xvY2sgZnJvbSBXU1BMTC4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBaYWJlbCA8cGhpbGlwcC56YWJlbEBnbWFpbC5jb20+
Cj4KPiBFcmljLCBJIGRvbid0IGtub3cgaG93IHlvdSB3YW50IHRvIGRlYWwgd2l0aCB0aGUgY3Jv
c3MgdHJlZSBpc3N1ZXMgZm9yCj4gdGhpcyBwYXRjaD8gwqBJdCdzIHBhcnQgb2YgYSBjb252ZXJz
aW9uIG9mIHRoZSBVREExMzgwIGRyaXZlciB0byB0aGUKPiBzdGFuZGFyZCBkZXZpY2UgbW9kZWwg
c28gaXQnbGwgZGVwZW5kIG9uIEFTb0MgY2hhbmdlcyB0byB0aGUgVURBMTM4MAo+IGRyaXZlciBi
dXQgb2J2aW91c2x5IHRoZXJlJ3MgYXJjaC9hcm0vbWFjaC1weGEgY2hhbmdlcyB0b28uCj4KPiBP
bmUgd2F5IG9mIG1ha2luZyBzdXJlIHRoZXJlIGFyZW4ndCBhbnkgcHJvYmxlbSB3b3VsZCBiZSBm
b3Igb25lIG9mIHVzCj4gdG8gYXBwbHkgYm90aCBwYXRjaGVzIHRvIGEgYnJhbmNoIHdoaWNoIGNh
biB0aGVuIGJlIHB1bGxlZCBpbiB0byBib3RoCj4gdGhlIEFTb0MgYW5kIFBYQSB0cmVlcy4gwqBE
b2VzIHRoYXQgc291bmQgc2FuZT8KCk5vcm1hbGx5LCBJJ2xsIHF1ZXVlIHN1Y2ggcGF0Y2ggaW4g
bXkgcGVuZGluZyBicmFuY2ggYW5kIHdpbGwgYmUgcHVzaGVkCm91dCB1bnRpbCB0aGUgb3RoZXIg
cGF0Y2goZXMpIHdpdGggZGVwZW5kZW5jeSBoYXMgYmVlbiBtZXJnZWQgdXBzdHJlYW0uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
