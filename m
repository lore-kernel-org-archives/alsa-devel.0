From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
	define the relationship between audio channel and tdm slot
Date: Tue, 18 Aug 2009 10:53:39 +0800
Message-ID: <3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f226.google.com (mail-gx0-f226.google.com
	[209.85.217.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 996FA243A1
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 04:54:00 +0200 (CEST)
Received: by gxk26 with SMTP id 26so4452672gxk.22
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2009 19:53:59 -0700 (PDT)
In-Reply-To: <20090817175010.GA19707@rakim.wolfsonmicro.main>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBdWcgMTgsIDIwMDkgYXQgMTo1MCBBTSwgTWFyawpCcm93bjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBdWcgMTMsIDIwMDkgYXQg
MTI6MjU6MTFQTSArMDgwMCwgQmFycnkgU29uZyB3cm90ZToKPgo+PiBGb3IgYWQxOTM4LCB0aGUg
YXVkaW8gY2hhbm5lbCBuIGp1c3QgdXNlcyBzbG90IG4sIGJ1dCBmb3IgYWQxODM2LCBpdCdzCj4+
IGRpZmZlcmVudCwgY2hhbm5lbCAwIHVzZXMgc2xvdCAwLCBjaGFubmVsIDEgdXNlcyBzbG90IDQs
IGNoYW5uZWxzIDIgdXNlcwo+PiBzbG90MSwgLi4uIFNvIGFkZCBzZXRfdGRtX3Nsb3QgZW50cnkg
YW5kIHVzZSB0aGUgbWFzayBmaWVsZCB0byBkZWZpbmUKPj4gdGhlIHJlbGF0aW9uc2hpcCBiZXR3
ZWVuIGF1ZGlvIGNoYW5uZWwgYW5kIHNsb3QgbnVtYmVyLgo+Cj4gSSB0aGluayB3aGF0IHlvdSdy
ZSB0cnlpbmcgdG8gZGVzY3JpYmUgaGVyZSBpcyB0aGF0IHRoZSBkZXZpY2UgaXMKPiBleHBlY3Rp
bmcgdG8gc2VlIGFsbCB0aGUgbGVmdCBjaGFubmVscyBvbiB0aGUgYnVzIGZvbGxvd2VkIGJ5IGFs
bCB0aGUKPiByaWdodCBjaGFubmVscz8gwqBUaGlzIGlzIHRoZSBub3JtYWwgY2FzZSBmb3IgSTJT
IFRETSBzbyBubyB1bnVzdWFsCj4gY29uZmlndXJhdGlvbiBpcyByZXF1aXJlZCBpbiBvcmRlciB0
byBpbXBsZW1lbnQgaXQuCj4KPiBJIHJlYWxseSBkb24ndCB0aGluayB3ZSBzaG91bGQgaGF2ZSBC
bGFja2ZpbiBpbXBsZW1lbnRpbmcgYSBkaWZmZXJlbnQKPiBBUEkgaGVyZSAtIGl0IG1ha2VzIHRo
ZSBURE0gc2xvdCBBUEkgbXVjaCBoYXJkZXIgdG8gdXNlLiDCoEluc3RlYWQgd2UKPiBzaG91bGQg
aGF2ZSBhIGNvbnNpc3RlbnQgQVBJIGJldHdlZW4gYWxsIGRldmljZXMuIMKgVGhpcyBtYXkgbWVh
biB0aGF0IHdlCj4gbmVlZCB0byBleHRlbmQgdGhlIEFQSXMgaGVyZS4KPgpEbyB5b3UgbWVhbiB5
b3Ugd2lsbCBleHRlbmQgVERNIEFQSSB0byBoYW5kbGUgdGhpcz8gSSBjYW4gZm9sbG93IHlvdXIK
b24tZ29pbmcgY2hhbmdlcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
