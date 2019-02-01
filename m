From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Fri, 1 Feb 2019 17:28:44 +0100
Message-ID: <4901c6a6-605e-4f43-ff38-eb492495a3c9@perex.cz>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk> <s5hsgx9ckrf.wl-tiwai@suse.de>
 <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
 <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
 <CACL=Q7y==PFTdknurbg-yZPoBjYh6n5Lduyy32Us1HepeVU-bg@mail.gmail.com>
 <CAEiLdJb-QLmtp0vWxvCj6Kb3rmkEx8dKndmBovHvx7hk93pt_Q@mail.gmail.com>
 <s5h36p8d0v8.wl-tiwai@suse.de>
 <7d46e614-9291-a95a-6216-8abe9e6f1a5d@perex.cz>
 <20190201130117.GF20797@sirena.org.uk>
 <CACL=Q7wkh4h4YNrLUS8ihBqkc-t3-B1x2s1n_f9WP_B=oRyGJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEA7267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 17:28:52 +0100 (CET)
In-Reply-To: <CACL=Q7wkh4h4YNrLUS8ihBqkc-t3-B1x2s1n_f9WP_B=oRyGJg@mail.gmail.com>
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
To: Phil Burk <philburk@google.com>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Zach_Riggle_=f0=9f=96=96?= <riggle@google.com>, ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

RG5lIDEuMi4yMDE5IHYgMTY6MzEgUGhpbCBCdXJrIG5hcHNhbChhKToKPiBUaGFuayB5b3UgYWxs
IGZvciBzb3J0aW5nIHRoaXMgb3V0LiBJdCBzZWVtcyBsaWtlIHdlIGFyZSBtb3ZpbmcgaW4gYQo+
IHJlYWxseSBnb29kIGRpcmVjdGlvbi4KPiAKPj4gSSBhZ3JlZS4gV2UgY2FuIGhhdmUganVzdCB0
d28gbW9kZXMgZm9yIHRoZSBiZWdpbm5pbmc6Cj4+IGEpIGZ1bGwgb25lICh1c2VmdWwgZm9yIHRl
c3RpbmcpCj4+IGIpIGJ1ZmZlciBvbmx5IChhbGxvdyBqdXN0IHNvdW5kIGRhdGEgbW1hcCkKPiAK
PiBUaGUgZnVsbCBvbmUgaXMgd291bGQgYWxzbyBiZSB1c2VkIGJ5IHRoZSBIQUwgZm9yIHF1ZXJ5
aW5nIHRoZSBEU1AgcG9zaXRpb24uCj4gCj4+wqDCoGlmIHdlIHNob3VsZCB1c2UgZGlmZmVyZW50
IG5hbWVzIChsaWtlIGFub25faW5vZGU6c25kLXBjbcKgYW5kCj4gYW5vbl9pbm9kZTpzbmQtcGNt
LWJ1ZmZlcinCoAo+IAo+IFRoYXQgd291bGQgYmUgaGVscGZ1bC4KPiAKPiBJIGhhdmUgYXR0YWNo
ZWQgYSByZXZpc2VkIHJlcXVpcmVtZW50cyBkb2MuIFRoZSBvcmlnaW5hbCBkb2Mgd2FzIG1vcmUg
b2YKPiBhIEhvd1RvIGZvciBPRU1zIHRvIGNyZWF0ZSB0aGUgImFub25faW5vZGU6ZG1hYnVmIiBG
RC4uIFRoaXMgY2xhcmlmaWVzCj4gdGhlIHJlcXVpcmVtZW50cyBhbmQgYWxsb3dzIGZvciB0aGUg
dXNlIG9mICJhbm9uX2lub2RlOnNuZC1wY20qIi4gSXQKPiBzaG91bGQgbWF0Y2ggd2hhdCB3ZSBo
YXZlIGFycml2ZWQgYXQgYnkgZGlzY3Vzc2lvbi4gTGV0IG1lIGtub3cgaWYgaXQKPiBtYWtlcyBz
ZW5zZS4KCkl0IGxvb2tzIGZpbmUsIGJ1dCB0aGUgSEFMIHdpbGwgdXNlIHByb2JhYmx5IHRoZSBz
dGFuZGFyZCBzb3VuZCBkZXZpY2UKb3BlbiAoL2Rldi9zbmQvKSwgZG9lc24ndD8gU286CgpmZDEg
LSAvZGV2L3NuZC9wY20gKEhBTCkgLSBzdGFuZGFyZCBzb3VuZCBkZXZpY2UgaW5vZGUgKG5vIHJl
c3RyaWN0aW9ucykKZmQyIC0gYW5vbl9pbm9kZTpzbmQtcGNtLWJ1ZmZlciAoZm9yIHRoZSBFWENM
VVNJVkUgYWNjZXNzKQoKV2l0aCBtb2RlcywgSSB0YWxrZWQgYWJvdXQgdGhlIGFub255bW91cyBk
dXAgaW9jdGwgcGFyYW1ldGVyLiBJZiB0aGVyZSdzCmFub3RoZXIgcmVzb3VyY2UgbWFuYWdlciBh
Ym92ZSBIQUwsIHRoZSBzaXR1YXRpb24gbWlnaHQgYmU6CgpmZDEgLSAvZGV2L3NuZC9wY20gKHJl
c291cmNlIG1hbmFnZXIpIC0gc3RhbmRhcmQgc291bmQgZGV2aWNlIGlub2RlCmZkMiAtIGFub25f
aW5vZGU6c25kLXBjbSAoYWNjZXNzIHRvIHRoZSBmdWxsIHBjbSBzb3VuZCBBUEkgdXNpbmcgdGhl
CmFub255bW91cyBpbm9kZSkKZmQzIC0gYW5vbl9pbm9kZTpzbmQtcGNtLWJ1ZmZlciAoZm9yIHRo
ZSBFWENMVVNJVkUgYWNjZXNzKQoKUGVyaGFwcyB5b3UgaGF2ZSBkaWZmZXJlbnQgbGF5ZXJzIGlu
IEFuZHJvaWQuCgoJCQlUaGFua3MsCgkJCQlKYXJvc2xhdgoKCi0tIApKYXJvc2xhdiBLeXNlbGEg
PHBlcmV4QHBlcmV4LmN6PgpMaW51eCBTb3VuZCBNYWludGFpbmVyOyBBTFNBIFByb2plY3Q7IFJl
ZCBIYXQsIEluYy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
