From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
Date: Tue, 29 Apr 2014 16:30:43 +0200
Message-ID: <535FB793.5050200@metafoo.de>
References: <6606961.lAGLvkNsEj@wuerfel> <4270904.84oGcCXL4B@wuerfel>
 <535F8594.40609@metafoo.de> <4275868.O962kiiyJa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4275868.O962kiiyJa@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Alexander Shiyan <shc_work@mail.ru>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

T24gMDQvMjkvMjAxNCAwMzozMCBQTSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBUdWVzZGF5
IDI5IEFwcmlsIDIwMTQgMTI6NTc6MjQgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOgo+PiBPbiAw
NC8yOS8yMDE0IDEyOjM3IFBNLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+Pj4gT24gVHVlc2RheSAy
OSBBcHJpbCAyMDE0IDA3OjA3OjMzIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6Cj4+Pj4gTW9uLCAy
OCBBcHIgMjAxNCAyMzoxMjoxNCArMDIwMCDQvtGCIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+Ogo+Pj4+PiBPbiBUdWVzZGF5IDI5IEFwcmlsIDIwMTQgMDA6MzU6NDEgQWxleGFuZGVyIFNo
aXlhbiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBTbywgSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGlz
IGVycm9yIGhhcHBlbiwgYXMgd2VsbCBhcyBJIGNhbiBub3QKPj4+Pj4+IHJlcHJvZHVjZSB0aGlz
Li4uCj4+Pj4+Cj4+Pj4+IEl0J3MgcHJvYmFibHkgQ09ORklHX1NORF9TT0NfSU1YX1BDTV9ETUE9
bSBhbmQgQ09ORklHX1NORF9TT0NfRlNMX1NTST15IHRoZW4uCj4+Pj4+IFdoYXQgaXMgdGhlIGlu
dGVuZGVkIGJlaGF2aW9yIGluIHRoaXMgY2FzZT8gU2hvdWxkIENPTkZJR19TTkRfU09DX0ZTTF9T
U0kKPj4+Pj4gYmUgZm9yY2VkIHRvIGJlIGEgbW9kdWxlIGFzIHdlbGw/Cj4+Pj4KPj4+PiBIbW0s
IHllcy4uLgo+Pj4+IEkgdGhvdWdodCB0aGF0IEkgaGFkIGFscmVhZHkgc29sdmVkIGEgc2ltaWxh
ciBwcm9ibGVtIGZvciB0aGUgZWFybGllcgo+Pj4+IHZlcnNpb24gb2YgdGhlIHBhdGNoIC4uLgo+
Pj4KPj4+IEhvdyBhYm91dCB0aGlzPwo+Pgo+PiBIYXZpbmcgRlNMX1NTSS9GU0xfU1BESUYsIGJ1
dCBub3QgU05EX1NPQ19JTVhfUENNX0RNQSBkb2VzIG5vdCBtYWtlIHNlbnNlIG9uCj4+IGlNWC4K
Pj4gU28gaG93IGFib3V0Ogo+Pgo+PiAgICAgICAgICBzZWxlY3QgU05EX1NPQ19JTVhfUENNX0RN
QSBpZiBTTkRfSU1YX1NPQwo+Pgo+PiBhbmQgcmVtb3ZlIGFsbCB0aGUgb3RoZXIgJ3NlbGVjdCBT
TkRfU09DX0lNWF9QQ01fRE1BJyBzdGF0ZW1lbnRzLiBUaGF0J3MgaW4KPj4gbXkgb3BpbmlvbiBt
dWNoIG5pY2VyLgo+Cj4gWWVzLCBtYWtlcyBzZW5zZS4gU2hvdWxkIEkgZG8gYW5vdGhlciB2ZXJz
aW9uIG9mIHRoZSBwYXRjaD8KClllcy4gVGhlIHBhdGNoIHNob3VsZCBhbHNvIGFkZCBhIHNlbGVj
dCBmb3IgU05EX1NPQ19JTVhfUENNX0ZJUSBhcyB0aGF0IGlzIAp1c2VkIGluIHRoZSBzYW1lIHdh
eSBpbiB0aGUgZnNsX3NzaSBkcml2ZXIuIElmIGFueWJvZHkgaXMgYWZyYWlkIHRoYXQgCnNlbGVj
dGluZyBib3RoIFNORF9TT0NfSU1YX1BDTV9GSVEgYW5kIFNORF9TT0NfSU1YX1BDTV9ETUEgYnkg
ZGVmYXVsdCBhZGRzIAp0b28gbXVjaCBvdmVyaGVhZCB5b3UgY291bGQgYWRkIGJvb2xlYW4gc3Vi
LW9wdGlvbnMgdGhhdCBhbGxvdyB0byAKZW5hYmxlL2Rpc2FibGUgc3VwcG9ydCBpbmRpdmlkdWFs
bHkuCgotIExhcnMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
