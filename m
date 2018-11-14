From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: add Icelake support
Date: Wed, 14 Nov 2018 10:41:27 -0600
Message-ID: <85a47580-e47d-a600-6c17-64521996ecd4@linux.intel.com>
References: <20181110211846.23667-1-yung-chuan.liao@linux.intel.com>
 <s5hftw8ngd4.wl-tiwai@suse.de>
 <ac9cecd2-7321-34dd-a317-4d6d3c21635e@linux.intel.com>
 <s5h5zx3o6um.wl-tiwai@suse.de>
 <ad05386f-af75-3bf2-bc76-628928fc4fea@linux.intel.com>
 <s5hpnv7aexo.wl-tiwai@suse.de>
 <fadd2a71-6f2f-ea22-5372-360cf7391273@linux.intel.com>
 <s5hk1lfaa5h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BED022677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 17:41:29 +0100 (CET)
In-Reply-To: <s5hk1lfaa5h.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Cj4+IFNvIGluIHRoZW9yeSBhbGwgd2UgbmVlZCB0byBhZGQgaXMgYSBuZXcgdGFibGUgZW50cnkg
aW4gc2tsLmMsCj4+IGUuZy4gd2l0aCB0aGUgZm9sbG93aW5nIHVudGVzdGVkIGNvZGUuIEknbGwg
aGF2ZSB0byBjaGVjayBpZiB0aGlzIGlzCj4+IGNvcnJlY3Qgb2ZmbGluZSBidXQgaXQnZCBhbGxv
dyB5b3UgdG8gdGVzdCB0aGUgcHJvYmUgcGFydC4KPj4KPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9pbnRlbC9za3lsYWtlL3NrbC5jIGIvc291bmQvc29jL2ludGVsL3NreWxha2Uvc2tsLmMKPj4g
aW5kZXggYWMwYjRmZjIxYWNjLi4zNzVmNGI2MGU1MTUgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3Nv
Yy9pbnRlbC9za3lsYWtlL3NrbC5jCj4+ICsrKyBiL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtlL3Nr
bC5jCj4+IEBAIC0xMDk4LDYgKzEwOTgsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZp
Y2VfaWQgc2tsX2lkc1tdID0gewo+PiAgwqDCoMKgwqDCoMKgwqAgLyogQ05MICovCj4+ICDCoMKg
wqDCoMKgwqDCoCB7IFBDSV9ERVZJQ0UoMHg4MDg2LCAweDlkYzgpLAo+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZAo+PiBsb25nKSZzbmRf
c29jX2FjcGlfaW50ZWxfY25sX21hY2hpbmVzfSwKPj4gK8KgwqDCoMKgwqDCoCAvKiBDRkwgKi8K
Pj4gK8KgwqDCoMKgwqDCoCB7IFBDSV9ERVZJQ0UoMHg4MDg2LCAweGEzNDgpLAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQKPj4gbG9uZykm
c25kX3NvY19hY3BpX2ludGVsX2NubF9tYWNoaW5lc30KPj4gIMKgwqDCoMKgwqDCoMKgIHsgMCwg
fQo+PiAgwqB9Owo+IEkndmUgYWxyZWFkeSB0cmllZCBpdCBidXQgdGhpcyBkb2Vzbid0IHNlZW0g
ZW5vdWdoLiAgVGhlIHNpbWlsYXIKPiBhZGRpdGlvbiBmb3IgMHhhMzQ4IGlzIG5lZWRlZCBpbiBz
a2wtbWVzc2FnZXMuYyBmb3IgY2xrIHNldHVwLgo+IChCVFcsIHJlbG9hZGluZyB0aGUgbW9kdWxl
IGFmdGVyIHRoaXMgZXJyb3IgdHJpZ2dlcmVkIHRoZSBsZWZ0b3Zlcgo+ICAgc3lzZnMgZW50cmll
czsgeW91IGNhbiB0cnkgdG8gaW5qZWN0IHRoZSBlcnJvciBhbmQgcmVwcm9kdWNlIGl0LikKPgo+
IEFmdGVyIHRoZXNlIGNoYW5nZXMsIHRoZSBkcml2ZXIgd2FzIGxvYWRlZCwgYnV0IGl0IHN0aWxs
IGNvbXBsYWlucwo+IGFib3V0IHRoZSBsYWNrIG9mIGZpcm13YXJlIChib3RoIFNPRiBhbmQgZmFs
bGJhY2sgb25lKS4KPiBUaGUgYmluZGluZyB3aXRoIEhETUkgY29kZWMgc2VlbXMgd29ya2luZywg
YnV0IHRoZSBhbmFsb2cgb25lIGlzIHN0aWxsCj4gbWlzc2luZy4KCklzIHRoaXMgbGFjayBvZiBm
aXJtd2FyZSBvciBmaXJtd2FyZSB0aGF0IHdvbid0IGJvb3QgZHVlIHRvIApjb25maWd1cmF0aW9u
IGlzc3Vlcz8KCklmIHlvdSBjYW4gc2hhcmUgdGhlIGRtZXNnIGxvZyBzb21ld2hlcmUgaXQnZCBi
ZSBpbnRlcmVzdGluZywgSSBhbSAKdHJ5aW5nIHRvIGhlbHAgZml4IHN1cHBvcnQgZm9yIFdITCBh
bmQgQ0ZMICpzaG91bGQqIGJlIHNpbWlsYXIgKEkgCmhhdmVuJ3QgY2hlY2tlZCB0aGUgYWN0dWFs
IHNwZWNzIHRob3VnaCkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
