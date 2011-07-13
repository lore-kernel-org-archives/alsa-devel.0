From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0 internal
	dma driver
Date: Wed, 13 Jul 2011 11:48:22 +0530
Message-ID: <CABb+yY3fV1=OreQzuCacbC1Jr4=r8HDcsJ7wXJTRzGvhzUkt2g@mail.gmail.com>
References: <1310520321-11106-1-git-send-email-sbkim73@samsung.com>
	<CA+s+8rc=nwggHhX7qZ0sCsH=z6qTDj9Gc2385xLgK0R+An85wQ@mail.gmail.com>
	<CABb+yY31mq-uber-iaXBSsCCYoq0W04whVzFHd6XEfshxwpT+w@mail.gmail.com>
	<s5hoc0yg1yy.wl%tiwai@suse.de>
	<CABb+yY1GXVXnWL2sdTWm5_d4SQtbJ3FpZe8_XyFrsHODG5GRag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CA4D1038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 08:18:22 +0200 (CEST)
Received: by bwa18 with SMTP id 18so5097169bwa.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2011 23:18:22 -0700 (PDT)
In-Reply-To: <CABb+yY1GXVXnWL2sdTWm5_d4SQtbJ3FpZe8_XyFrsHODG5GRag@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMTE6NDQgQU0sIEphc3NpIEJyYXIgPGphc3Npc2luZ2hi
cmFyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMTE6MjQgQU0s
IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6Cj4+PiA+PiArIMKgIMKgIMKgIC5j
aGFubmVsc19taW4gPSAyLAo+Pj4gPj4gKyDCoCDCoCDCoCAuY2hhbm5lbHNfbWF4ID0gMiwKPj4+
ID4+ICsgwqAgwqAgwqAgLmJ1ZmZlcl9ieXRlc19tYXggPSBNQVhfSURNQV9CVUZGRVIsCj4+PiA+
PiArIMKgIMKgIMKgIC5wZXJpb2RfYnl0ZXNfbWluID0gMTI4LAo+Pj4gPj4gKyDCoCDCoCDCoCAu
cGVyaW9kX2J5dGVzX21heCA9IE1BWF9JRE1BX1BFUklPRCwKPj4+ID4KPj4+ID4gSW4gdGhpcyBj
YXNlLCBNQVhfSURNQV9CVUZGRVIgaXMgMTYwayBhbmQgTUFYX0lETUFfUEVSSU9EIGlzIDEyOGss
Cj4+PiA+IGJ1ZmZlciBpcyBub3QgdHdpY2Ugb2YgcGVyaW9kLiBJZiB5b3Ugc2V0IGxpa2UgdGhp
cywgbWFueSBvZiBnZW5lcmFsCj4+PiA+IEFMU0EgYXBwbGljYXRpb25zIHJldHVybiBlcnJvciBv
biBpbml0aWFsIGJ1ZmZlcnMuCj4+PiBJIGRvbid0IHRoaW5rIHNvLiBEaWQgeW91IHNlZSBhbnkg
c3VjaCBwcm9ibGVtID8KPj4+IEluIG15IG9wbmlvbiwgQUxTQSB3aWxsIGFsd2F5cyB1c2UgMiBw
ZXJpb2RzIG9mIGFwcHJveC4gTUFYX0lETUFfQlVGRkVSLzIgYnl0ZXMKPj4KPj4gSXQncyBub3Qg
Z3VhcmFudGVlZCB1bmxlc3MgeW91IHNldCBleHBsaWNpdGx5IGEgaHdfY29uc3RyYWludCwgc3Vj
aCBhcwo+PiDCoCDCoHNuZF9wY21faHdfY29uc3RyYWludF9pbnRlZ2VyKHJ1bnRpbWUsIFNORFJW
X1BDTV9IV19QQVJBTV9QRVJJT0RTKTsKPj4KPj4gVGhlIEFMU0EgQVBJIGl0c2VsZiBhbGxvd3Mg
YSBidWZmZXIgc2l6ZSBub3QgYWxpZ25lZCB0byBhIHBlcmlvZCBzaXplLgo+IFN1cmUgaXQgZG9l
cyBhbmQgd2UgZG8gc2V0IHRoZSBjb25zdHJhaW50IGluIFNhbXN1bmcncyBub3JtYWwgRE1BCj4g
ZHJpdmVyIHdoZXJlIHBlcmlvZHNfbWF4IGlzIHF1aXRlIGxhcmdlLgo+Cj4gQW4gaW1wb3J0YW50
IHBhcnQgbWlzc2luZyBpbiBDbGF1ZGUncyBxdW90ZSBpcwo+ICsgwqAgwqAgwqAgLnBlcmlvZHNf
bWluID0gMSwKPiArIMKgIMKgIMKgIC5wZXJpb2RzX21heCA9IDIsCj4KPiBXaGVuIHRoZSBwZXJp
b2RzX21heCBpcyBvbmx5IDIsIHRoZSBjYWxjdWxhdGlvbnMgaW4gQUxTQSBtaWQtbGF5ZXIKPiBz
ZWVtIHRvIGFsd2F5cwo+IGRlY2lkZSBvbiB1c2luZyB0d28gZXF1YWwgc2l6ZSBwZXJpb2RzLgo+
Cj4gSSBkaWRuJ3QgZGlnIGluIHRoZSBsb2dpYyBidXQgd2Fzbid0IGFibGUgdG8gZ2V0IGFueSBh
cHBsaWNhdGlvbiB0bwo+IGNvbmZpZ3VyZSBzb21ldGhpbmcKPiBsaWtlIHtQZXJpb2Rfc2l6ZSA9
IDkwJSBvZiBCdWZmZXJfc2l6ZX0gwqB3aGljaCBpcyBhY3R1YWxseSBiZW5lZmljaWFsIGZvcgo+
IExvdy1Qb3dlci1BdWRpby1Nb2RlLgpJIG1lYW50IGFueSBzdGFuZGFyZCBhcHBsaWNhdGlvbiB3
aXRob3V0IG1vZGlmeWluZyBpdC4uLiBsaWtlIGFwbGF5LAptcGxheWVyLCBtYWRwbGF5IGV0Yy4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
