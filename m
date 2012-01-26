From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why does snd_seq_drain_output() need lots of time
 to execute?
Date: Thu, 26 Jan 2012 23:04:42 +0100
Message-ID: <4F21CDFA.3070608@ladisch.de>
References: <CABscqj76Lb9fgD-FY1otzETWwjJO9vwCG=Rt83jU8ti0bE6KpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E21761038DE
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 23:05:15 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AE61D21159
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 17:05:11 -0500 (EST)
In-Reply-To: <CABscqj76Lb9fgD-FY1otzETWwjJO9vwCG=Rt83jU8ti0bE6KpA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?UmFmYcWCIENpZcWbbGFr?= <rafalcieslak256@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

UmFmYcWCIENpZcWbbGFrIHdyb3RlOgo+IFRoZSBtYWluIHByb2JsZW0gaXMgdGhhdCBhbHRob3Vn
aCB0aGUgZG9jdW1lbnRhdGlvbiBzdGF0ZXMgdGhhdAo+IHNuZF9zZXFfZHJhaW5fb3V0cHV0KCkg
cmV0dXJucyBpbW1lZGlhdGVseSwKCnwgIlRoZSBmdW5jdGlvbiByZXR1cm5zIGltbWVkaWF0ZWx5
IGFmdGVyIHRoZSBldmVudHMgYXJlIHNlbnQgdG8gdGhlCnwgIHF1ZXVlcyAuLi4iCgo+IGl0IHR1
cm5zIG91dCB0aGF0IGl0IG9jY2FzaW9uYWxseSBuZWVkcyBsb3RzIG9mIHRpbWUgKGV2ZW4gYSBz
ZWNvbmQgb3IKPiB0d28pLCBhbmQgYmxvY2tzIG15IGFwcGxpY2F0aW9uLCBhcyBJIGNhbGwgaXQu
CgpZb3UgY291bGQgZW5hYmxlIG5vbi1ibG9ja2luZyBtb2RlIHRvIGdldCBhbiBlcnJvciBpbnN0
ZWFkIG9mIHdhaXRpbmcuCgpPciB5b3UgY291bGQgdG8gaW5jcmVhc2UgdGhlIHNpemUgb2YgdGhl
IG91dHB1dCBidWZmZXIuCgo+IEFuZCBiZWZvcmUgeW91IGFzaywgSSd2ZSBzZXQgdGhlIG91dHB1
dCBidWZmZXIgdG8gc29tZSBodWdlIGFtb3VudCwKCkEgc2VxdWVuY2VyIGNsaWVudCBoYXMgX3R3
b18gb3V0cHV0IGJ1ZmZlcnMsIG9uZSBpbiBhbHNhLWxpYiwgYW5kIG9uZSBpbgp0aGUga2VybmVs
LiAgRXZlbnRzIHRoYXQgYXJlIHNjaGVkdWxlZCBmb3IgbGF0ZXIgc3RheSBpbiB0aGUga2VybmVs
CmJ1ZmZlciB1bnRpbCB0aGV5IGFyZSBhY3R1YWxseSBkZWxpdmVyZWQ7IHdoZW4gdGhpcyBidWZm
ZXIgd291bGQKb3ZlcmZsb3csIGZ1bmN0aW9ucyB0aGF0IGRyYWluIHRoZSB1c2Vyc3BhY2UgYnVm
ZmVyIHRvIHRoZSBrZXJuZWwgYnVmZmVyCndhaXQgaW5zdGVhZC4KClRvIGluY3JlYXNlIHRoZSBr
ZXJuZWwgYnVmZmVyJ3Mgc2l6ZSwgdXNlIHRoZSBzbmRfc2VxX2NsaWVudF9wb29sKiBhbmQKc25k
X3NlcV9nZXQvc2V0X2NsaWVudF9wb29sIGZ1bmN0aW9ucy4gICgicG9vbCIgaXMgdGhlIGJ1ZmZl
ciBzaXplLCBpbgpldmVudHM7ICJyb29tIiBpcyB0aGUgbnVtYmVyIG9mIGZyZWUgZXZlbnRzIHRo
YXQgY2F1c2VzIGEgYmxvY2tlZApmdW5jdGlvbiB0byB3YWtlIHVwLikKCgpSZWdhcmRzLApDbGVt
ZW5zCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
