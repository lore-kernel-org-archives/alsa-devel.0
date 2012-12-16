From: "Mantas M." <grawity@gmail.com>
Subject: "hda-intel: azx_get_response timeout"
Date: Sun, 16 Dec 2012 18:04:17 +0200
Message-ID: <kakre0$jpv$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id B38FA2616EA
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 17:09:54 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TkGmy-0003iq-Fj
 for alsa-devel@alsa-project.org; Sun, 16 Dec 2012 17:10:04 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 17:10:04 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 17:10:04 +0100
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

QWZ0ZXIgdXBncmFkaW5nIHRvIExpbnV4IDMuNyAob24gQXJjaCBMaW51eCwgeDg2XzY0KSwgSSd2
ZSBiZWVuIGdldHRpbmcKdGhlIGZvbGxvd2luZyBtZXNzYWdlcyBpbiBkbWVzZzoKCj4gW0RlYzEx
IDIxOjUyXSBoZGEtaW50ZWw6IGF6eF9nZXRfcmVzcG9uc2UgdGltZW91dCwgc3dpdGNoaW5nIHRv
IHBvbGxpbmcgbW9kZTogbGFzdCBjbWQ9MHgwMDFmMDUwMAo+IFsgICsxLjAwNjcwOV0gaGRhLWlu
dGVsOiBObyByZXNwb25zZSBmcm9tIGNvZGVjLCBkaXNhYmxpbmcgTVNJOiBsYXN0IGNtZD0weDAw
MWYwNTAwCj4gWyAgKzEuMDA2NzczXSBoZGFfaW50ZWw6IGF6eF9nZXRfcmVzcG9uc2UgdGltZW91
dCwgc3dpdGNoaW5nIHRvIHNpbmdsZV9jbWQgbW9kZTogbGFzdCBjbWQ9MHgwMDFmMDUwMAoKVGhp
cyBzZWVtcyB0byBoYXBwZW4gd2hlbiByZXN1bWluZyBmcm9tIHN1c3BlbmQtdG8tbWVtb3J5LCBh
bmQgaXMgbmV3IHRvCnYzLjcg4oCTIEkgaGF2ZW4ndCBzZWVuIGFueSBzdWNoIG1lc3NhZ2VzIG9u
IGFueSBrZXJuZWxzIEkndmUgdXNlZCBlYXJsaWVyCihiZXR3ZWVuIHYzLjAgYW5kIHYzLjYuOSku
CgpUaGUgZGV2aWNlIGlzOgoKPiAjIGxzcGNpIC12Cj4gMDA6MWIuMCBBdWRpbyBkZXZpY2U6IElu
dGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQgSGlnaCBEZWZpbml0
aW9uIEF1ZGlvIChyZXYgMDYpCj4gCVN1YnN5c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIERl
dmljZSAxNjQzCj4gCUZsYWdzOiBidXMgbWFzdGVyLCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAwLCBJ
UlEgMjIKPiAJTWVtb3J5IGF0IGQ1MjAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtz
aXplPTE2S10KPiAJQ2FwYWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAy
Cj4gCUNhcGFiaWxpdGllczogWzYwXSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlLSA2
NGJpdCsKPiAJQ2FwYWJpbGl0aWVzOiBbNzBdIEV4cHJlc3MgUm9vdCBDb21wbGV4IEludGVncmF0
ZWQgRW5kcG9pbnQsIE1TSSAwMAo+IAlDYXBhYmlsaXRpZXM6IFsxMDBdIFZpcnR1YWwgQ2hhbm5l
bAo+IAlDYXBhYmlsaXRpZXM6IFsxMzBdIFJvb3QgQ29tcGxleCBMaW5rCj4gCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBzbmRfaGRhX2ludGVsCgpJcyB0aGVyZSBhbnl0aGluZyBJIGNhbi9zaG91bGQg
ZG8gYWJvdXQgdGhpcz8KCi0tIApNYW50YXMgTWlrdWzEl25hcyA8Z3Jhd2l0eUBnbWFpbC5jb20+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
