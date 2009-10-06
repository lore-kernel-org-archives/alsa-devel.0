From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: Blackfin AD1836/AD1938
	machine drivers: require SPI master
Date: Tue, 6 Oct 2009 05:41:40 -0400
Message-ID: <8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20091006093325.GA10118-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBPY3QgNiwgMjAwOSBhdCAwNTozMywgTWFyayBCcm93biB3cm90ZToKPiBPbiBUdWUs
IE9jdCAwNiwgMjAwOSBhdCAwMTo1MTo1MUFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gU2luY2UgdGhlc2UgZHJpdmVycyByZWx5IG9uIGEgU1BJIG1hc3RlciBhbmQgZmFpbCBpZiB0
aGUgU1BJIGZ1bmN0aW9ucwo+PiBhcmVuJ3QgcHJlc2VudCwgbWFrZSBzdXJlIHRoZSBLY29uZmln
IHJlZmxlY3RzIHRoaXMgZGVwZW5kZW5jeS4KPgo+IENvdWxkIHlvdSBwbGVhc2UgcmVkbyB0aGlz
IGFzIGEgZGVwZW5kZW5jeSBvbiB0aGUgcmVsZXZhbnQgU1BJCj4gY29udHJvbGxlciBkcml2ZXI/
IMKgVGhlIGF1ZGlvIGRyaXZlciBpc24ndCBnb2luZyB0byB3b3JrIHdpdGhvdXQgdGhhdAo+IGFu
eXdheSBzbyBpdCBzZWVtcyBtb3JlIHNlbnNpYmxlLgoKdGhlcmUgaXMgbm8gZGVwZW5kZW5jeSBv
biBhIHNwZWNpZmljIHNwaSBidXMgbWFzdGVyIGltcGxlbWVudGF0aW9uLgpqdXN0IGxpa2UgdGhl
IGkyYyBmcmFtZXdvcmssIHN1Y2ggYSBkZXBlbmRlbmN5IHdvdWxkIGJlIGFnYWluc3QgdGhlCndo
b2xlIHB1cnBvc2Ugb2YgaGF2aW5nIGEgZ2VuZXJpYyBmcmFtZXdvcmsgaW4gdGhlIGZpcnN0IHBs
YWNlLgpmb3J0dW5hdGVseSwgdGhpcyBpcyBvbmUgcGllY2Ugb2YgdGhlIEJsYWNrZmluIEFTb0Mg
ZHJpdmVycyBkb25lCmNvcnJlY3RseS4gIGluIG90aGVyIHdvcmRzLCB0aGV5IHNob3VsZCB3b3Jr
IGp1c3QgZmluZSBpZiBob29rZWQgdXAgdG8KYSBHUElPIFNQSSBidXMgb3IgYSBTUE9SVCBTUEkg
YnVzIG9yIGEgQmxhY2tmaW4gb24tY2hpcCBTUEkgYnVzIG9yCi4uLi4uLgotbWlrZQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVY2xpbnV4LWRpc3QtZGV2
ZWwgbWFpbGluZyBsaXN0ClVjbGludXgtZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4Lm9yZwpo
dHRwczovL2JsYWNrZmluLnVjbGludXgub3JnL21haWxtYW4vbGlzdGluZm8vdWNsaW51eC1kaXN0
LWRldmVs
