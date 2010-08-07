From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/6] ASoC: Blackfin:
 new machine driver for ADAU1361 codecs
Date: Sat, 7 Aug 2010 18:31:23 -0400
Message-ID: <AANLkTi=HY0yxD3XgCYt5YvsEmv_72oA46L44huL_tvhd@mail.gmail.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-2-git-send-email-vapier@gentoo.org>
	<AC17F0B0-A138-46D6-B0A7-2752D291BA03@opensource.wolfsonmicro.com>
	<AANLkTikTQ=dhDPy33dcjKmm7EfQ8KVZhA2aRdCY3Ms84@mail.gmail.com>
	<FB9CDF75-F284-4D03-AB3A-CE3692EB8969@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B6AE0103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:31:43 +0200 (CEST)
Received: by wwd20 with SMTP id 20so322618wwd.2
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 15:31:43 -0700 (PDT)
In-Reply-To: <FB9CDF75-F284-4D03-AB3A-CE3692EB8969@opensource.wolfsonmicro.com>
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
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBBdWcgNywgMjAxMCBhdCAxODoyOSwgTWFyayBCcm93biB3cm90ZToKPiBPbiA3IEF1
ZyAyMDEwLCBhdCAyMjoxNCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6Cj4+IE9uIFNhdCwgQXVnIDcs
IDIwMTAgYXQgMTc6MDgsIE1hcmsgQnJvd24gd3JvdGU6Cj4+PiBJdCdkIGJlIHJlYWxseSBoZWxw
ZnVsIGlmIHlvdSBjb3VsZCBkbyBhIGJpdCBtb3JlIHByZS1yZXZpZXcgb24gdGhlIHN0dWZmIHlv
dSdyZSBwb3N0aW5nLCBlc3BlY2lhbGx5IHdoZXJlIHlvdSd2ZSBnb3QgYSBidW5jaCBvZiBkcml2
ZXJzIHRoYXQgZm9sbG93IHNpbWlsYXIgcGF0dGVybnMgYW5kIGFyZSBnb2luZyB0byBnZW5lcmF0
ZSBleGFjdGx5IHRoZSBzYW1lIGZlZWRiYWNrLiBQb3N0aW5nIGEgbGFyZ2UgYmF0Y2ggb2YgcGF0
Y2hlcyBhdCBvbmNlIGlzbid0IGEgcHJvYmxlbSBidXQgaWYgeW91J3JlIHNlbmRpbmcgYWRkaXRp
b25hbCBwYXRjaGVzIGxhdGVyIG9uIGl0J2QgYmUgaGVscGZ1bCB0byB0YWtlIGludG8gYWNjb3Vu
dCB0aGUgZmVlZGJhY2sgdGhhdCBoYXMgYWxyZWFkeSBiZWVuIGdpdmVuIG9uIHByaW9yIHNlcmll
c2VzLgo+Pgo+Pgo+PiBwcm9iYWJseSwgYnV0IGknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgQVNv
QyBzdHVmZiB0byBmaXgvcmV2aWV3IGFueQo+PiBvZiB0aGlzLiDCoGknbGwgb3BlbiBhbm90aGVy
IHRyYWNrZXIgaXRlbSBmb3IgdGhlc2UgY29kZWNzLgo+Cj4gSXQnZCBwcm9iYWJseSBiZSBlbm91
Z2ggdG8ganVzdCBhdm9pZCBwb3N0aW5nIGFkZGl0aW9uYWwgYmF0Y2hlcyBvZiBwYXRjaGVzIHdp
dGhvdXQgaW5jb3Jwb3JhdGluZyBwcmV2aW91cyByZXZpZXcsIGVpdGhlciBieSBqdXN0IHBvc3Rp
bmcgZXZlcnl0aGluZyBpbiBvbmUgc2VyaWVzIG9yIGJ5IGhvbGRpbmcgb2ZmIG9uIGxhdGVyIG9u
ZXMgYWZ0ZXIgZ2V0dGluZyB0aGUgZmlyc3QgYmF0Y2ggb2YgcmV2aWV3LiBUaGUgcmVhc29uIEkg
bWVudGlvbmVkIHRoaXMgd2FzIHRoYXQgSSdkIGFscmVhZHkgcmV2aWV3ZWQgcHJldmlvdXMgcG9z
dGluZ3MgKGFuZCBzZWVuIHRoYXQgeW91J2QgcmVhZCBteSByZXZpZXcpIGJ1dCB3YXMgbm90aWNp
bmcgbWFueSBvZiB0aGUgc2FtZSBpc3N1ZXMgY3JvcHBpbmcgdXAgaW4gdGhlIG5ldyBwb3N0aW5n
cy4KCmknZCBsaWtlIHRvIGhhdmUgc2VudCB0aGVzZSBvdXQgYXMgb25lIGJhdGNoLCBidXQgaXQg
dGFrZXMgdGltZSBmb3IgbWUKdG8gY2xlYW4gdXAgdGhlIGNvbW1pdHMgYmVpbmcgc2VudCB0byBt
ZS4gIHlvdSdkIHByb2JhYmx5IGJhcmYgYWxsCm92ZXIgdGhlIGNoYW5nZXNldHMgdGhhdCBpIGhh
dmUgdG8gcHJvY2VzcyA7KS4KCmkgZG9udCBoYXZlIGFueSBvdGhlciBjb2RlYyBkcml2ZXJzIGF0
bSB0aG91Z2guICBqdXN0IGJ1ZyBmaXhlcyB0aGF0IGkKbmVlZCB0byBmdXJ0aGVyIGNsZWFuIHVw
L3NwbGl0L2RvY3VtZW50L2V0Yy4uLgotbWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
