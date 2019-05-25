From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs
 are detected
Date: Sat, 25 May 2019 09:40:48 +0800
Message-ID: <210f78be-7988-0daf-1563-513a3da0ba06@canonical.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <s5hk1ege12p.wl-tiwai@suse.de>
 <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
 <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
 <72729168-214a-264d-c704-f718d7cfde4b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07702F806F7
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2019 03:42:07 +0200 (CEST)
In-Reply-To: <72729168-214a-264d-c704-f718d7cfde4b@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
Cc: Takashi Iwai <tiwai@suse.de>, Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTkvNS8yNSDkuIrljYgxMjoxMiwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4K
Pgo+IE9uIDUvMjQvMTkgMTA6NDUgQU0sIERhbmllbCBEcmFrZSB3cm90ZToKPj4gVGhhbmtzIGZv
ciB0aGUgcGF0Y2hlcyEKPj4KPj4gT24gRnJpLCBNYXkgMjQsIDIwMTkgYXQgNzoyNiBBTSBQaWVy
cmUtTG91aXMgQm9zc2FydAo+PiA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29t
PiB3cm90ZToKPj4+IEkgYW0gbm90IHN1cmUgaWYgaXQncyBhIGdvb2QgaWRlYSB0byBlbmFibGUg
dGhpcyBieSBkZWZhdWx0LCB0aGUKPj4+IGV4cGVyaWVuY2Ugb2YgdGhlIGZpcnN0IHJvdW5kIHNo
b3dlZCBpdCdzIHJpc2t5IHRvIG1ha2UgYXNzdW1wdGlvbnMgb24KPj4+IHdoYXQgQklPUyB2ZW5k
b3JzIGltcGxlbWVudGVkLgo+Pgo+PiBDYW4geW91IGNsYXJpZnkgd2hhdCB5b3UgbWVhbiBoZXJl
LCBhcmUgeW91IHNheWluZyB5b3UgZG9uJ3Qgd2FudCB0bwo+PiBlbmFibGUgdGhpcyBuZXcgRE1J
QyBoYXJkd2FyZSBzdXBwb3J0IGJ5IGRlZmF1bHQ/Cj4KPiBOby4gV2hhdCBJIGFtIHNheWluZyBp
cyB0aGF0Cj4gYSkgdGhlIGxlZ2FjeSBIRGF1ZGlvIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IERN
SUNzCj4gYikgdGhlIGRlY2lzaW9uIHRvIGFib3J0IHRoZSBIRGF1ZGlvIGxlZ2FjeSBkcml2ZXIg
cHJvYmUgc2hvdWxkIG5vdCBiZSAKPiB0aGUgZGVmYXVsdCwgc2luY2UgaXQgZGVwZW5kcyBvbiBC
SU9TIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHdyb25nIAo+IGFuZCBvbiB3aGljaCBJIGhhdmUg
Knplcm8qIGNvbnRyb2wuCj4KPiBUaGVyZSBhcmUgNCBjYXNlcyByZWFsbHk6Cj4KPiAxLiBETUlD
cyBhdHRhY2hlZCB0byBQQ0ggYW5kIEJJT1MvTkhMVCByZXBvcnRzIERNSUNTIC0+IGFib3J0IEhE
YXVkaW8gCj4gbGVnYWN5IHByb2JlCj4gMi4gTm8gRE1JQ3MgYXR0YWNoZWQgdG8gUENIIGFuZCBC
SU9TL05ITFQgZG9lcyBub3QgcmVwb3J0IERNSUNzIC0+IAo+IGNvbnRpbnVlIHByb2JlIGFuZCB1
c2UgSERBdWRpbyBsZWdhY3kuCj4gMy4gRE1JQ3MgYXR0YWNoZWQgdG8gUENIIGFuZCBCSU9TL05I
TFQgZG9lcyBub3QgcmVwb3J0IERNSUNzIC0+IGJyb2tlbiAKPiBjb25maWcsIHdlIHdpbGwgbmVl
ZCBhbiBvcHRpb24gdG8gYWJvcnQgdGhlIHByb2JlIGJ5IGZvcmNlIGFuZCBpZ25vcmUgCj4gdGhl
IEJJT1MgaWYgeW91IGNhcmUgYWJvdXQgYXVkaW8gY2FwdHVyZS4KPiA0LiBubyBETUlDcyBhdHRh
Y2hlZCB0byBQQ0ggYW5kIEJJT1MvTkhMVCByZXBvcnRzIERNSUNzIC0+IGJyb2tlbiAKPiBjb25m
aWcsIHdlIG5lZWQgYW4gb3B0aW9uIHRvIGlnbm9yZSB0aGUgQklPUyBhbmQgY29udGludWUgdGhl
IHByb2JlLgoKR290IGl0LMKgIHdlIHdpbGwgZG8gYSB0ZXN0IG9uIGEgY291cGxlIG9mIG1hY2hp
bmVzLCBsZXQgdXMgc2VlIGlmIHdlIGNhbiAKbWVldCAzIGFuZCA0IGluIHJlYWxpdHkuCgo+Cj4g
RG9lcyB0aGlzIGhlbHA/Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
