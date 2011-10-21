From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix wrong mask in some
 snd_soc_update_bits calls
Date: Fri, 21 Oct 2011 17:52:17 +0100
Message-ID: <CABS+qY0hOywM5D04crw9W_gPPHx8dZSSR1rSPiVU4WiagqoB3w@mail.gmail.com>
References: <1319162083.4352.2.camel@phoenix>
	<65EE16ACC360FA4D99C96DC085B3F7722AE773@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 254B51037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 18:52:20 +0200 (CEST)
Received: by yxp4 with SMTP id 4so642582yxp.0
	for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2011 09:52:17 -0700 (PDT)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722AE773@039-SN1MPN1-003.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: Axel Lin <axel.lin@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

T24gMjEgT2N0b2JlciAyMDExIDA4OjM2LCBEb25nIEFpc2hlbmctQjI5Mzk2IDxCMjkzOTZAZnJl
ZXNjYWxlLmNvbT4gd3JvdGU6Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206
IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1rZXJuZWwt
Cj4+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEF4ZWwgTGluCj4+IFNlbnQ6
IEZyaWRheSwgT2N0b2JlciAyMSwgMjAxMSA5OjU1IEFNCj4+IFRvOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4+IENjOiBEb25nIEFpc2hlbmctQjI5Mzk2OyBXb2xmcmFtIFNhbmc7IExp
YW0gR2lyZHdvb2Q7IE1hcmsgQnJvd247IGFsc2EtCj4+IGRldmVsQGFsc2EtcHJvamVjdC5vcmcK
Pj4gU3ViamVjdDogW1BBVENIXSBBU29DOiBzZ3RsNTAwMDogRml4IHdyb25nIG1hc2sgaW4gc29t
ZQo+PiBzbmRfc29jX3VwZGF0ZV9iaXRzIGNhbGxzCj4+Cj4+IEVuc3VyZSBhbGwgbWFzayBiaXRz
IGFyZSBjbGVhciBiZWZvcmUgc2V0dGluZyBuZXcgdmFsdWUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Cj4+IC0tLQo+PiBJIGRvbid0IGhhdmUgdGhp
cyBoYXJkd2FyZSwgSSdkIGFwcHJlY2lhdGUgaWYgc29tZW9uZSBjYW4gdGVzdCB0aGlzIHBhdGNo
Lgo+Pgo+PiBUaGFua3MsCj4+IEF4ZWwKPj4gwqBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMg
fCDCoCAxMiArKysrKystLS0tLS0KPj4gwqAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPgo+IEl0IHJ1bnMgb2sgYXQgbXkgc2lkZS4KPiBBY2tlZC1ieTog
RG9uZyBBaXNoZW5nIDxiMjkzOTZAZnJlZXNjYWxlLmNvbT4KPgoKQWNrZWQtYnk6IExpYW0gR2ly
ZHdvb2QgPGxyZ0B0aS5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
