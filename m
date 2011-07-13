From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0 internal
	dma driver
Date: Wed, 13 Jul 2011 11:44:03 +0530
Message-ID: <CABb+yY1GXVXnWL2sdTWm5_d4SQtbJ3FpZe8_XyFrsHODG5GRag@mail.gmail.com>
References: <1310520321-11106-1-git-send-email-sbkim73@samsung.com>
	<CA+s+8rc=nwggHhX7qZ0sCsH=z6qTDj9Gc2385xLgK0R+An85wQ@mail.gmail.com>
	<CABb+yY31mq-uber-iaXBSsCCYoq0W04whVzFHd6XEfshxwpT+w@mail.gmail.com>
	<s5hoc0yg1yy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD1F1038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 08:14:04 +0200 (CEST)
Received: by bwa18 with SMTP id 18so5095188bwa.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2011 23:14:04 -0700 (PDT)
In-Reply-To: <s5hoc0yg1yy.wl%tiwai@suse.de>
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

T24gV2VkLCBKdWwgMTMsIDIwMTEgYXQgMTE6MjQgQU0sIFRha2FzaGkgSXdhaSA8dGl3YWlAc3Vz
ZS5kZT4gd3JvdGU6Cj4+ID4+ICsgwqAgwqAgwqAgLmNoYW5uZWxzX21pbiA9IDIsCj4+ID4+ICsg
wqAgwqAgwqAgLmNoYW5uZWxzX21heCA9IDIsCj4+ID4+ICsgwqAgwqAgwqAgLmJ1ZmZlcl9ieXRl
c19tYXggPSBNQVhfSURNQV9CVUZGRVIsCj4+ID4+ICsgwqAgwqAgwqAgLnBlcmlvZF9ieXRlc19t
aW4gPSAxMjgsCj4+ID4+ICsgwqAgwqAgwqAgLnBlcmlvZF9ieXRlc19tYXggPSBNQVhfSURNQV9Q
RVJJT0QsCj4+ID4KPj4gPiBJbiB0aGlzIGNhc2UsIE1BWF9JRE1BX0JVRkZFUiBpcyAxNjBrIGFu
ZCBNQVhfSURNQV9QRVJJT0QgaXMgMTI4aywKPj4gPiBidWZmZXIgaXMgbm90IHR3aWNlIG9mIHBl
cmlvZC4gSWYgeW91IHNldCBsaWtlIHRoaXMsIG1hbnkgb2YgZ2VuZXJhbAo+PiA+IEFMU0EgYXBw
bGljYXRpb25zIHJldHVybiBlcnJvciBvbiBpbml0aWFsIGJ1ZmZlcnMuCj4+IEkgZG9uJ3QgdGhp
bmsgc28uIERpZCB5b3Ugc2VlIGFueSBzdWNoIHByb2JsZW0gPwo+PiBJbiBteSBvcG5pb24sIEFM
U0Egd2lsbCBhbHdheXMgdXNlIDIgcGVyaW9kcyBvZiBhcHByb3guIE1BWF9JRE1BX0JVRkZFUi8y
IGJ5dGVzCj4KPiBJdCdzIG5vdCBndWFyYW50ZWVkIHVubGVzcyB5b3Ugc2V0IGV4cGxpY2l0bHkg
YSBod19jb25zdHJhaW50LCBzdWNoIGFzCj4gwqAgwqBzbmRfcGNtX2h3X2NvbnN0cmFpbnRfaW50
ZWdlcihydW50aW1lLCBTTkRSVl9QQ01fSFdfUEFSQU1fUEVSSU9EUyk7Cj4KPiBUaGUgQUxTQSBB
UEkgaXRzZWxmIGFsbG93cyBhIGJ1ZmZlciBzaXplIG5vdCBhbGlnbmVkIHRvIGEgcGVyaW9kIHNp
emUuClN1cmUgaXQgZG9lcyBhbmQgd2UgZG8gc2V0IHRoZSBjb25zdHJhaW50IGluIFNhbXN1bmcn
cyBub3JtYWwgRE1BCmRyaXZlciB3aGVyZSBwZXJpb2RzX21heCBpcyBxdWl0ZSBsYXJnZS4KCkFu
IGltcG9ydGFudCBwYXJ0IG1pc3NpbmcgaW4gQ2xhdWRlJ3MgcXVvdGUgaXMKKyAgICAgICAucGVy
aW9kc19taW4gPSAxLAorICAgICAgIC5wZXJpb2RzX21heCA9IDIsCgpXaGVuIHRoZSBwZXJpb2Rz
X21heCBpcyBvbmx5IDIsIHRoZSBjYWxjdWxhdGlvbnMgaW4gQUxTQSBtaWQtbGF5ZXIKc2VlbSB0
byBhbHdheXMKZGVjaWRlIG9uIHVzaW5nIHR3byBlcXVhbCBzaXplIHBlcmlvZHMuCgpJIGRpZG4n
dCBkaWcgaW4gdGhlIGxvZ2ljIGJ1dCB3YXNuJ3QgYWJsZSB0byBnZXQgYW55IGFwcGxpY2F0aW9u
IHRvCmNvbmZpZ3VyZSBzb21ldGhpbmcKbGlrZSB7UGVyaW9kX3NpemUgPSA5MCUgb2YgQnVmZmVy
X3NpemV9ICB3aGljaCBpcyBhY3R1YWxseSBiZW5lZmljaWFsIGZvcgpMb3ctUG93ZXItQXVkaW8t
TW9kZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
