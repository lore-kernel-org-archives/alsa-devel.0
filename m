From: varun sood <soodvarun78@yahoo.co.in>
Subject: Problem in using few ladspa plugins
Date: Tue, 13 Sep 2016 13:10:59 +0000 (UTC)
Message-ID: <1473175359.414439.1473772259017@mail.yahoo.com>
References: <1473175359.414439.1473772259017.ref@mail.yahoo.com>
Reply-To: varun sood <soodvarun78@yahoo.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm18-vm3.bullet.mail.sg3.yahoo.com
 (nm18-vm3.bullet.mail.sg3.yahoo.com [106.10.149.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 93621266A4B
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 15:11:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGkgQWxzYSBEZXZlbG9wZXJzLApJIGFtIHdvcmtpbmcgb24gbGFkc3BhIHBsdWdpbiB1c2luZyBh
bHNhIGxpYiAuIApUaGVyZSBpcyBwcm9ibGVtIHdpdGggYWxzYSBsaWJyYXJ5IHdpdGggdGhvc2Ug
bGFkc3BhIHBsdWdpbnMgd2hlcmUgdGhlcmUgaXMgY2hhbmdlIGluIG51bWJlciBvZiBpbnB1dCBh
bmQgb3V0cHV0IGF1ZGlvIHBvcnRzIGZyb20gdGhlIGxhZHNwYSBwbHVnaW4uRSxnIGZvciBsYWRz
cGEgcGx1Z2luLCBpZiBJIGRvCmFuYWx5c2VwbHVnaW4gc3Vycm91bmRfZW5jb2Rlcl8xNDAxLnNv
UG9ydHM6ICJMIiBpbnB1dCwgYXVkaW8KwqDCoMKgwqDCoMKgwqDCoMKgICJSIiBpbnB1dCwgYXVk
aW8KwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkMiIGlucHV0LCBhdWRpbwrCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiUyIgaW5wdXQsIGF1ZGlvCsKgwqDCoMKgwqDCoMKgwqDCoMKgICJMdCIgb3V0cHV0LCBh
dWRpbwrCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUnQiIG91dHB1dCwgYXVkaW8KVGhlcmUgYXJlIDQg
aW5wdXQgcG9ydHMoIkwiLCJSIiwiQyIsIlMiKSBmb3IgbGFkc3BhIGFuZCAyIG91dHB1dCBwb3J0
IGZyb20gbGFkc3BhKCJMdCIsIlJ0IikuIApUaGlzIGlzIGVxdWl2YWxlbnQgdG8gNCBpbnB1dCBj
aGFubmVscyBhbmQgMiBvdXRwdXQgY2hhbm5lbHMuClRoZSBhbHNhIGxpYnJhcnkgZG9lcyBub3Qg
aGFuZGxlIHRoaXMgcGx1Z2luIHByb3Blcmx5LiBJIHJlY2VpdmUgc2VnbWVudGF0aW9uIGZhdWx0
IG9uIHVzaW5nIHRoaXMgcGx1Z2luIGluIGFsc2EgY2hhaW4gc2NlbmFyaW8gYXQgbGluZSAKaWYg
KHBjaGFubmVsc1tjaG5dID09IE5VTEwgJiYgY2huIDwgaWNoYW5uZWxzKSAKaW4gZnVuY3Rpb24g
c25kX3BjbV9sYWRzcGFfYWxsb2NhdGVfbWVtb3J5IGluIGZpbGUgcGNtX2xhZHNwYS5jCgpTaW1p
bGFyIGlzc3VlIEkgaGF2ZSBzZWVuIGluIHNwbGl0XzE0MDYuc28sIHdoaWNoIHRha2VzIDEgY2hh
bm5lbCBpbnB1dCggMSBpbnB1dCBwb3J0KSBhbmQgZ2l2ZXMgMiBjaGFubmVsIG91dHB1dCggMiBv
dXRwdXQgcG9ydHMpLk5vIHNlZ21lbnRhdGlvbiBmYXVsdCBpbiB0aGlzIGNhc2UgYnV0IGl0IGln
bm9yZXMgdGhlIDJuZCBjaGFubmVsIC4KSXMgdGhlcmUgYSB3YXkgdG8gc29sdmUgdGhlc2UgcHJv
YmxlbSA/CgpSZWdhcmRzVmFydW4gU29vZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
