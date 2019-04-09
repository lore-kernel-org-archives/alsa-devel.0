From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v5 05/14] ASoC: SOF:
 Add PCM operations support
Date: Tue, 9 Apr 2019 11:11:07 -0500
Message-ID: <64b8931b-bf6d-8619-013e-e8d5d04bcdba@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
 <f5346e231c80876f0fa74e1172d570b0033cbf42.camel@linux.intel.com>
 <s5hv9zsy6qr.wl-tiwai@suse.de>
 <7f8f25fc-0ea5-7562-37bb-64a8468f040d@linux.intel.com>
 <s5hmukz4nbf.wl-tiwai@suse.de>
 <aafcef1c-ca4d-3026-0c58-788713479df9@linux.intel.com>
 <dd1fdce0-1ae8-c5f3-a744-d04891951de2@linux.intel.com>
 <s5htvf7uqla.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5htvf7uqla.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CgpPbiA0LzkvMTkgMTA6NDggQU0sIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBUdWUsIDA5IEFw
ciAyMDE5IDE2OjIzOjE3ICswMjAwLAo+IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOgo+Pgo+
Pgo+Pj4gb2ssIHRoYW5rcyBmb3IgY29uZmlybWluZy4gd2UnbGwgcmVtb3ZlIHRoZSBJTkZPX1JF
U1VNRSBmbGFnIGluIFNPRgo+Pj4gYW5kIGZvbGxvdy11cCB3aXRoIHRoZSByZW1vdmFsIG9uIGFs
bCBvdGhlciBJbnRlbCBkcml2ZXJzLiBUaGFua3MKPj4+IGZvciBlbmxpZ2h0ZW5pbmcgdXMgb24g
dGhpcy4KPj4KPj4gQWN0dWFsbHkgb25lIG1vcmUgcXVlc3Rpb24gcmVsYXRlZCB0byB0aGUgZG9j
dW1lbnRhdGlvbiwgd2hpY2ggcmVhZHMKPj4KPj4gIk5vdGUgdGhhdCB0aGUgdHJpZ2dlciB3aXRo
IFNVU1BFTkQgY2FuIGFsd2F5cyBiZSBjYWxsZWQgd2hlbgo+PiBzbmRfcGNtX3N1c3BlbmRfYWxs
KCkgaXMgY2FsbGVkLCByZWdhcmRsZXNzIG9mIHRoZQo+PiBTTkRSVl9QQ01fSU5GT19SRVNVTUUg
ZmxhZy4gVGhlIFJFU1VNRSBmbGFnIGFmZmVjdHMgb25seSB0aGUgYmVoYXZpb3IKPj4gb2Ygc25k
X3BjbV9yZXN1bWUoKS4gKFRodXMsIGluIHRoZW9yeSwgU05EUlZfUENNX1RSSUdHRVJfUkVTVU1F
IGlzbuKAmXQKPj4gbmVlZGVkIHRvIGJlIGhhbmRsZWQgaW4gdGhlIHRyaWdnZXIgY2FsbGJhY2sg
d2hlbiBubwo+PiBTTkRSVl9QQ01fSU5GT19SRVNVTUUgZmxhZyBpcyBzZXQuIEJ1dCwgaXTigJlz
IGJldHRlciB0byBrZWVwIGl0IGZvcgo+PiBjb21wYXRpYmlsaXR5IHJlYXNvbnMuKSIKPj4KPj4g
SSBjb3VsZCBub3QgZmlndXJlIG91dCB3aGF0IHRoZSBsYXN0IHNlbnRlbmNlIG1lYW5zLiBJdCdz
IG15Cj4+IHVuZGVyc3RhbmRpbmcgdGhhdCB0aGUgcmVzdW1lX3RyaWdnZXIgd2lsbCBuZXZlciBi
ZSBjYWxsZWQgd2l0aCB0aGUKPj4gY29kZSBmbG93IGJlbG93IHdoZW4gSU5GT19SRVNVTUUgaXNu
J3QgZGVjbGFyZWQuIFdvdWxkIHlvdSBtaW5kCj4+IGNsYXJpZnlpbmcgd2hhdCB0aGlzIGNvbXBh
dGliaWxpdHkgbWlnaHQgYmU/IFRoYW5rcyEKPiAKPiBXZWxsLCBpbiB0aGUgYWJvdmUgImJldHRl
ciB0byBrZWVwIGl0IiB0ZXh0IC0tIGhlcmUgIml0IiB3YXMgbWVhbnQgYXMKPiBTTkRSVl9QQ01f
VFJJR0dFUl9SRVNVTUUgY2FzZSBoYW5kbGluZyBpbiB0aGUgdHJpZ2dlciBjYWxsYmFjaywgbm90
IGFzCj4gU05EUlZfUENNX0lORk9fUkVTVU1FIGZsYWcuICBUaGF0IGlzLCB0aGUgYWJvdmUgcmVj
b21tZW5kcyBhIHRyaWdnZXIKPiBjYWxsYmFjayBsaWtlIGJlbG93IHdvdWxkIGtlZXAgU05EUlZf
UENNX1RSSUdHRVJfUkVTVU1FIGFsdGhvdWdoIGl0Cj4gd29uJ3QgYmUgY2FsbGVkIHByYWN0aWNh
bGx5OgoKVGhhdCdzIHRoZSBwYXJ0IHRoYXQgSSBmaW5kIG9kZC4gd2Uga2VlcCB0aGUgVFJJR0dF
Ul9SRVNVTUUgYnV0IGl0IHdpbGwgCm5ldmVyIGJlIGNhbGxlZCwgdGhhdCdzIGFuIHVucmVhY2hh
YmxlL3VudGVzdGFibGUgc3dpdGNoIGNhc2UsIG5vPyBPciB3ZSAKc2hvdWxkIHRyYXAgaXQgYXMg
YW4gZXJyb3IgY2FzZS4KCj4gc3RhdGljIGludCBmb29fdHJpZ2dlciguLi4uKQo+IHsKPiAJc3dp
dGNoIChjbWQpIHsKPiAJY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9TVEFSVDoKPiAJY2FzZSBTTkRS
Vl9QQ01fVFJJR0dFUl9SRVNVTUU6Cj4gCQlkb19zdGFydCgpOwo+IAkJYnJlYWs7Cj4gCWNhc2Ug
U05EUlZfUENNX1RSSUdHRVJfU1RPUDoKPiAJY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9TVVNQRU5E
Ogo+IAkJZG9fc3RvcCgpOwo+IAkJYnJlYWs7Cj4gCS4uLi4KPiAJfQo+IAkuLi4uCj4gfQo+IAo+
IAo+IFRoaXMgdGV4dCBuZWVkcyBjbGVhcmx5IGEgYmV0dGVyIHJlcGhyYXNpbmcuLi4KPiAKPiAK
PiBUYWthc2hpCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
