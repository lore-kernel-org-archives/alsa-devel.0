From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: Re: ASoC: TLV320AIC3x: Adding additional functionality
 for 3106 with [Patch] for discuss
Date: Tue, 15 Mar 2016 13:17:41 +0300
Message-ID: <56E7E145.5010904@mcsplus.ru>
References: <56E69B3F.8090306@mcsplus.ru> <56E6CEE9.5030802@ti.com>
 <56E6D177.5050108@mcsplus.ru> <56E6E921.5030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [94.100.177.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 450F62654D9
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 11:17:48 +0100 (CET)
In-Reply-To: <56E6E921.5030007@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Jyri Sarha <jsarha@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

MTQuMDMuMjAxNiAxOTozOCwgUGV0ZXIgVWpmYWx1c2kg0L/QuNGI0LXRgjoKPiBPbiAwMy8xNC8y
MDE2IDA0OjU3IFBNLCBUaW11ciBLYXJhbGRpbiB3cm90ZToKPj4gSGksIFBldGVyIQo+PiBXaGF0
J3MgYWJvdXQgcGxhY2luZyBjYXB0dXJlIGNvbnRyb2xzIGluIHRoZSBQbGF5YmFjayBzZWN0aW9u
IG9mIEFsc2FtaXhlcgo+PiB2aWV3Pwo+IFllYWgsIGl0IGlzIGFubm95aW5nLiBUaGV5IGNhbiBi
ZSBmaXhlZCBieToKPiAiTGluZTFMIFN3aXRjaCIgLT4gIkxpbmUxTCBDYXB0dXJlIFN3aXRjaCIg
YW5kIHNvIG9uLiBPbiB0aGUgb3RoZXIgaGFuZCB3ZSBoYWQKPiB0aGVzZSB1bmZvcnR1bmF0ZSBj
b250cm9sIG5hbWVzIEkgdGhpbmsgc2luY2UgdGhlIGJlZ2lubmluZyBhbmQgaXQgaXMga2luZCBv
Zgo+IGFuIEFCSSBmb3IgZXhpc3RpbmcgcHJvZHVjdHMuIEkgZG9uJ3QgaGF2ZSBpc3N1ZSBjaGFu
Z2luZyB0aGVtLCBidXQgZXhpc3RpbmcKPiBzZXR1cHMgcmVseWluZyBvbiB0aGUgY29udHJvbCBu
YW1lcyBtaWdodCBicmVhay4uLgo+Cj4+IERvZXMgcmVzZXR0aW5nIG9mIHNvbWUgcmVnaXN0ZXJz
IGR1cmluZyBzdGFydC9zdG9wIG9mIHJlY29yZGluZwo+PiBjb25uZWN0IHdpdGggaXQ/Cj4gTm90
IHN1cmUgd2hhdCB5b3UgbWVhbi4KPgpJIG1lYW4gY3VycmVudCBzaXR1YXRpb246CgojaTJjZHVt
cCAtZiAteSAtciAxMy0xMyAxIDB4MWIKUmVzdWx0OiAweDAwCiNhcmVjb3JkIHRlc3Qud2F2ICYK
I2kyY2R1bXAgLWYgLXkgLXIgMTMtMTMgMSAweDFiClJlc3VsdDogMHgwMAojIGFtaXhlciBzc2V0
ICdIZWFkc2V0IERldGVjdCBFbmFibGUnICpvbioKI2kyY2R1bXAgLWYgLXkgLXIgMTMtMTMgMSAw
eDFiClJlc3VsdDoqMHg4MCoKI2tpbGxhbGwgYXJlY29yZAojaTJjZHVtcCAtZiAteSAtciAxMy0x
MyAxIDB4MWIKUmVzdWx0OiAweDAwCiNhcmVjb3JkIHRlc3Qud2F2ICYKI2kyY2R1bXAgLWYgLXkg
LXIgMTMtMTMgMSAweDFiClJlc3VsdDoqMHgwMAoqI2tpbGxhbGwgYXJlY29yZCoKKmFtaXhlciBz
c2V0ICdIZWFkc2V0IERldGVjdCBFbmFibGUnKm9uKioKKiNpMmNkdW1wIC1mIC15IC1yIDEzLTEz
IDEgMHgxYgpSZXN1bHQ6KioweDAwCioqI2FtaXhlciBzc2V0ICdIZWFkc2V0IERldGVjdCBFbmFi
bGUnIG9mZgoqYW1peGVyOiBJbnZhbGlkIGNvbW1hbmQhKgoKU28gc3RhdGUgb2YgJ0hlYWRzZXQg
RGV0ZWN0IEVuYWJsZScgYW5kIG90aGVycyBvZiBteSBjb250cm9scyB3ZXJlIG5vdCAKc3RvcmVk
IGR1cmluZyBhcmVjb3JkL2FwbGF5IHJlc3RhcnQgKG9wZW4gYW5kIGNsb3NlIGRldmljZSkuCgoK
CgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
