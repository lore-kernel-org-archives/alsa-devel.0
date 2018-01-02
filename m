From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 15/27] ALSA: hda - Use
 timecounter_initialize interface
Date: Tue, 2 Jan 2018 11:15:45 -0600
Message-ID: <3c5734a2-8f97-4a8b-26d4-42852cc86352@linux.intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de> <20171215165125.avkz25eek56i5md4@localhost>
 <s5h4lorx6ha.wl-tiwai@suse.de>
 <b0d5ff40-fbfe-e5b3-2844-7d930484e87f@intel.com>
 <20171228164944.crphv46zegvwautk@localhost>
 <1a9a1507-7ca3-459b-c2ce-02fc2afad2ff@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA1226718D
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 18:15:31 +0100 (CET)
In-Reply-To: <1a9a1507-7ca3-459b-c2ce-02fc2afad2ff@intel.com>
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
To: Sagar Arun Kamble <sagar.a.kamble@intel.com>, Richard Cochran <richardcochran@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMS8yLzE4IDEyOjAzIEFNLCBTYWdhciBBcnVuIEthbWJsZSB3cm90ZToKPiAKPiAKPiBPbiAx
Mi8yOC8yMDE3IDEwOjE5IFBNLCBSaWNoYXJkIENvY2hyYW4gd3JvdGU6Cj4+IE9uIFR1ZSwgRGVj
IDI2LCAyMDE3IGF0IDAxOjA3OjM1UE0gKzA1MzAsIFNhZ2FyIEFydW4gS2FtYmxlIHdyb3RlOgo+
Pj4+IE9yIGNhbiB3ZSBwcm92aWRlIHNpbXBsZXIgdmVyc2lvbnMgZm9yIGNvdmVyaW5nIHNvbWUg
ZGVmYXVsdHM/wqAgQXQKPj4+PiBsZWFzdCByZWR1Y2luZyB0aGUgbnVtYmVyIG9mIGFyZ3VtZW50
cyB3b3VsZCBtYWtlIHRoaW5ncyBlYXNpZXIuCj4+PiBUaG91Z2h0IGFib3V0IHNwZWNpZnlpbmcg
MS4gY3ljbGVjb3VudGVyIHJlYWQgZnVuYyAyLiBmcmVxdWVuY3kgMy4gCj4+PiB3aWR0aCBvZgo+
Pj4gY291bnRlciBhcyBwYXJhbWV0ZXJzIGhlcmUKPj4+IHdoaWNoIGNhbiBnZXQgcmlkIG9mIG11
bHQsIHNoaWZ0IHBhcmFtcy4gQnV0IHRoaXMgaXMgbm90IGVhc3kgYXMgbW9zdCAKPj4+IG9mIHRo
ZQo+Pj4gZHJpdmVycyBkbyBub3Qgc3BlY2lmeQo+Pj4gY3ljbGVjb3VudGVyIGZyZXF1ZW5jeSBh
bmQgaW5zdGVhZCBoYXJkLWNvZGUgdGhlIG11bHQvc2hpZnQgZmFjdG9ycy4KPj4gWW91IGFyZSB0
YWxraW5nIGFib3V0IHVzaW5nIGNsb2Nrc19jYWxjX211bHRfc2hpZnQoKSBoZXJlLCByaWdodD8g
KFNlZQo+PiB0aGUgdXNhZ2UgZXhhbXBsZSBpbiBkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9jcHRz
LmMpLgo+IFllcwo+PiBUaGlzIGlzIGEgZ29vZCBpZGVhLCBhbmQgaXQgaXMgd29ydGggZ2V0dGlu
ZyB0aGUgZHJpdmVyIGF1dGhvcnMnIGlucHV0Cj4+IHRvIGZpZ3VyZSBvdXQgdGhlIGNvcnJlY3Qg
cGFyYW1ldGVycy4KCkkgd3JvdGUgdGhlIGNvZGUgZm9yIEhEYXVkaW8gYW5kIEkgcmVtZW1iZXIg
d2FzdGluZyB0aW1lIHRyeWluZyB0byAKZmlndXJlIG91dCB0aGUgZ29yeSBkZXRhaWxzIG9mIHRo
ZSBjeWNsZSBjb3VudGVyIHN0dWZmIHdoZW4gYWxsIEkgd2FudGVkIAp3YXMgYSBjb252ZXJzaW9u
IGZyb20gYSAyNE1IeiBjb3VudGVyIHRvIG5zIHZhbHVlcyB1c2luZyBhIDEyNS8zIApvcGVyYXRp
b24gaW4gdGhlIHJpZ2h0IG9yZGVyIC0gYXMgZXhwbGFpbmVkIGluIHRoZSBjb21tZW50cwoKSWYg
dGhlcmUgd2FzIGEgaGVscGVyIHRvIHNldCB0aG9zZSBtdWx0L3NoaWZ0IHZhbHVlcyBpdCdkIG1h
a2UgdGhlIApIRGF1ZGlvIGNvZGUgY2xlYXJlciAoYW5kIGFsc28gaGVscCBzdXBwb3J0IG5ld2Vy
IG1vZGVzIG9mIG9wZXJhdGlvbiAKd2l0aCBhIDEyIGFuZCA2IE1IeiBNQ0xLKS4KClRoZSBpbml0
aWFsIHByb3Bvc2FsIHdpdGggaGFyZC1jb2RlZCB2YWx1ZXMgaW4gYXJndW1lbnRzIGluc3RlYWQg
b2YgCnN0cnVjdHVyZSBtZW1iZXJzIGRpZG4ndCByZWFsbHkgbWFrZSB0aGUgY29kZSBjbGVhcmVy
LgoKCj4+Cj4+IEkgYmV0IHdlIGNhbiB1c2UgdGhhdCBhbG1vc3QgZXZlcnl3aGVyZS7CoCBJZiB0
aGVyZSBhcmUgYW55IGRyaXZlcnMKPj4gdGhhdCBjYW5ub3QgYmUgY29udmVydGVkLCB0aGVuIHdl
IGNhbiBsZWF2ZSBzb21lIHNvcnQgb2YgbG93IGxldmVsCj4+IGxlZ2FjeSBpbml0aWFsaXphdGlv
biBtZXRob2QuCj4gQWdyZWUKPj4gVGhhbmtzLAo+PiBSaWNoYXJkCj4+Cj4gCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxp
bmcgbGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
