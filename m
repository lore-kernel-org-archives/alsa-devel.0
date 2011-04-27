From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ASoC: prevent compilers from optimising
 pll calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 16:50:12 +0800
Message-ID: <BANLkTimm3wB+EcBZMZzW2SoeJkibisdBWQ@mail.gmail.com>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
	<s5h1v0ogk6k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F5931038BA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 10:50:34 +0200 (CEST)
Received: by qwf7 with SMTP id 7so749859qwf.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 01:50:33 -0700 (PDT)
In-Reply-To: <s5h1v0ogk6k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Barry Song <bs14@csr.com>, broonie@opensource.wolfsonmicro.com, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

MjAxMS80LzI3IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT46Cj4gQXQgV2VkLCAyNyBBcHIg
MjAxMSAxNjoyNDo0NCArMDgwMCwKPiBCYXJyeSBTb25nIHdyb3RlOgo+Pgo+PiAyMDExLzQvMjcg
VGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjoKPj4gPiBBdCBXZWQsIDI3IEFwciAyMDExIDAw
OjI3OjMyIC0wNzAwLAo+PiA+IEJhcnJ5IFNvbmcgd3JvdGU6Cj4+ID4+Cj4+ID4+IEZyb206IEJh
cnJ5IFNvbmcgPDIxY25iYW9AZ21haWwuY29tPgo+PiA+Pgo+PiA+PiBUaGUgbmV3ZXN0IGNvbXBp
bGllcnMgY2FuIG9wdGltaXplIHBsbCBjYWxjdWxhdGlvbiBpbiBzZXZlcmFsIGNvZGVjcyBpbnRv
IF9fYWVhYmlfX3VsZGl2bW9kIHdoaWNoIGRvZXNuJ3QgZXhpc3QgaW4ga2VybmVsLgo+PiA+PiBU
aGVuIHRoZSBsaW5rIHdpbGwgZmFpbDoKPj4gPj4gRVJST1I6ICJfX2FlYWJpX3VsZGl2bW9kIiBb
c291bmQvc29jL2NvZGVjcy9zbmQtc29jLXdtODk3NC5rb10gdW5kZWZpbmVkIQo+PiA+PiBFUlJP
UjogIl9fYWVhYmlfdWxkaXZtb2QiIFtzb3VuZC9zb2MvY29kZWNzL3NuZC1zb2Mtd204OTQwLmtv
XSB1bmRlZmluZWQhCj4+ID4+IEVSUk9SOiAiX19hZWFiaV91bGRpdm1vZCIgW3NvdW5kL3NvYy9j
b2RlY3Mvc25kLXNvYy13bTg1MTAua29dIHVuZGVmaW5lZCEKPj4gPj4gVGhpcyBwYXRjaCBwcmV2
ZW50IHRoZSBvcHRpbWl6YXRvbiBieSBpbnNlcnQgQVNNLgo+PiA+Cj4+ID4gRG9uJ3QgZG8gdGhp
cyBpbiB0aGUgbG93IGRyaXZlciBsZXZlbC4gwqBJZiBhbnksIHdlIHNob3VsZCBmaXggZG9fZGl2
KCkKPj4gPiBpbnN0ZWFkLgo+Pgo+PiBkb19kaXYgaXMganVzdCBhIG1hY3JvLCBpdCBoYXMgbm8g
cHJvYmxlbSBieSBpdHNlbGYuCj4KPiBJdCBoYXMgYSBwcm9ibGVtIGJ5IGl0c2VsZiBiZWNhdXNl
IGl0J3MgYSBtYWNybyB3aXRoIGEgc2lkZS1lZmZlY3QgOikKPgo+IENvdWxkIHdlIHB1dCBhbiBh
c20gdG8gZG9fZGl2KCkgaXRzZWxmPyDCoFRoZSBhc20gc3RhdGVtZW50IGNhbiBiZQo+IGRlZmlu
ZWQgZGVwZW5kaW5nIG9uIHRoZSBjb21waWxlciB2ZXJzaW9uLgo+Cj4+IG9ubHkgd2hpbGUKPj4g
d29ya2luZyB0b2dldGhlciB3aXRoIG90aGVyIG1vcmUgY29kZXMgYmVmb3JlIGRvX2RpdiwgZ2Nj
IGNhbiBtYWtlCj4+IHNvbWUgY29kZXMgbWVyZ2luZyBhbmQgY2F1c2UgcHJvYmxlbXMuCj4+Cj4+
IGlmIGRvX2RpdiBpcyBhIGZ1bmN0aW9uLCB3ZSdkIGp1c3QgZml4IGl0Lgo+Cj4gQmV0dGVyIHRv
IGFzayB0aGlzIGluIExLTUwsIHRoZW4uCgpJIG11c3QgaGF2ZSBiZWVuIGRlbGF5aW5nIGEgbGl0
dGxlIGZyb20gZ2NjLiAgTWljaGFlbCBIb3BlIGhhcyB0aG91Z2h0Cml0IGFzIGEgZ2NjIGJ1ZyBv
biAyNiBBcHJpbCwyMDExYXQ6CgpodHRwOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcu
Y2dpP2lkPTQ4NzgzCgpNYXJraW5nIHBsbF9mYWN0b3JzKCkgYXMgbm9pbmxpbmUgb3IgcHV0dGlu
ZyBhc20oIiIgOiAiK3IiKHNvdXJjZSkpOyBiZWZvcmUgdGhlCmNhbGwgdG8gZG9fZGl2KCkgd29y
a3MgYXJvdW5kIHRoZSBwcm9ibGVtLgoKPgo+Cj4gdGhhbmtzLAo+Cj4gVGFrYXNoaQo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
