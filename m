From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Re: Soc MC13783: Improve driver to handle LineIn
Date: Thu, 24 Jan 2013 12:17:03 +0100
Message-ID: <5101182F.1090404@gmail.com>
References: <510101FE.4060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 988532615F8
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 12:18:04 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hm11so319807wib.14
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 03:18:04 -0800 (PST)
In-Reply-To: <510101FE.4060307@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGksCk9uIDAxLzI0LzIwMTMgMTA6NDIgQU0sIEdhw6t0YW4gQ2FybGllciB3cm90ZToKPiBIZWxs
bywKPiBJIHdvdWxkIGxpa2UgdG8gaW1wcm92ZSBNQzEzNzgzIGRyaXZlciB0byBiZSBhYmxlIHRv
IGNvbnRyb2wgYnlwYXNzIG9mCj4gTGluZUluIChSWElOUi9MKSBhbmQgZmVlZCBBbmFsb2cgTGlu
ZUluIHN0cmVhbSBpbnRvIG91cHV0IE1peGVyIHZpYQo+IEFERFJYSU4gZmxhZy4KQnkgY2xlYW5p
bmctdXAvcmV3cml0aW5nIG15IGNvZGUsIEkgZ2V0IHRoZSBieXBhc3Mgd29ya2luZy4KTm93IEkg
d2lsbCB0cnkgdG8gcHV0IGEgbWl4ZXIgd2lkZ2V0IHJlZmVyZW5jZWQgIk1peGVyLCBBZGRlciwg
QmFsYW5jZSIgCmluICJBdWRpbyBPdXB1dCBTZWN0aW9uIERpYWdyYW0iIG9mIFVzZXIncyBndWlk
ZSB0byBiZSBhYmxlIHRvIHNlbGVjdCAKd2hpY2ggYW5hbG9nIGF1ZGlvIHN0cmVhbSB3aWxsIGJl
IGZlZCBpbnRvIHNlbGVjdG9yIHRoZW4gSSB3aWxsIGFkZCAKY29udHJvbCB0byBiZSBhYmxlIHRv
IHNlbGVjdCBuZWVkZWQgU09DX0RBUE1fT1VUUFVULgoKSXMgdGhlcmUgYSB3YXkgdG8gZGVmaW5l
ZCBzdGF0ZSBvZiBhIFNORF9TT0NfREFQTV9TV0lUQ0ggdG8gMSBvciAwIGJ5IApkZWZhdWx0ID8K
Cj4gVGhpcyBmaXJzdCBzdGVwIG9uZSBpcyBmb3IgdGVzdCBwdXJwb3NlIGJ1dCBJIGFsc28gbmVl
ZCB0byBzZWxlY3QKPiBSWElOUi9MIGFzIGNhcHR1cmUgc291cmNlIChJIHNhdyBpbiBSTSB0aGF0
IENPREVDIG11c3QgYmUgZW5hYmxlZCBhbmQKPiBvbmx5IFJYSU5SIGZsYWcgbXVzdCBiZSBzZWxl
Y3RlZCBhcyBpbnB1dCkgYnV0IG5vdGhpbmcgc2VlbXMgdG8gYmUKPiBjYXB0dXJlZCB0aGlzIGlz
IHdoeSBJIG5lZWQgYnlwYXNzIHdvcmtpbmcgdG8gdGVzdCBpbnB1dCBsZXZlbCwgYW5kIHNvIG9u
Lgo+Cj4gSSB0cnkgdG8gY3JlYXRlIGEgTWl4ZXIgYmFzZWQgb24gb3RoZXIgZHJpdmVyIGJ1dCBp
dCBkb2Vzbid0IHdvcmsuCj4gSSB0cnkgdG8gZmluYyBpbmZvcm1hdGlvbiBhYm91dCB3aWRnZXQg
bWFjcm8gU05EX1NPQ19EQVBNXyogYnV0IGl0IGlzCj4gaGFyZCB0byBmaW5kIHNvbWV0aGluZyBy
ZWxldmFudC4KPiAqIFdoaWNoIHdpZGdldHMgY2FuIGJlIGxpbmsgdG9nZXRoZXIgPwo+ICogSXMg
dGhlcmUgZnVuY3Rpb25hbCBkaWZmZXJlbmNlIGJldHdlZW4gVklSVCBhbmQgbm9uLVZJUlQgd2lk
Z2V0ID8KPgo+IEkgd2lsbCBwb3N0IG15IGNvZGUgaW4gc29tZSBtaW51dGVzIGFmdGVyIGNsZWFu
LXVwLgo+Cj4gVGhhbmtzIGEgbG90Lgo+IEdhw6t0YW4gQ2FybGllci4KVGhhbmtzLApHYcOrdGFu
IENhcmxpZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
