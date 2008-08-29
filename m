From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH] ice1724 MIDI on PHASE 22 and PHASE 28 and
	a few minor fixes
Date: Fri, 29 Aug 2008 19:23:15 +0200
Message-ID: <fd3eb9bf0808291023p29904814o412de2ba63013498@mail.gmail.com>
References: <fd3eb9bf0808280709o3a738a0au4ab636034d78c406@mail.gmail.com>
	<s5hod3d8bol.wl%tiwai@suse.de>
	<fd3eb9bf0808280950l4c2fef27r9805d8790282ff91@mail.gmail.com>
	<s5hprnsgk0p.wl%tiwai@suse.de> <s5h4p54gc4t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 6117C24391
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 19:23:17 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so724359yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2008 10:23:16 -0700 (PDT)
In-Reply-To: <s5h4p54gc4t.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

SXQgaW5kZWVkIGRvZXMgZml4IGl0LiBEb2Vzbid0IHNlZW0gdG8gYnJlYWsgYW55dGhpbmcgYWxv
bmcgdGhlIHdheS4KQ2FuIHlvdSBjaGVjayBpdCBpbj8KCjIwMDgvOC8yOSBUYWthc2hpIEl3YWkg
PHRpd2FpQHN1c2UuZGU+Ogo+IE1vcmUgdG8gZm9sbG93LCB0aGUgcGF0Y2ggYmVsb3cgbWlnaHQg
Zml4IHRoZSBwcm9ibGVtLgo+Cj4KPiBUYWthc2hpCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvcGNp
L2ljZTE3MTIvaWNlMTcyNC5jIGIvc291bmQvcGNpL2ljZTE3MTIvaWNlMTcyNC5jCj4gaW5kZXgg
NjAxMTlkMi4uN2JiOTlkZiAxMDA2NDQKPiAtLS0gYS9zb3VuZC9wY2kvaWNlMTcxMi9pY2UxNzI0
LmMKPiArKysgYi9zb3VuZC9wY2kvaWNlMTcxMi9pY2UxNzI0LmMKPiBAQCAtOTQyLDcgKzk0Miw3
IEBAIHN0YXRpYyBpbnQgc25kX3Z0MTcyNF9wbGF5YmFja19wcm9fb3BlbihzdHJ1Y3Qgc25kX3Bj
bV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKPiAgewo+ICAgICAgICBzdHJ1Y3Qgc25kX3BjbV9ydW50
aW1lICpydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOwo+ICAgICAgICBzdHJ1Y3Qgc25kX2lj
ZTE3MTIgKmljZSA9IHNuZF9wY21fc3Vic3RyZWFtX2NoaXAoc3Vic3RyZWFtKTsKPiAtICAgICAg
IGludCBjaHM7Cj4gKyAgICAgICBpbnQgY2hzLCBudW1faW5kZXBzOwo+Cj4gICAgICAgIHJ1bnRp
bWUtPnByaXZhdGVfZGF0YSA9ICh2b2lkICopJnZ0MTcyNF9wbGF5YmFja19wcm9fcmVnOwo+ICAg
ICAgICBpY2UtPnBsYXliYWNrX3Byb19zdWJzdHJlYW0gPSBzdWJzdHJlYW07Cj4gQEAgLTk1Miw3
ICs5NTIsOCBAQCBzdGF0aWMgaW50IHNuZF92dDE3MjRfcGxheWJhY2tfcHJvX29wZW4oc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCj4gICAgICAgIHNldF9yYXRlX2NvbnN0cmFp
bnRzKGljZSwgc3Vic3RyZWFtKTsKPiAgICAgICAgbXV0ZXhfbG9jaygmaWNlLT5vcGVuX211dGV4
KTsKPiAgICAgICAgLyogY2FsY3VsYXRlIHRoZSBjdXJyZW50bHkgYXZhaWxhYmxlIGNoYW5uZWxz
ICovCj4gLSAgICAgICBmb3IgKGNocyA9IDA7IGNocyA8IDM7IGNocysrKSB7Cj4gKyAgICAgICBu
dW1faW5kZXBzID0gaWNlLT5udW1fdG90YWxfZGFjcyAvIDIgLSAxOwo+ICsgICAgICAgZm9yIChj
aHMgPSAwOyBjaHMgPCBudW1faW5kZXBzOyBjaHMrKykgewo+ICAgICAgICAgICAgICAgIGlmIChp
Y2UtPnBjbV9yZXNlcnZlZFtjaHNdKQo+ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4g
ICAgICAgIH0KPgoKCi0tIApWZWRyYW4gTWlsZXRpxIcKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
