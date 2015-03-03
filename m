From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix wrong detection of
	"Headphone+LO" or "Speaker+LO"
Date: Tue, 3 Mar 2015 23:18:09 +0800
Message-ID: <CAN8cciZER0EJWauPUuTe1CK_mQTcusq6fRxEvcmxbK31rReVbA@mail.gmail.com>
References: <54f5995b.7e5343ac.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E5826153F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 16:18:11 +0100 (CET)
Received: by obcwo20 with SMTP id wo20so293743obc.5
 for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2015 07:18:10 -0800 (PST)
In-Reply-To: <54f5995b.7e5343ac.bm001@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Pgo+IEFkZCB0aGUgY29uc3RyYWludCBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnQuCj4KPiBJdCBk
b2VzIG5vdCBhcHBseSB0byBhIHNjZW5hcmlvIHdpdGggdGhyZWUgREFDcyBhbmQgbXVsdGktSU8g
d2hlcmUgd2UKPiB3b3VsZCBub3JtYWxseSBnZXQgYSAiTWFzdGVyIFBsYXliYWNrIFZvbHVtZSIg
YW5kIGEgIkZyb250IFBsYXliYWNrCj4gVm9sdW1lIiAocHJldmVudGVkIHdpdGhvdXQgY2hlY2tp
bmcgZm9yIG51bV9kYWNzKS4KPgo+IFNpZ25lZC1vZmYtYnk6IEluZ28gQnLDvGNrbCA8aWJAd3Vw
cGVyb25saW5lLmRlPgo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2dlbmVyaWMu
YyBiL3NvdW5kL3BjaS9oZGEvaGRhX2dlbmVyaWMuYwo+IGluZGV4IGVjZWUzNDkuLjRjODkxMGMg
MTAwNjQ0Cj4gLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfZ2VuZXJpYy5jCj4gKysrIGIvc291bmQv
cGNpL2hkYS9oZGFfZ2VuZXJpYy5jCj4gQEAgLTEwOTcsNyArMTA5Nyw3IEBAIHN0YXRpYyBjb25z
dCBjaGFyICpnZXRfbGluZV9vdXRfcGZ4KHN0cnVjdApoZGFfY29kZWMgKmNvZGVjLCBpbnQgY2gs
Cj4gICAgICAgICBjYXNlIEFVVE9fUElOX0xJTkVfT1VUOgo+ICAgICAgICAgICAgICAgICAvKiBU
aGlzIGRlYWxzIHdpdGggdGhlIGNhc2Ugd2hlcmUgd2UgaGF2ZSB0d28gREFDcyBhbmQKPiAgICAg
ICAgICAgICAgICAgICogb25lIExPLCBvbmUgSFAgYW5kIG9uZSBTcGVha2VyICovCj4gLSAgICAg
ICAgICAgICAgIGlmICghY2ggJiYgY2ZnLT5zcGVha2VyX291dHMgJiYgY2ZnLT5ocF9vdXRzKSB7
Cj4gKyAgICAgICAgICAgICAgIGlmICghY2ggJiYgc3BlYy0+bXVsdGlvdXQubnVtX2RhY3MgPT0g
MiAmJgpjZmctPnNwZWFrZXJfb3V0cyAmJiBjZmctPmhwX291dHMpIHsKCnNwZWMtPm11bHRpb3V0
Lm51bV9kYWNzID09IDIgbWVhbiBzdXBwb3J0IDQgY2hhbm5lbHMKCllvdSBuZWVkIHRvIGZpbmQg
b3V0IHRoZSBudW1iZXIgb2YgYW5hbG9nIGRhY3MgZnJvbSBzcGVjLT5hbGxfZGFjc1tdCmV4Y2x1
ZGUgdGhlIGRpZ2l0YWwgb3V0cHV0Cgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaHBf
bG9fc2hhcmVkID0gIXBhdGhfaGFzX21peGVyKGNvZGVjLApzcGVjLT5ocF9wYXRoc1swXSwgY3Rs
X3R5cGUpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc3BrX2xvX3NoYXJlZCA9ICFw
YXRoX2hhc19taXhlcihjb2RlYywKc3BlYy0+c3BlYWtlcl9wYXRoc1swXSwgY3RsX3R5cGUpOwo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChocF9sb19zaGFyZWQgJiYgc3BrX2xvX3NoYXJl
ZCkKPiAtLQo+IDEuNy4xMApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
