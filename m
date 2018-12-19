From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Wed, 19 Dec 2018 22:51:17 +0100
Message-ID: <28564095-1b2b-679b-e2ae-e741c23905ba@redhat.com>
References: <20181216185429.GA20408@gerhold.net>
 <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net> <20181217204320.GC10938@gerhold.net>
 <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
 <20181219130747.GA83656@gerhold.net>
 <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
 <fae4f9e7-5ec6-307f-c862-47f25dbc2cfc@redhat.com>
 <20181219215911.6876b18d44c34318fe01a650@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2AC26782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 22:51:19 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id t6so20857726wrr.12
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 13:51:19 -0800 (PST)
In-Reply-To: <20181219215911.6876b18d44c34318fe01a650@ao2.it>
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
To: Antonio Ospite <ao2@ao2.it>
Cc: alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAxOS0xMi0xOCAyMTo1OSwgQW50b25pbyBPc3BpdGUgd3JvdGU6Cj4gT24gV2VkLCAx
OSBEZWMgMjAxOCAxNToyMzoxMyArMDEwMAo+IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhh
dC5jb20+IHdyb3RlOgo+IAo+PiBIaSwKPj4KPj4gT24gMTktMTItMTggMTU6MDQsIFBpZXJyZS1M
b3VpcyBCb3NzYXJ0IHdyb3RlOgo+Pj4gT24gMTIvMTkvMTggNzowNyBBTSwgU3RlcGhhbiBHZXJo
b2xkIHdyb3RlOgo+IFsuLi5dCj4+Pj4gSSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2ggYWJvdmUgb24g
bXkgZGV2aWNlIHdpdGg6Cj4+Pj4gIMKgIC0gYXMtaXMsIHdpdGhvdXQgYW55IG1vZGlmaWNhdGlv
bnM6Cj4+Pj4gIMKgwqDCoMKgIC0+ICJGYWxsaW5nIGJhY2sgdG8gQmF5dHJhaWwtQ1IgcGxhdGZv
cm0iLCBzb3VuZCBub3cgd29ya2luZwo+Pj4+ICDCoCAtIGEgc2ltdWxhdGVkICJCWVQtVCIgZGV2
aWNlOiAoY29waWVkIHRoZSBJUlFzIGZyb20gdGhlIERTRFQgb2YgdGhlIFQxMDBUQSkKPj4+PiAg
wqDCoMKgwqAgLT4gIkJZVC1DUiBub3QgZGV0ZWN0ZWQiIC0gdXNlcyA1dGggSVJRLCBzb3VuZCB3
b3JraW5nCj4+Pj4gIMKgIC0gYSBzaW11bGF0ZWQgIkJZVC1DUiIgZGV2aWNlIChtYWRlIGlzX2J5
dF9jcigpIHJldHVybiAidHJ1ZSIgYW5kCj4+Pj4gIMKgwqDCoCBjb3BpZWQgdGhlIElSUXMgZnJv
bSB0aGUgRFNEVCBvZiB0aGUgVDEwMFRBRikKPj4+PiAgwqDCoMKgwqAgLT4gIkRldGVjdGVkIEJh
eXRyYWlsLUNSIHBsYXRmb3JtIiAtIHVzZXMgSVJRIGF0IGluZGV4IDAsIHNvdW5kIHdvcmtpbmcK
Pj4+Pgo+Pj4+IExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rIQo+Pj4KPj4+IFNvdW5kcyBnb29k
LCBwbGF5aW5nIHdpdGggcmVzb3VyY2VzIGlzIHdoYXQgSSBoYWQgaW4gbWluZCByYXRoZXIgdGhh
biBhbiBpbnRlcnJ1cHQgY291bnQgd2hpY2ggaXNuJ3QgbmVjZXNzYXJpbHkgc2FmZS4gVGhlIG9u
bHkgaW1wcm92ZW1lbnQgSSB3b3VsZCBzdWdnZXN0IGlzIHRvIGFkZCB0aGlzIHRlc3QgaW5zaWRl
IG9mIGlzX2J5dF9jcigpLiBUaGlzIHJvdXRpbmUgd2lsbCBiZSBtb3ZlZCBhcyBhIGhlbHBlciBv
dXRzaWRlIG9mIHNzdF9hY3BpIHRvIGJlIHJldXNlZCBmb3IgU09GLCBzbyBpZiB3ZSBjYW4gbWFr
ZSB0aGlzIHRlc3QgbW9yZSBzZWxmLWNvbnRhaW5lZCBpdCdzIG1vcmUgZnV0dXJlLXByb29mLgo+
Pgo+PiBBRkFJQ1QgdGhpcyB3aWxsIG5vdCBmaXggYWxsIGNhc2VzIG9mIHRoaXMsIHNvIGl0IG1p
Z2h0IGJlIGJldHRlciB0byBzZWUgaWYKPj4gd2UgY2FuIG1ha2UgaXNfYnl0X2NyKCkgcmV0dXJu
IHRydWUgb24gdGhlc2UgZGV2aWNlcyBpbiBzb21lIG90aGVyIHdheS4KPj4KPj4gRS5nLiB0aGUg
IlRlY2xhc3QgWDk4IEFpciAzRyIgQW50b25pbyByZXBvcnRlZCBkb2VzIGxpc3QgNSBJUlFzLCBi
dXQgd2UKPj4gc2hvdWxkIHN0aWxsIHVzZSB0aGUgZmlyc3QgSVJRIGFuZCBub3QgdGhlIDV0Lgo+
Pgo+PiBBbnRvbmlvLCBkbyB5b3Uga25vdyBpZiB5b3VyIGRldmljZSB1c2VzIFNTUDAgPwo+Pgo+
IAo+IFRCSCBJIGRvbid0IHJlbWVtYmVyIG9mZiB0aGUgdG9wIG9mIG15IGhlYWQsIEknbGwgY2hl
Y2sgbXkgbm90ZXMgYW5kCj4gZ2V0IGJhY2sgb24gdGhhdCB3aGVuIEkgYWxzbyByZXBvcnQgYmFj
ayBhYm91dCByZWNlbnQga2VybmVscyBvbiBteQo+IGRldmljZS4KCkFzIFN0ZXBoYW4gcG9pbnRl
ZCBvdXQgdGhlIGtlcm5lbCBoYXMgdGhpcyBxdWlyayBmb3IgeW91ciBkZXZpY2U6CgpodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvY29tbWl0L3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvYnl0Y3JfcnQ1NjQwLmM/aWQ9ZWMxYzkw
ZTc3N2U1YTU1NTYzMjc0NzUyN2ZhZTE0MmFhMjM4ZTU4MwoKV2hpY2ggc2F5cyBpdCBpcyB1c2lu
ZyBTU1AwLCB3aGljaCBpbmRpY2F0ZXMgaXQgaXMgYSBCYXkgVHJhaWwgQ1IKKENvc3QgUmVkdWNl
ZCkgZGV2aWNlLiBTbyBpdCBzaG91bGQgaW5kZWVkIGJ5IHVzaW5nIHRoZSBJUlEgYXQgaW5kZXgK
MCwgbm90IGF0IGluZGV4IDUuIENoYW5jZXMgYXJlIHdoZW4geW91IGZpcnN0IHRlc3RlZCB0aGlu
Z3MgdGhlCmtlcm5lbCBkaWQgbm90IGhhdmUgc3BlY2lhbCBoYW5kbGluZyBmb3IgdGhlIENSIHZh
cmlhbnQgeWV0IGFuZAp0aGluZ3Mgd2lsbCBqdXN0IHdvcmsuCgpJbiB3aGljaCBjYXNlIHdlIGNh
biBnbyB3aXRoIFN0ZXBoYW4ncyBzb2x1dGlvbiBvZiBjaGVja2luZyBmb3IKdGhlcmUgbm90IGJl
aW5nIGEgNXRoIElSUSB0byByZWNvZ25pemUgdGhlIEJZVENSIGxpa2UgZGV2aWNlcwp3aGljaCBh
cmUgbm90IHByb3Blcmx5IHJlY29nbml6ZWQgYXMgQllUQ1IuCgpSZWdhcmRzLAoKSGFucwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
