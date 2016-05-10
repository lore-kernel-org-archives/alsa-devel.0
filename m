From: Jeremy McDermond <nh6z@nh6z.net>
Subject: ASoC: DAPM and differential inputs
Date: Tue, 10 May 2016 12:52:44 -0700
Message-ID: <F76036D1-2704-4776-AA45-FED4B3DDC81C@nh6z.net>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B97FA267CE2
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 21:52:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.xenotropic.com (Postfix) with ESMTP id 9D80F20097
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 12:43:42 -0700 (PDT)
Received: from mail.xenotropic.com ([127.0.0.1])
 by localhost (mail.xenotropic.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDs56tc6WKa3 for <alsa-devel@alsa-project.org>;
 Tue, 10 May 2016 12:43:40 -0700 (PDT)
Received: from republic.xenotropic.com (republic.xenotropic.com
 [198.178.136.197])
 by mail.xenotropic.com (Postfix) with ESMTPSA id D227D20096
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 12:43:40 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

SeKAmXZlIGJlZW4gd29ya2luZyBvbiB0aGUgdGx2MzIwYWljMzJ4NCBkcml2ZXIgZm9yIGEgd2hp
bGUgbm93IHRvIGFkZCBzb21lIGZlYXR1cmVzIGZvciBzb21lIHByb2plY3RzIEnigJltIHdvcmtp
bmcgb24gdXNpbmcgdGhlIGNoaXAuICBJ4oCZbSB0cnlpbmcgdG8gd3JhcCBteSBoZWFkIGFyb3Vu
ZCBEQVBNIGFuZCBnZXR0aW5nIGl0IHRvIHdvcmsgd2l0aCB0aGUgdmFyaWV0eSBvZiBpbnB1dHMg
b24gdGhlIGFpYzMyeDQuCgpCYXNpY2FsbHksIHRoZSBjb2RlYyBoYXMgYSBzZXQgb2YgcmVnaXN0
ZXJzIHRoYXQgY29udHJvbCB0aGUgcG9zaXRpdmUgYW5kIG5lZ2F0aXZlIGlucHV0cyB0byBlYWNo
IG9mIHRoZSByaWdodCBhbmQgbGVmdCBpbnB1dCBtaXhlcnMuICBUaGUgb25seSBzZXR0aW5nIGlz
IHdoYXQgdmFsdWUgb2YgcmVzaXN0b3IgdG8gY29ubmVjdCBiZXR3ZWVuIHRoZSBpbnB1dCBwaW4g
YW5kIGEgcGFydGljdWxhciBtaXhlciAobm9uZSwgMTBrLCAyMGssIDQwaykuICBGb3IgZXhhbXBs
ZSwgeW91IGNhbiBoYXZlIGEgZGlmZmVyZW50aWFsIHBhaXIgYmV0d2VlbiBJTjFfUiBhbmQgSU4y
X1IsIG9yIGJldHdlZW4gSU4xX1IgYW5kIElOM19SLCBvciBzaW5nbGUgZW5kZWQgYnkgc2V0dGlu
ZyB0aGUgbmVnYXRpdmUgcGluIHRvIHRoZSBjb21tb24uICBTbywgdGhlcmXigJlzIGEgbG90IG9m
IGZsZXhpYmlsaXR5IGFuZCBub3QganVzdCBhIGRpZmZlcmVudGlhbCDigJxtb2Rl4oCdLiAgVGhl
IHJlZ2lzdGVycyB3b3VsZCBldmVuIGFsbG93IHlvdSB0byBzZXQgdXAgdHdvIG5lZ2F0aXZlIHBp
bnMsIGFsdGhvdWdoIEnigJltIG5vdCBzdXJlIHdoeSB0aGF0IHdvdWxkIGJlIHVzZWZ1bC4KCkni
gJltIGN1cnJlbnRseSBzZXR0aW5nIHVwIERBUE0gc28gdGhhdCBib3RoIHRoZSBwb3NpdGl2ZSBh
bmQgbmVnYXRpdmUgcGlucyBhcmUgd2lyZWQgdG8gYSBzaW5nbGUgbWl4ZXIuICBUaGlzIGRvZXNu
4oCZdCBzZWVtIHRvIGJlIHdvcmtpbmcgc2luY2Ugb25seSB0aGUgbmVnYXRpdmUgcGluIHNlZW1z
IHRvIGNhdXNlIHRoZSBwYXRoIHRvIGJlIGVuYWJsZWQuICBEbyBJIGhhdmUgdG8gc2V0IHVwIGFu
b3RoZXIg4oCcTmVnYXRpdmUgUmlnaHTigJ0gYW5kIOKAnE5lZ2F0aXZlIExlZnTigJ0gbWl4ZXIg
dG8gaGFuZGxlIHRoZSBuZWdhdGl2ZSBwaW5zPyAgQW0gSSBtaXNzaW5nIHNvbWV0aGluZyBlbHNl
PwoKLS0KSmVyZW15IE1jRGVybW9uZCAoTkg2WikKWGVub3Ryb3BpYyBTeXN0ZW1zCm1jZGVybWpA
eGVub3Ryb3BpYy5jb20KCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
