From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/5] Stripe control functionality
Date: Mon, 14 Jan 2019 11:40:20 -0600
Message-ID: <64f96787-2653-f510-6269-43f387d4f2cb@linux.intel.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
 <3c6dd485-515b-98c1-7179-a8dea256e56c@linux.intel.com>
 <09f9e81c-0e5c-69eb-3671-1d26c86e9d44@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id E9993266860
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 18:40:22 +0100 (CET)
In-Reply-To: <09f9e81c-0e5c-69eb-3671-1d26c86e9d44@nvidia.com>
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
To: Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4+PiBTdHJpcGUgY29udHJvbCB2ZXJiIHJlcG9ydHMgYW5kIGNvbnRyb2xzIHRoZSBzdHJpcGUg
Y2FwYWJpbGl0eSBvZiBhbgo+Pj4gQXVkaW8gT3V0cHV0IENvbnZlcnRlci4gVGhpcyB2ZXJiIG5l
ZWRzIHRvIGJlIGltcGxlbWVudGVkIG9ubHkgZm9yIGFuCj4+PiBhdWRpbyBvdXRwdXQgY29udmVy
dGVyIGFuZCBvbmx5IGlmIHRoZSBzdHJpcGUgYml0IG9mIHRoZSBBdWRpbyBXaWRnZXQKPj4+IENh
cGFiaWxpdGllcyBwYXJhbWV0ZXIgaXMgMS4KPj4+IFN0cmlwZSBjb250cm9sOiBnZXQgY29kZSgw
eGYyNCkgYW5kIHNldCBjb2RlKDB4NzI0KQo+Pgo+PiB0aGUgc2VyaWVzIGxvb2sgb2sgKG9uZSBt
aW5vciBjb21tZW50IG9uIG9wZXJhdG9yIHByZWNlZGVuY2UpIGFuZCAKPj4gYWxpZ25lZCB3aXRo
IG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIEhEYXVkaW8gMS4wYSBzcGVjLgo+Pgo+PiBUaGF0IHNh
aWQgeW91IG1hZGUgbm8gbWVudGlvbiBvZiB0aGUgU3RyaXBlIGJpdMKgIChmaWd1cmUgODYpIGFu
ZCAKPj4gZmllbGRzIDIyOjIwIChTdHJpcGUgY2FwYWJpbGl0eSkgaW4gRmlndXJlIDc1LCBzbyBp
dCdzIG5vdCBjbGVhciB0byAKPj4gbWUgaWYgdGhlIHN1cHBvcnQgYWRkZWQgaW4gdGhpcyBwYXRj
aHNldCBpcyBzdWZmaWNpZW50IG9yIGlmIHRoZXJlIGlzIAo+PiBhZGRpdGlvbmFsIGxvZ2ljIHRv
IGJlIHNldC4KPj4KPiBTdHJpcGUgYml0IGlzIHBhcnQgb2YgQXVkaW8gV2lkZ2V0IENhcGFiaWxp
dHkgcGFyYW1ldGVyIGFuZCBpcyAKPiBtZW50aW9uZWQgYWJvdmUgaW4gdGhlIGxhc3Qgc2VjdGlv
biBvZiBiYWNrZ3JvdW5kLiBQYXRjaC01KHYyKSBjaGVja3MgCj4gZm9yIHRoZSBzdHJpcGUgYml0
LCBiZWZvcmUgc2VuZGluZyBzdHJpcGUgY29udHJvbCB2ZXJiLgoKQWggeWVzLCBJIHRob3VnaHQg
dGhpcyBwYXRjaHNldCBhZGRlZCBzdHJpcGUgY29udHJvbCBzdGFydGluZyBmcm9tIApzY3JhdGNo
IGJ1dCBzb21lIGRlZmluaXRpb25zIHdlcmUgYWxyZWFkeSBwcmVzZW50LiBUaGFua3MgZm9yIHRo
ZSBwcmVjaXNpb24uCgo+IEFzIGZhciBhcyBzdHJpcGUgY29udHJvbCByZWdpc3RlciBpcyBjb25j
ZXJuZWQgKDIyOjIwKSwgSSBkb24ndCB0aGluayAKPiBhbnkgU1cgcHJvZ3JhbW1pbmcgaXMgcmVx
dWlyZWQgZm9yIHRoaXMuCgpZZXMgY29ycmVjdC4gdGhpcyBpcyBvbiBHRVQgb25seSBzbyBzb21l
dGhpbmcgdGhlIGNvZGVjIG5lZWRzIHRvIHdvcnJ5IAphYm91dCwgbm90IHRoZSBkcml2ZXIuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
