From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/6] ASoC: Blackfin:
	new machine driver for ADAU1361 codecs
Date: Sat, 7 Aug 2010 17:14:34 -0400
Message-ID: <AANLkTikTQ=dhDPy33dcjKmm7EfQ8KVZhA2aRdCY3Ms84@mail.gmail.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-2-git-send-email-vapier@gentoo.org>
	<AC17F0B0-A138-46D6-B0A7-2752D291BA03@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 91987103805
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 23:14:54 +0200 (CEST)
Received: by wwb31 with SMTP id 31so268405wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 14:14:54 -0700 (PDT)
In-Reply-To: <AC17F0B0-A138-46D6-B0A7-2752D291BA03@opensource.wolfsonmicro.com>
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
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBBdWcgNywgMjAxMCBhdCAxNzowOCwgTWFyayBCcm93biB3cm90ZToKPiBPbiA3IEF1
ZyAyMDEwLCBhdCAyMToyOCwgTWlrZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPiB3cm90
ZToKPgo+PiArY29uZmlnIFNORF9CRjVYWF9TT0NfQURBVTEzNjEKPj4gKyDCoCDCoCB0cmlzdGF0
ZSAiU29DIEFEQVUxMzYxIEF1ZGlvIHN1cHBvcnQiCj4+ICsgwqAgwqAgZGVwZW5kcyBvbiBTTkRf
QkY1WFhfSTJTCj4+ICsgwqAgwqAgc2VsZWN0IFNORF9CRjVYWF9TT0NfSTJTCj4+ICsgwqAgwqAg
c2VsZWN0IFNORF9TT0NfQURBVTEzNjEKPj4gKyDCoCDCoCBzZWxlY3QgSTJDCj4+ICsgwqAgwqAg
aGVscAo+PiArIMKgIMKgIMKgIFNheSBZIGlmIHlvdSB3YW50IHRvIGFkZCBzdXBwb3J0IGZvciBB
REFVMTM2MSBTb0MgYXVkaW8uCj4+ICsKPgo+IElkZW50aWNhbCBjb21tZW50cyB0byB0aGUgbGFz
dCBtYWNoaW5lIGRyaXZlciB5b3UgcG9zdGVkIGhlcmUuCj4KPiBJdCdkIGJlIHJlYWxseSBoZWxw
ZnVsIGlmIHlvdSBjb3VsZCBkbyBhIGJpdCBtb3JlIHByZS1yZXZpZXcgb24gdGhlIHN0dWZmIHlv
dSdyZSBwb3N0aW5nLCBlc3BlY2lhbGx5IHdoZXJlIHlvdSd2ZSBnb3QgYSBidW5jaCBvZiBkcml2
ZXJzIHRoYXQgZm9sbG93IHNpbWlsYXIgcGF0dGVybnMgYW5kIGFyZSBnb2luZyB0byBnZW5lcmF0
ZSBleGFjdGx5IHRoZSBzYW1lIGZlZWRiYWNrLiBQb3N0aW5nIGEgbGFyZ2UgYmF0Y2ggb2YgcGF0
Y2hlcyBhdCBvbmNlIGlzbid0IGEgcHJvYmxlbSBidXQgaWYgeW91J3JlIHNlbmRpbmcgYWRkaXRp
b25hbCBwYXRjaGVzIGxhdGVyIG9uIGl0J2QgYmUgaGVscGZ1bCB0byB0YWtlIGludG8gYWNjb3Vu
dCB0aGUgZmVlZGJhY2sgdGhhdCBoYXMgYWxyZWFkeSBiZWVuIGdpdmVuIG9uIHByaW9yIHNlcmll
c2VzLgoKcHJvYmFibHksIGJ1dCBpJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIEFTb0Mgc3R1ZmYg
dG8gZml4L3JldmlldyBhbnkKb2YgdGhpcy4gIGknbGwgb3BlbiBhbm90aGVyIHRyYWNrZXIgaXRl
bSBmb3IgdGhlc2UgY29kZWNzLgotbWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
