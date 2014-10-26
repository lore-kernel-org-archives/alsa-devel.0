From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH][fix] ALSA: bebob: fix wrong decoding of
	clock information	for Terratec PHASE 88 Rack FW
Date: Sun, 26 Oct 2014 18:18:03 +0100
Message-ID: <544D2CCB.9010201@ladisch.de>
References: <1414331385-14731-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A88BC2605CD
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 18:18:07 +0100 (CET)
In-Reply-To: <1414331385-14731-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: muranyia@gmail.com, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

VGFrYXNoaSBTYWthbW90byB3cm90ZToKPiBUZXJyYXRlYyBQSEFTRSA4OCByYWNrIGZ3IGhhcyB0
d28gcmVnaXN0ZXJzIGZvciBzb3VyY2Ugb2YgY2xvY2ssIG9uZSBpcwo+IGZvciBpbnRlcm5hbC9l
eHRlcm5hbCwgYW5kIGFub3RoZXIgaXMgZm9yIHdvcmRjbG9jay9zcGRpZiBmb3IgZXh0ZXJuYWwu
Cj4KPiBXaGVuIGNsb2NrIHNvdXJjZSBpcyBpbnRlcm5hbCwgaW5mb3JtYXRpb24gaW4gYW5vdGhl
ciByZWdpc3RlciBoYXMgbm8gbWVhbmluZy4KPiBUaHVzIGl0IG11c3QgYmUgaWdub3JlZCwgYnV0
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZGVjb2RlcyBpdC4gVGhpcyBjYXVzZXMKPiBvdmVyLWlu
ZGV4aW5nIHJlZmVyZW5jZSB0byBsYWJlbHMuCj4KPiBSZXBvcnRlZC1ieTogQW5kcsOhcyBNdXLD
oW55aSA8bXVyYW55aWFAZ21haWwuY29tPgo+IFRlc3RlZC1ieTogQW5kcsOhcyBNdXLDoW55aSA8
bXVyYW55aWFAZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFRha2FzaGkgU2FrYW1vdG8gPG8t
dGFrYXNoaUBzYWthbW9jY2hpLmpwPgoKQWNrZWQtYnk6IENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVu
c0BsYWRpc2NoLmRlPgoKPiAtLS0KPiAgc291bmQvZmlyZXdpcmUvYmVib2IvYmVib2JfdGVycmF0
ZWMuYyB8IDcgKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvZmlyZXdpcmUvYmVib2IvYmVib2JfdGVy
cmF0ZWMuYyBiL3NvdW5kL2ZpcmV3aXJlL2JlYm9iL2JlYm9iX3RlcnJhdGVjLmMKPiBpbmRleCAw
ZTRjMGJmLi45OTQwNjExIDEwMDY0NAo+IC0tLSBhL3NvdW5kL2ZpcmV3aXJlL2JlYm9iL2JlYm9i
X3RlcnJhdGVjLmMKPiArKysgYi9zb3VuZC9maXJld2lyZS9iZWJvYi9iZWJvYl90ZXJyYXRlYy5j
Cj4gQEAgLTI0LDcgKzI0LDEyIEBAIHBoYXNlODhfcmFja19jbGtfc3JjX2dldChzdHJ1Y3Qgc25k
X2JlYm9iICpiZWJvYiwgdW5zaWduZWQgaW50ICppZCkKPiAgCWlmIChlcnIgPCAwKQo+ICAJCWdv
dG8gZW5kOwo+Cj4gLQkqaWQgPSAoZW5hYmxlX2V4dCAmIDB4MDEpIHwgKChlbmFibGVfd29yZCAm
IDB4MDEpIDw8IDEpOwo+ICsJaWYgKGVuYWJsZV9leHQgPT0gMCkKPiArCQkqaWQgPSAwOwo+ICsJ
ZWxzZSBpZiAoZW5hYmxlX3dvcmQgPT0gMCkKPiArCQkqaWQgPSAxOwo+ICsJZWxzZQo+ICsJCSpp
ZCA9IDI7Cj4gIGVuZDoKPiAgCXJldHVybiBlcnI7Cj4gIH0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
