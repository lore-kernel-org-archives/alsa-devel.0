From: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Fri, 28 May 2010 07:55:19 +0200
Message-ID: <4BFF5AC7.3060409@eukrea.com>
References: <20100524074946.GC16346@www.longlandclan.yi.org>	<1274698156.3064.93.camel@odin>	<20100525004126.GA10968@www.longlandclan.yi.org>	<20100525022646.GA18030@www.longlandclan.yi.org>	<1274806007.4728.3.camel@gnutoo-desktop>	<20100526132129.GA13644@www.longlandclan.yi.org>	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 64.mail-out.ovh.net (64.mail-out.ovh.net [91.121.185.65])
	by alsa0.perex.cz (Postfix) with SMTP id EFECC103AD9
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 07:55:21 +0200 (CEST)
In-Reply-To: <20100528020621.GA12531@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGkgU3R1YXJ0LAoKTGUgMjgvMDUvMjAxMCAwNDowNiwgU3R1YXJ0IExvbmdsYW5kIGEgw6ljcml0
IDoKPiBJJ2xsIGhhdmUgYSBsb29rIGF0IHRoZSBFdWtyZWEgQ1BVSU1YMjcgYW5kIGJhc2Vib2Fy
ZCBTb0Mgc3VwcG9ydCBpbiBhCj4gbW9tZW50LCBzaW5jZSBpdCBsb29rcyB2ZXJ5IHNpbWlsYXIg
dG8gd2hhdCB3ZSdyZSBkb2luZyAoaW4gdGhhdCBpdCdzIGEKPiBUSSBJwrJTIENPREVDIGhvb2tl
ZCB0byBhbiBpLk1YMjcgb24gU1NJNCkgLi4uIHRoaXMgbWlnaHQgcmV2ZWFsIGNsdWVzCj4gYXMg
dG8gd2hhdCBJJ20gZG9pbmcgd3JvbmcuCgp3ZSBhcmUgdXNpbmcgdGhlIFRMVjMyMEFJQzIzQiBj
b2RlYyBpbiBtYXN0ZXIgbW9kZSBvbiB0aGUgCkNQVUlNWDI3L01CSU1YMjcgKGFuZCBkaWQgdGhl
IHNhbWUgb24gYW4gb3RoZXIgYm9hcmQgdXNpbmcgYSBUTFYzMjA0IGFzIAphIG1hc3RlciB3aXRo
IGEgMTJNSHogb3NjaWxsYXRvciBvbiBpdHMgTUNMSzogZm9yIHRoaXMgb25lLCBpdCdzIApuZWNl
c3NhcnkgdG8gY29uZmlndXJlIHNldmVyYWwgZG96ZW5zIG9mIHJlZ2lzdGVycyB0aHJvdWdoIEky
QyB0byBnZXQgaXQgCnJ1bm5pbmcpCgpUaGUgVExWMzIwNCBpcyB3aXJlZCB0aGlzIHdheSA6Ci0g
TUNLID0gMTJNSHogb2NpbGxhdG9yCi0gQkNMSyAocGluMikgPSBQQzE5IChTU0k0X0NMSykgKFRM
ViBvdXRwdXQgLyBJTVggaW4pCi0gV0NMSyAocGluMykgPSBQQzE2IChTU0k0X0ZTKSAoVExWIG91
dHB1dCAvIElNWCBpbikKLSBESU4vTUZQMSAocGluNCkgPSBQQzE4IChTU0k0X1RYREFUKSAoVExW
IGlucHV0IC8gSU1YIG91dCkKLSBET1VUL01GUDIgKHBpbjUpID0gUEMxNyAoU1NJNF9SWERBVCkg
KFRMViBvdXRwdXQgLyBJTVggaW4pCi0gU1BJX1NFTEVDVCAocGluMTIpID0gcHVsbCBkb3duIHRv
IHNlbGVjdCBJMkMgbW9kZQotIFNDTCAmIFNEQSAocGlucyA5ICYgMTApID0gSTJDMgphbGwgdGhl
IGludGVyZmFjZSBiZXR3ZWVuIGkuTVggJiBUTFYgaXMgcG93ZXJlZCBpbiAxLjhWLgoKSSdsbCB0
cnkgdG8gZmluZCBvdXIgSTJDIGluaXQgc2VxdWVuY2UgYW5kIHNlbmQgaXQgdG8geW91IGFzIHRo
aXMgd2FzIAp0aGUgaGFyZGVzdCBwYXJ0IG9mIHRoZSB0aGluZyB0byBnZXQgdGhlIGNvZGVjIHJ1
bm5pbmcuCgpFcmljCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
