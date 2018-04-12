From: =?UTF-8?Q?Charles_Fl=C3=A8che?= <charles.fleche@gmail.com>
Subject: Re: snd_seq_query_port_subscribers not updating subs
	index
Date: Thu, 12 Apr 2018 16:49:27 +0200
Message-ID: <CAMnW3LuHs8MY3pZVCV5XGcb=9oqVjmf4kmoOKyqoZg5hV=SiRw@mail.gmail.com>
References: <CAMnW3Lt-R_ECPvazFbJjm-cS0w-gey0t5Tvts+Cz5n5LVPO+RQ@mail.gmail.com>
 <s5h604w8owq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E03B1267140
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 16:49:29 +0200 (CEST)
Received: by mail-io0-f196.google.com with SMTP id q80so6583074ioi.13
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 07:49:29 -0700 (PDT)
In-Reply-To: <s5h604w8owq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?UTF-8?Q?Charles_Fl=C3=A8che?= <charles.fleche@free.fr>
List-Id: alsa-devel@alsa-project.org

PiBTb3J0IG9mLCB5ZXMKCkZyb20gdGhlIHNuZF9zZXFfcXVlcnlfcG9ydF9zdWJzY3JpYmVycyBk
b2M6ICJUbyBsaXN0IHVwIGFsbCB0aGUKc3Vic2NyaXB0aW9ucywgY2FsbCB0aGlzIGZ1bmN0aW9u
IHdpdGggdGhlIGluZGV4IG51bWJlcnMgZnJvbSAwIHVudGlsIHRoaXMKcmV0dXJucyBhIG5lZ2F0
aXZlIHZhbHVlLiIKClNvIGRvZXMgaXQgbWVhbiB0aGFuIGluIGNlcnRhaW4gY2FzZXMgc25kX3Nl
cV9xdWVyeV9wb3J0X3N1YnNjcmliZXJzCmluY3JlbWVudHMgdGhlIGluZGV4IGl0c2VsZiwgYW5k
IHNvbWV0aW1lIGl0IGRvZXMgbm90ID8KClRoYW5rcywgVGFrYXNoaQoKT24gVGh1LCBBcHIgMTIs
IDIwMTggYXQgNDo0NCBQTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3cm90ZToKCj4g
T24gU3VuLCAwOCBBcHIgMjAxOCAxODozNzo1OCArMDIwMCwKPiBDaGFybGVzIEZsw6hjaGUgd3Jv
dGU6Cj4gPgo+ID4gSGkgYWxsLAo+ID4KPiA+IEknbSBpdGVyYXRpbmcgdGhyb3VnaCBzdWJzY3Jp
YmVycyB3aXRoIHNuZF9zZXFfcXVlcnlfcG9ydF9zdWJzY3JpYmVycyB0bwo+ID4gZGlzY29ubmVj
dCB0aGVtLiBJdCB3b3JrcyBtb3N0IG9mIHRoZSB0aW1lLCBidXQgd2hlbiBhMmogKGFuIGFsc2Eg
LT4gamFjawo+ID4gTUlESSBicmlkZ2UpIHJ1bnMsIHNuZF9zZXFfcXVlcnlfcG9ydF9zdWJzY3Jp
YmVycyBkb2VzIG5vdCB1cGRhdGUgdGhlCj4gc3Vicwo+ID4gaW5kZXgsIGFuZCB0aGUgbmV4dCBj
YWxsIHJldHVybnMgMCwgbGVhZGluZyB0byBhbiBpbmZpbml0ZSBsb29wLiBJIGhhdmUKPiB0bwo+
ID4gbWFudWFsbHkgaW5jcmVhc2UgdGhlIGluZGV4IHdoZW4gdGhlIGRpc2Nvbm5lY3Rpb24gZmFp
bHMgKG1lYW5pbmcgdGhhdCBJCj4gPiBoaXQgYW4gYTJqIGNvbm5lY3Rpb24pLgo+ID4KPiA+IHdo
aWxlIChzbmRfc2VxX3F1ZXJ5X3BvcnRfc3Vic2NyaWJlcnMoc2VxLCBzdWJzKSA+PSAwKSB7Cj4g
PiAgIGFkZHIgPSAqc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfZ2V0X2FkZHIoc3Vicyk7Cj4gPiAg
IGlmIChzbmRfc2VxX2Rpc2Nvbm5lY3RfdG8oc2VxLCBwb3J0LCBhZGRyLmNsaWVudCwgYWRkci5w
b3J0KSA8IDApIHsKPiA+ICAgICBzbmRfc2VxX3F1ZXJ5X3N1YnNjcmliZV9zZXRfaW5kZXgoc3Vi
cywKPiA+IHNuZF9zZXFfcXVlcnlfc3Vic2NyaWJlX2dldF9pbmRleChzdWJzKSArIDEpOwo+ID4g
ICB9Cj4gPiB9Cj4gPgo+ID4gMS4gSXMgdGhlIG5vbi11cGRhdGVkIHN1YnMgaW5kZXggYW4gZXhw
ZWN0ZWQgYmVoYXZpb3IgPwo+Cj4gU29ydCBvZiwgeWVzLiAgSXQncyBubyBpdGVyYXRvciBvcGVy
YXRpb24gbGlrZSBxdWVyeV9uZXh0X2NsaWVudC4KPiBJdCBqdXN0IHF1ZXJpZXMgdGhlIGdpdmVu
IGluZGV4IGFuZCBmaWxscyBvdXQgdGhlIHJlc3VsdC4gIFRoZSB1c2VyCj4gbmVlZHMgdG8gaXRl
cmF0ZSB3aXRoIGluY3JlbWVudGluZyB0aGUgaW5kZXggbWFudWFsbHkuCj4KPiA+IDIuIElzIG15
IGZpeCBhIGNvcnJlY3Qgb25lIG9yIGNvdWxkIGl0IGxlYWRzIHRvIG90aGVyIGlzc3VlcyA/Cj4K
PiBJdCdzIHRoZSBjb3JyZWN0IGltcGxlbWVudGF0aW9uLgo+Cj4KPiBIVEgsCj4KPiBUYWthc2hp
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
