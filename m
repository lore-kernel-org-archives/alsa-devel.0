From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 03/20] ASoC: S3C64XX: I2S: Make BCLK
	independent of sample size
Date: Wed, 10 Mar 2010 21:46:15 +0900
Message-ID: <1b68c6791003100446k5766edb1r2249964c54a1ca99@mail.gmail.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<20100310123117.GA6850@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id D9061103902
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:46:16 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so472968qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 04:46:15 -0800 (PST)
In-Reply-To: <20100310123117.GA6850@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgOTozMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA0OjQ4OjUyUE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4+IEZvciBzb21lIENQVS1DT0RF
QyBhbmQgc291cmNlIGNsb2NrIGNvbWJpbmF0aW9uIHdlIG1pZ2h0IG5lZWQgdG8gc2V0Cj4+IEJD
TEsgdG8gTipTYW1wbGVfc2l6ZSpMUkNMSywgd2hlcmUgTiBtYXkgYmUgZXZlbiAzIG9yIDQsIG5v
dCBqdXN0IDIuCj4KPj4gV2UgY2FuIHNpbXBseSByZW1vdmUgdGhlIGRlcGVuZGVuY3kgb2YgQkNM
SyBvbiBzYW1wbGUgc2l6ZSBhcyB0aGVyZQo+PiBpcyBhbHJlYWR5IGEgY2FsbGJhY2soUzNDX0ky
U1YyX0RJVl9CQ0xLKSBhdmFpbGFibGUgdG8gc2V0IHJlcXVpcmVkIEJDTEsuCj4KPiBJJ3ZlIGFw
cGxpZWQgdGhpcyBidXQgSSdkIHJhdGhlciBzZWUgdGhlIGNvZGUgY2hhbmdlZCBzbyB0aGF0IHRo
ZSBCQ0xLCj4gaXMgc2V0IGF1dG9tYXRpY2FsbHkgYnkgZGVmYXVsdCBhbmQgdGhlIGV4cGxpY3Qg
ZGl2aWRlciBjb25maWd1cmF0aW9uCj4gZGlzYWJsZXMgdGhhdC4gwqBUaGlzIHdheSB3ZSBnZXQg
dGhlIGJlc3Qgb2YgYm90aCB3b3JsZHMgLSBtb3N0IHVzZXJzCj4gd29uJ3QgbmVlZCB0byB3b3Jy
eSBhYm91dCB0aGUgQkNMSyBjb25maWd1cmF0aW9uIGJ1dCB0aG9zZSB0aGF0IG5lZWQgdG8KPiBj
b25maWd1cmUgaXQgY2FuIGRvIHNvLiDCoEFuIGF3ZnVsIGxvdCBvZiB1c2VycyBkb24ndCByZWFs
bHkgdW5kZXJzdGFuZAo+IGF1ZGlvIGhhcmR3YXJlIGFuZCBmaW5kIGhhdmluZyB0byBsZWFybiBh
Ym91dCB3aGljaCBjbG9jayByYXRlcyB0aGV5Cj4gbmVlZCBhbmQgc28gb24gYSBiaXQgb2YgYSBs
ZWFybmluZyBjdXJ2ZS4KSSB3YXMgdGhpbmtpbmcgb2YgY2FsY3VsYXRpbmcgYWxsIHJlZ2lzdGVy
IGZpZWxkIHZhbHVlcyB3aXRoaW4gdGhlIENQVSBkcml2ZXIKYW5kIGxldCBNQUNISU5FIGRyaXZl
ciBzcGVjaWZ5IG9ubHkgZ2VuZXJhbCBwYXJhbWV0ZXJzIG9mIGF1ZGlvKGFzIGluCm1hbnkgQ09E
RUMgZHJpdmVycykuCkFmdGVyIHRoaXMgcGF0Y2ggc2VyaWVzLCB0aG91Z2guCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
