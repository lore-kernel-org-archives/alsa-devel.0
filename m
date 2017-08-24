From: Roger Dannenberg <rbd@cs.cmu.edu>
Subject: Can ALSA MIDI use timestamps for precise timing?
Date: Thu, 24 Aug 2017 13:51:00 -0400
Message-ID: <fdc3abae-84b8-d94c-991d-cdd30c4d9f64@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp02.srv.cs.cmu.edu (smtp02.srv.cs.cmu.edu [128.2.217.201])
 by alsa0.perex.cz (Postfix) with ESMTP id C821D266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 19:51:07 +0200 (CEST)
Received: from count.music.cs.cmu.edu ([172.31.53.93]) (authenticated bits=0)
 by smtp02.srv.cs.cmu.edu (8.13.6/8.13.6) with ESMTP id v7OHp1uL029883
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 13:51:04 -0400 (EDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgrCoMKgwqAgSSB3cm90ZSBQb3J0TUlESSBsb25nIGFnbyBhbmQgbm93IHRoYXQgaXQncyBn
b2luZyBpbnRvIEF1ZGFjaXR5IGFuZAp3ZSdyZSBoYXZpbmcgdGltaW5nIHByb2JsZW1zIGluIExp
bnV4LCBJJ20gcmV2aXNpdGluZyB0aGUgY29kZSBhbmQKd29uZGVyaW5nIGlmIEFMU0EgaGFzIGEg
ZnVuZGFtZW50YWwgZGVzaWduIHByb2JsZW0uIEknbSBob3BpbmcgSSdtCm1pc3Npbmcgc29tZXRo
aW5nLCBidXQgaGVyZSdzIHRoZSBwcm9ibGVtOgoKwqDCoMKgIFBvcnRNSURJIHdhbnRzIHRvIHNl
bmQgTUlESSBtZXNzYWdlcyBhdCBwcmVjaXNlIHRpbWVzIGFjY29yZGluZyB0bwphcmJpdHJhcnkg
Y2xvY2tzLiBJbiBBdWRhY2l0eSwgdGhlIGltcG9ydGFudCBjbG9jayB0byBzeW5jaHJvbml6ZSB0
byBpcwp0aGUgYXVkaW8gc2FtcGxlIGNsb2NrLiBUbyBzeW5jaHJvbml6ZSBNSURJLCBvbmUgY2Fu
IGluIHByaW5jaXBsZSB1c2UKdGltZXN0YW1wcyBhbmQgbGV0IHRoZSBkZXZpY2UgZHJpdmVyLCB3
aGljaCBwcmVzdW1hYmx5IHJ1bnMgd2l0aCB2ZXJ5CmxvdyBsYXRlbmN5LCBkaXNwYXRjaCBNSURJ
IGZyb20gYSBxdWV1ZSB0byB0aGUgZGV2aWNlIG9yIGRlc3RpbmF0aW9uLgpUaGUgcXVlc3Rpb24g
aXMgdGhlbiB3aGF0IHRpbWVzdGFtcCB0byB1c2UuIEFMU0EgaGFzIHNvbWUgb3B0aW9ucy4KVGhl
cmUncyByZWxhdGl2ZSB0aW1pbmcsIGJ1dCBpZiB5b3Ugc2VuZCB3aXRoIHJlbGF0aXZlIHRpbWUg
YW5kIHlvdSBnZXQKdW5zY2hlZHVsZWQganVzdCBhcyB5b3UgYXJlIGV4ZWN1dGluZyB0aGUgd3Jp
dGUgY2FsbCwgeW91J2xsIGJlIGxhdGUuClRoZXJlJ3MgYWJzb2x1dGUgdGltaW5nLCBidXQgdGhl
IGRvY3Mgc2F5IHRoYXQncyByZWxhdGl2ZSB0byB3aGVuIHlvdQpzdGFydCB0aGUgcXVldWUsIGJ1
dCB3aGVuIGV4YWN0bHkgaXMgdGhhdD8gVGhlIHByb2JsZW0gYmVjb21lcyBwcmVjaXNlCnRpbWlu
ZyBvZiBxdWV1ZSBjcmVhdGlvbiBkb2Vzbid0IGl0PyBBbmQgdGhlcmUncyBubyB0aW1lc3RhbXAg
cHJvdmlkZWQKZm9yIHdoZW4gdG8gc3RhcnQuIElmICJhYnNvbHV0ZSIgbWVhbiBleGFjdGx5IHRo
ZSBzeXN0ZW0gdGltZSwgdGhhdAp3b3VsZCBiZSBncmVhdCwgYnV0IEkgdGhpbmsgdGhhdCdzIG5v
dCB0aGUgY2FzZS4KCsKgwqDCoCBJcyB0aGlzIGEgZnVuZGFtZW50YWwgZGVzaWduIGVycm9yLCBv
ciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKwqDCoMKgIFRoYW5rcy4gLVJvZ2VyIERhbm5lbmJl
cmcKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
