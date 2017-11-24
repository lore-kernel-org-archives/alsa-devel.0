From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v4 08/12] IIO: ADC: add STM32 DFSDM sigma
 delta ADC support
Date: Fri, 24 Nov 2017 15:49:46 +0100
Message-ID: <e05656e4-6ac4-b249-670f-98f2c42d7968@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
 <1510222354-15290-9-git-send-email-arnaud.pouliquen@st.com>
 <20171119142935.044a0764@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B05D26743E
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 15:49:50 +0100 (CET)
In-Reply-To: <20171119142935.044a0764@archlinux>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiAxMS8xOS8yMDE3IDAzOjI5IFBNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOgo+IE9uIFRo
dSwgOSBOb3YgMjAxNyAxMToxMjozMCArMDEwMAo+IEFybmF1ZCBQb3VsaXF1ZW4gPGFybmF1ZC5w
b3VsaXF1ZW5Ac3QuY29tPiB3cm90ZToKPiAKPj4gQWRkIERGU0RNIGRyaXZlciB0byBoYW5kbGUg
c2lnbWEgZGVsdGEgQURDLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQXJuYXVkIFBvdWxpcXVlbiA8
YXJuYXVkLnBvdWxpcXVlbkBzdC5jb20+Cj4+IC0tLQo+PsKgIGRyaXZlcnMvaWlvL2FkYy9LY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzICsKPj7CoCBkcml2ZXJzL2lpby9hZGMvTWFr
ZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4+wqAgZHJpdmVycy9paW8vYWRjL3N0
bTMyLWRmc2RtLWFkYy5jIHwgNzQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4+wqAgMyBmaWxlcyBjaGFuZ2VkLCA3NTUgaW5zZXJ0aW9ucygrKQo+PsKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2lpby9hZGMvc3RtMzItZGZzZG0tYWRjLmMKClsuLi5dCgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jIGIvZHJpdmVycy9p
aW8vYWRjL3N0bTMyLWRmc2RtLWFkYy5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4
IDAwMDAwMDAuLmY5NDE5YWIKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvc3RtMzItZGZzZG0tYWRjLmMKPj4gQEAgLTAsMCArMSw3NDEgQEAKClsuLi5dCgo+PiArc3Rh
dGljIGludCBzdG0zMl9kZnNkbV9hZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCj4+ICt7Cj4+ICvCoMKgwqDCoCBzdHJ1Y3Qgc3RtMzJfZGZzZG1fYWRjICphZGMgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKPj4gK8KgwqDCoMKgIHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYgPSBpaW9fcHJpdl90b19kZXYoYWRjKTsKPj4gKwo+PiArwqDCoMKgwqAgaWlvX2Rldmlj
ZV91bnJlZ2lzdGVyKGluZGlvX2Rldik7Cj4gR2l2ZW4gdGhhdCBhbGwgd2UgaGF2ZSBoZXJlIGlz
IGRldmljZSB1bnJlZ2lzdGVyLCB5b3UgY291bGQKPiB1c2UgdGhlIGRldm1faWlvX2RldmljZV9y
ZWdpc3RlciBjYWxsIGFuZCBkcm9wIHRoZSByZW1vdmUgZW50aXJlbHkuCj4gKG9mIGNvdXJzZSB5
b3UgbWF5IGFkZCBzdHVmZiBoZXJlIGluIGxhdGVyIHBhdGNoZXMgLSBJIGhhdmVuJ3QKPiBsb29r
ZWQgeWV0IDspClllcywgdGhlIG5leHQgcGF0Y2ggbWFrZXMgZGV2bV9paW9fZGV2aWNlX3JlZ2lz
dGVyIHVzZWxlc3MsIHNvIGkgZG9uJ3QKdXNlIGl0IGhlcmUuCgpSZWdhcmRzCgpBcm5hdWQKPj4g
Kwo+PiArwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIHN0bTMyX2Rmc2RtX2FkY19kcml2ZXIgPSB7Cj4+ICvCoMKgwqDCoCAuZHJp
dmVyID0gewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lID0gInN0bTMyLWRmc2Rt
LWFkYyIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLm9mX21hdGNoX3RhYmxlID0gc3Rt
MzJfZGZzZG1fYWRjX21hdGNoLAo+PiArwqDCoMKgwqAgfSwKPj4gK8KgwqDCoMKgIC5wcm9iZSA9
IHN0bTMyX2Rmc2RtX2FkY19wcm9iZSwKPj4gK8KgwqDCoMKgIC5yZW1vdmUgPSBzdG0zMl9kZnNk
bV9hZGNfcmVtb3ZlLAo+PiArCj4+ICt9Owo+PiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihzdG0z
Ml9kZnNkbV9hZGNfZHJpdmVyKTsKPj4gKwo+PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJTVE0zMiBz
aWdtYSBkZWx0YSBBREMiKTsKPj4gK01PRFVMRV9BVVRIT1IoIkFybmF1ZCBQb3VsaXF1ZW4gPGFy
bmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPiIpOwo+PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwo+
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
