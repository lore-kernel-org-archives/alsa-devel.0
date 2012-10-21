From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: calling snd_ctl_notify from mixer ctl_put
Date: Sun, 21 Oct 2012 09:06:36 +0800
Message-ID: <CAN8cciatptJRKx2mg6abwLSPx2-WvThqVrsbn1YAbSGFBzdsgg@mail.gmail.com>
References: <201210112129.03097.linux@rainbow-software.org>
 <5077B2A1.5070608@ladisch.de>
 <201210132323.44951.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E12F265099
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 03:06:37 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so783581qao.17
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 18:06:36 -0700 (PDT)
In-Reply-To: <201210132323.44951.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

MjAxMi0xMC0xNCDkuIrljYg1OjI0IOaWvCAiT25kcmVqIFphcnkiIDxsaW51eEByYWluYm93LXNv
ZnR3YXJlLm9yZz4g5a+r6YGT77yaCj4KPiBPbiBGcmlkYXkgMTIgT2N0b2JlciAyMDEyIDA4OjAz
OjEzIENsZW1lbnMgTGFkaXNjaCB3cm90ZToKPiA+IE9uZHJlaiBaYXJ5IHdyb3RlOgo+ID4gPiBJ
IHdhbnQgdG8gZW5hYmxlL2Rpc2FibGUgc29tZSBtaXhlciBjb250cm9scyBiYXNlZCBvbiBzdGF0
ZSBvZiBhbm90aGVyCj4gPiA+IGNvbnRyb2wgKHN3aXRjaGluZyBiZXR3ZWVuIGxpbWl0ZXIgYW5k
IEFHQyBtb2RlKS4gU28gSSAocmUpc2V0IHRoZQo+ID4gPiBTTkRSVl9DVExfRUxFTV9BQ0NFU1Nf
SU5BQ1RJVkUgZmxhZyBpbiBrY3RsLT52ZFswXS5hY2Nlc3MKPiA+ID4gYW5kIHRoZW4gY2FsbCBz
bmRfY3RsX25vdGlmeShjYXJkLCBTTkRSVl9DVExfRVZFTlRfTUFTS19JTkZPLAoma2N0bC0+aWQp
Owo+ID4gPiBFdmVyeXRpbmcgZnJvbSBjdGxfcHV0KCkgbWl4ZXIgY2FsbGJhY2suCj4gPiA+Cj4g
PiA+IFdoZW4gY2hhbmdpbmcgdGhlIGNvbnRyb2wgdmFsdWUgaW4gYWxzYW1peGVyLCBpdCBjcmFz
aGVzIHdpdGg6Cj4gPiA+IGFsc2FtaXhlcjogc2ltcGxlLmM6OTQ4OiBzbmRfbWl4ZXJfc2VsZW1f
Z2V0X2VudW1faXRlbTogQXNzZXJ0aW9uCj4gPiA+IGAoZWxlbSktPnR5cGUgPT0gU05EX01JWEVS
X0VMRU1fU0lNUExFJyBmYWlsZWQuCj4gPgo+ID4gTG9va3MgbGlrZSBhIGJ1ZyBpbiBhbHNhbWl4
ZXIuCj4KPiBUaGFua3MuIEkndmUgbm93IHRyaWVkIHNvbWUgb3RoZXIgbWl4ZXJzIHRoYXQgYXJl
IHByZXNlbnQgaW4gRGViaWFuIGFuZAptb3N0Cj4gb2YgdGhlbSBhcmUgdW51c2FibGU6Cj4gYWxz
YW1peGVyZ3VpOiBkb2VzIG5vdCB1bmRlcnN0YW5kIEVOVU0gY29udHJvbHMKPiBnbm9tZS1hbHNh
bWl4ZXI6IGRvZXMgbm90IHVuZGVyc3RhbmQgRU5VTSBjb250cm9scwo+IGdub21lLXZvbHVtZS1j
b250cm9sOiBjcmFzaGVzIGxpa2UgYWxzYW1peGVyCj4geGZjZTQtbWl4ZXI6IGNyYXNoZXMgbGlr
ZSBhbHNhbWl4ZXIKPiBrbWl4IChUREUgMy41LjEzKTogZG9lcyBub3QgdXBkYXRlIGNvbnRyb2xz
IHdoZW4gc3dpdGNoaW5nIGxpbWl0ZXIvQUdDCj4ga21peCAoS0RFIDQpOiBjcmFzaGVzIGxpa2Ug
YWxzYW1peGVyCj4gKG90aGVyIG1peGVycyB3b24ndCBldmVuIHJ1biBhcyB0aGV5IHNlZW0gdG8g
YmUgT1NTLW9ubHkpCj4KPiBCdXQgdGhlcmUncyBvbmUgdGhhdCB3b3JrcyBmaW5lOiBRYXNNaXhl
ci4KPgoKdGhlIGFsc2FtaXhlciBhbHNvIGNyYXNoIG9ubHkgd2hlbiAiaW5kZXBlbmRlbnQgaGVh
ZHBob25lIiBlbnVtIG9mIGFkMTk4OAppcyB2aXNpYmxlIGluIGFsc2FtaXhlciB3aGVuIHRoZSBh
bmFsb2cgb3IgaGVhZHBob25lIHBsYXliYWNrIHN0cmVhbQpjbG9zZS9vcGVuIGluIHVidW50dSAx
Mi40Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
