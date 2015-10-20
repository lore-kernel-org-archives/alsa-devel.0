From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5 v2] ALSA: firewire-tascam: fix sending
 the same MIDI bytes in two transactions
Date: Wed, 21 Oct 2015 07:46:17 +0900
Message-ID: <5626C439.4070004@sakamocchi.jp>
References: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hlhax1kcm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 31D502604C6
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 00:46:24 +0200 (CEST)
In-Reply-To: <s5hlhax1kcm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

T24gMjAxNeW5tDEw5pyIMjHml6UgMDM6MTEsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBUdWUs
IDIwIE9jdCAyMDE1IDE2OjQ2OjU0ICswMjAwLAo+IFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4+
Cj4+IEhpLAo+Pgo+PiBUaGlzIHBhdGNoc2V0IGlzIHJldmlzZWQgdmVyc2lvbiBvZiBteSBwcmV2
aW91cyBwb3N0Ogo+PiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9h
bHNhLWRldmVsLzIwMTUtT2N0b2Jlci8wOTkxMjMuaHRtbAo+Pgo+PiBUaGUgbWFpbiBwdXJwb3Nl
IG9mIHRoaXMgcGF0Y2hzZXQgaXMgdG8gZml4IGFuIGlzc3VlIHRoYXQgYSB0cmFuc2FjdGlvbiBj
YW4KPj4gaW5jbHVkZSBNSURJIGJ5dGVzIGluIHRoZSBuZXh0IG1lc3NhZ2UuIFRoZSBsYXN0IHBh
dGNoIHNvbHZlcyB0aGlzIGlzc3VlLAo+PiBhbmQgdGhlIGZpcnN0IDQgcGF0Y2hlcyBhcmUgZm9y
IGJldHRlciBzaGFwZSBvZiBjb2RlIGluY2x1ZGluZyBhIHNtYWxsCj4+IGZpeGVzLgo+Pgo+PiBD
aGFuZ2VzOgo+PiAgKiBhZGQgYnVmZmVyIGFsaWFzCj4+ICAqIHJlZmluZSBsb2NhbCB2YXJpYWJs
ZXMKPiAKPiBBcHBsaWVzIGFsbCBwYXRjaGVzIG5vdy4gIFRoYW5rcy4KClRoYW5rcy4KCkluIHRo
aXMgZGV2ZWxvcGluZyBwZXJpb2QsIEknbGwgcG9zdCBzb21lIHBhdGNoZXMgZm9yIHJlZmFjdG9y
aW5nIG9mCmZpcmV3b3JrcyBhbmQgYmVib2IgbW9kdWxlcyB0aWxsIHRoaXMgd2Vla2VuZCwgdGhl
biBmaW5pc2ggbXkgd29yayBmb3IgNC40LgoKClJlZ2FyZHMKClRha2FzaGkgU2FrYW1vdG8KCj4g
Cj4gCj4gVGFrYXNoaQo+IAo+Pgo+Pgo+PiBUYWthc2hpIFNha2Ftb3RvICg1KToKPj4gICBBTFNB
OiBmaXJld2lyZS10YXNjYW06IHJlbW92ZSBidWZmZXIgaW5pdGlhbGl6YXRpb24gaW4gZHJpdmVy
IHNpZGUKPj4gICBBTFNBOiBmaXJld2lyZS10YXNjYW06IGNoYW5nZSB0eXBlIG9mIHZhbGlhYmxl
cyBhY2NvcmRpbmcgdG8gZnVuY3Rpb24KPj4gICAgIHByb3RvdHlwZQo+PiAgIEFMU0E6IGZpcmV3
aXJlLXRhc2NhbTogdXNlIGJldHRlciBuYW1lIGZvciBsb2NhbCB2YXJpYWJsZXMgdG8gZGVzY3Jp
YmUKPj4gICAgIHRoZWlyIGludGVuc2lvbgo+PiAgIEFMU0E6IGZpcmV3aXJlLXRhc2NhbTogZml4
IGxvb3AgY29uZGl0aW9uIHdpdGggc29tZSByZWFkYWJsZSB2YXJpYWJsZXMKPj4gICBBTFNBOiBm
aXJld2lyZS10YXNjYW06IGNsZWFyIGV4dHJhIE1JREkgYnl0ZSBpbiBhbiBhc3luY2hyb25vdXMK
Pj4gICAgIHRyYW5zYWN0aW9uCj4+Cj4+ICBzb3VuZC9maXJld2lyZS90YXNjYW0vdGFzY2FtLXRy
YW5zYWN0aW9uLmMgfCA3MyArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkKPj4KPj4gLS0gCj4+
IDIuMS40Cj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
