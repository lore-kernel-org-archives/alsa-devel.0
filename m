From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] alsa-lib/tlv: fix handling of raw value
 ranges
Date: Sat, 2 Jun 2012 14:26:02 +0200 (CEST)
Message-ID: <295179962.1878088.1338639962459.JavaMail.root@advansee.com>
References: <CAAMvbhGA=JUMH97V3OD_M2GZ=AqJfhUQMA6e8QXU2WLavzrvgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta12.web4all.fr (zose-mta12.web4all.fr [178.33.204.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0D624622
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jun 2012 14:21:49 +0200 (CEST)
In-Reply-To: <CAAMvbhGA=JUMH97V3OD_M2GZ=AqJfhUQMA6e8QXU2WLavzrvgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

SGkgSmFtZXMsCgpPbiAyIEp1bmUgMjAxMiAxMDowOSwgSmFtZXMgQ291cnRpZXItRHV0dG9uIDxq
YW1lcy5kdXR0b25AZ21haWwuY29tPiB3cm90ZToKPiBJbiB0aGUgdXNlcnNwYWNlIHRvIGtlcm5l
bCBpbnRlcmZhY2UuIEEgbWl4ZXIgY29udHJvbCBtdXN0IGhhdmUKPiBtaW4vbWF4IHZhbHVlcy4K
PiBXaGVuIHdyaXRpbmcgdGhlIHZhbHVlLCBhbGwgdmFsdWVzIHdpdGhpbiB0aGUgcmFuZ2Ugb2Yg
bWluIHRvIG1heAo+IG11c3QKPiBiZSB2YWxpZCB2YWx1ZXMuCj4gVGhlcmUgYXJlIGp1c3QgdG9v
IG1hbnkgdXNlciBsYW5kIHRvb2xzIHRoYXQgcmVseSBvbiB0aGlzIGZhY3QuCj4gVGhpbmsgb2Yg
dGhlIHVzZSBjYXNlIG9yICJOZXh0IHN0ZXAgbG91ZGVyIHBsZWFzZSIuIElmIHRoZSBjdXJyZW50
bHkKPiB3cml0dGVuIHZhbHVlIGlzIDB4NDAsIHRoZSBjdXJyZW50IHVzZXIgbGFuZCBtaXhlciBh
cHBzIHdvdWxkIHRyeSB0bwo+IHdyaXRlIDB4NDEsIHdpdGhvdXQgZXZlbiBib3RoZXJpbmcgdG8g
bG9vayBhdCB0aGUgZEIgdGFibGVzLgo+IElmIHlvdSBpbnN0ZWFkIGNoYW5nZSB0aGUgZHJpdmVy
IHRvIG1hcDoKPiAweDIxIHRvIDB4NDAgLT4gMHgwMCB0byAweDFmCj4gMHg2MSB0byAweGZmIC0+
IDB4MjAgdG8gMHhCRQo+IGFuZCBzZXQgbWluIHRvIDAsIGFuZCBtYXggdG8gMHhiZQo+IFRoZSB1
c2VyIHNwYWNlIHRvb2xzIHdpbGwgdGhlbiB3b3JrIGZpbmUuCj4gCj4gVGhlIGRCIGNvbnZlcnNp
b24gdGFibGVzIGFyZSBqdXN0IGEgZnJpZW5kbHkgd2F5IG9mIGRpc3BsYXlpbmcgYQo+IHNsaWdo
dGx5IG1vcmUgdXNlZnVsIGZpZ3VyZSB0byB0aGUgdXNlciB0aGFuIGEgcGVyY2VudGFnZS4KPiBJ
ZiB5b3UgaGF2ZSBoYXJkd2FyZSB3aXRoIGdhcHMgbGlrZSB0aGUgYWJvdmUsIHRoZSBrZXJuZWwg
ZHJpdmVyIHdpbGwKPiBoYXZlIHRvIGJlIGZpeGVkIHRvIHJlbW92ZSB0aGUgcHJvaGliaXRlZCBy
YW5nZXMgaW4gdGhlIGtlcm5lbCB0bwo+IHVzZXJzcGFjZSBBUEkuCj4gVGhpcyBzb3J0IG9mIGNv
bnZlcnNpb24gaXMgZG9uZSBpbiBtYW55IG90aGVyIGFsc2Ega2VybmVsIGRyaXZlcnMuCgpUaGFu
a3MgZm9yIHRoZSBkZXRhaWxzLiBJJ2xsIGRvIHRoYXQuCgpSZWdhcmRzLApCZW5vw650Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
