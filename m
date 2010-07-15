From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: multi-component - Modify to use
	common S3C I2S features
Date: Thu, 15 Jul 2010 20:33:28 +0900
Message-ID: <AANLkTimKZGCYPp5ElEPthi8YY7fbSPMldRQVWDZe0HzX@mail.gmail.com>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
	<20100715093220.GE23529@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 889D81037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 13:33:28 +0200 (CEST)
Received: by wwb13 with SMTP id 13so1525wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 04:33:28 -0700 (PDT)
In-Reply-To: <20100715093220.GE23529@rakim.wolfsonmicro.main>
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCk9uIFRodSwgSnVsIDE1LCAyMDEwIGF0IDY6MzIgUE0sIE1hcmsgQnJvd24KPGJy
b29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBUaHUsIEp1bCAx
NSwgMjAxMCBhdCAwNTo1ODo0N1BNICswOTAwLCBTZXVuZ3doYW4gWW91biB3cm90ZToKPgo+PiAr
IMKgIMKgIGkycy0+YmFzZSA9IFMzQzY0WFhfUEFfSUlTVjQ7Cj4+ICsKPgo+IEknZCByZWFsbHkg
ZXhwZWN0IHRoaXMgdG8gYmUgYmVpbmcgcHVsbGVkIGZyb20gdGhlIHJlc291cmNlcyBmb3IgdGhl
Cj4gcGxhdGZvcm0gZGV2aWNlIGZvciB0aGUgREFJIHJhdGhlciB0aGFuIGhhcmQgY29kZWQgaW50
byB0aGUgZHJpdmVyLiDCoElmCj4gd2UncmUgZ29pbmcgdG8gc3RhcnQgcmVvcmdhbmlzaW5nIHRo
aW5ncyBsaWtlIHRoaXMgYW5kIHRvdWNoaW5nIGFsbCB0aGUKPiBkcml2ZXJzIGl0J2Qgc2VlbSBi
ZXR0ZXIgdG8gZ28gc3RyYWlnaHQgdG8gZG9pbmcgdGhhdCByYXRoZXIgdGhhbgo+IGludHJvZHVj
aW5nIHRoaXMgYXBwcm9hY2guCj4KCkRvZXMgeW91ciBjb21tZW50IG1lYW5zIHRoYXQgJ2kycy0+
YmFzZScgZ2V0IGJhc2UgYWRkcmVzcyBmcm9tIHRoZQpyZXNvdXJjZXMgZm9yIHRoZSBwbGF0Zm9y
bSBkZXZpY2UgdXNpbmcgJ3BsYXRmb3JtX2dldF9yZXNvdXJjZXMoKSc/CkknbSBkb2luZyBvbiBw
cmVwYXJpbmcgdGhhdCBpc3N1ZSBpbnRvIGFub3RoZXIgcGF0Y2ggYWxyZWFkeSAoYmVjYXVzZQpJ
IHRoaW5rIHRoaXMgcGF0Y2ggaXMgb25seSBmb3IgTGlhbSdzIG11bHRpLWNvbXAsIG5vdCBmb3Ig
dGhhdCBpc3N1ZSkuCgpJZiB0aGUgcmVzb3VyY2Ugc2hvdWxkIGdldCBmcm9tIHBsYXRmb3JtIGRl
dmljZSwgSSdsbCBiZSBoYXBweSB0byBtYWtlCmEgbmV3IG9uZS4KCgpUaGFua3MuCgpDbGF1ZGUu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
