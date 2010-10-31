From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] cs46xx memory management fixes for
	cs46xx_dsp_spos_create() - make sure we free and don't do
	pointless work.
Date: Sun, 31 Oct 2010 18:29:10 +0100
Message-ID: <201010311829.13924.linux@rainbow-software.org>
References: <alpine.LNX.2.00.1010292242080.24561@swampdragon.chaosbits.net>
	<201010301406.12961.linux@rainbow-software.org>
	<alpine.LNX.2.00.1010302143530.1572@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id CB79B1037F8
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 18:29:25 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1010302143530.1572@swampdragon.chaosbits.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Benny =?utf-8?q?Sj=C3=B6strand?= <benny@hostmobility.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0dXJkYXkgMzAgT2N0b2JlciAyMDEwIDIxOjQ0OjMzIEplc3BlciBKdWhsIHdyb3RlOgo+
IE9uIFNhdCwgMzAgT2N0IDIwMTAsIE9uZHJlaiBaYXJ5IHdyb3RlOgo+ID4gT24gU2F0dXJkYXkg
MzAgT2N0b2JlciAyMDEwIDAwOjE4OjU3IEJlbm55IFNqw7ZzdHJhbmQgd3JvdGU6Cj4gPiA+IEhl
bGxvIGFnYWluIQo+ID4gPgo+ID4gPiBKdXN0IGRvaW5nIGEgcmVwbHktYWxsLgo+ID4gPiBJdCdz
IGhhcyBiZWVuIG1hbnkgeWVhcnMgc2luY2UgSSBkaWQgYW55dGhpbmcgdG8gdGhlIGNzNDZ4eCBk
cml2ZXIsIHNvCj4gPiA+IEknbSB3b25kZXJpbmcKPiA+ID4gaWYgdGhlcmUncyBhbnlvbmUgb3V0
IHRoZXJlIHN0aWxsIHVzaW5nIGEgY3M0Nnh4IHNvdW5kIGNhcmQ/Cj4gPiA+IEkgdGhpbmsgdGhl
IGNoYW5nZXMgbG9vaydzIGNvcnJlY3QsIGJ1dCBJIGNhbid0IHRlc3QgaXQsIEkgZG8gbm90IGhh
dmUKPiA+ID4gYSBjczQ2eHggaGFyZHdhcmUgYW55bW9yZS4KPiA+Cj4gPiBTdXJlLCB0aGVyZSBh
cmUgbWFueSBvZiB0aGVzZSBjYXJkcyAib3V0IHRoZXJlIi4gSSBqdXN0IGdvdCBhICJuZXciCj4g
PiBUZXJyYXRlYyBETVggWGZpcmUgMTAyNCAoQ1M0NjI0KS4gSSdsbCB0ZXN0IHRoZSBwYXRjaC4K
Pgo+IFRoYW5rcyBhIGxvdC4gTGV0IG1lIGtub3cgaG93IHRoZSB0ZXN0IGdvZXMgOi0pCgpJdCB3
b3JrcyBmaW5lLiBQbGF5aW5nIG11c2ljIHJpZ2h0IG5vdy4KCi0tIApPbmRyZWogWmFyeQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
