From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: fix
 compilation warning and quirk handling
Date: Thu, 18 Apr 2019 07:57:41 -0500
Message-ID: <8b85ff82-f946-5efc-4fd2-73ddefb66aaa@linux.intel.com>
References: <20190410160548.24317-1-pierre-louis.bossart@linux.intel.com>
 <fec99a28-8109-659a-a51e-f1475a015144@redhat.com>
 <cbd7885e-07a0-fadb-b5dd-21e7cdec9b25@linux.intel.com>
 <9d12bcab-40d8-c6c6-017a-cbaad64903d8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92962F896E2
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 14:57:48 +0200 (CEST)
In-Reply-To: <9d12bcab-40d8-c6c6-017a-cbaad64903d8@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Paul Cercueil <paul@crapouillou.net>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gNC8xOC8xOSA2OjU3IEFNLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+IEhpLAo+IAo+IE9uIDEw
LTA0LTE5IDE5OjU4LCBQaWVycmUtTG91aXMgQm9zc2FydCB3cm90ZToKPj4KPj4+IFRoZXJlIGlz
IGEgZ29vZCByZWFzb24gdG8gdXNlIC0xIGZvciBxdWlyay1vdmVycmlkZSBub3Qgc2V0Lgo+Pj4K
Pj4+IFRoZSB1c2VyIG1heSB3YW50IHRvIG92ZXJyaWRlIHRoZSBxdWlyayB2YXJpYWJsZSB0byBh
Y3R1YWwgMCwgb24KPj4+IENIVCB3ZSBkZWZhdWx0IHRvOgo+Pj4KPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIE90aGVycyBkZWZhdWx0IHRvIGludGVybmFsLW1pYy1pbjEt
bWFwLCAKPj4+IG1vbm8tc3BlYWtlciAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcXVpcmsgPSBCWVRfQ0hUX0VTODMxNl9JTlRNSUNfSU4xX01BUCB8Cj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQllUX0NIVF9FUzgzMTZf
TU9OT19TUEVBS0VSOwo+Pj4KPj4+IFdoaWNoIGlzIDB4MjAwMDAsIGlmIHRoZSB1c2VyIG5vdyBq
dXN0cyB3YW50cyB0byBjbGVhciB0aGUKPj4+IEJZVF9DSFRfRVM4MzE2X01PTk9fU1BFQUtFUiBm
bGFnIHRocm91Z2ggdGhlIG92ZXJyaWRlLCB0aGVuIHRoZSB1c2VyCj4+PiBtdXN0IGJlIGFibGUg
dG8gc3BlY2lmeSAwIGFzIG92ZXJyaWRlLgo+Pgo+PiBvaywgSSBhY2NlcHQgdGhlIGFyZ3VtZW50
IGJ1dCB0aGVuIHdoeSBkb24ndCB3ZSBkbyB0aGUgc2FtZSBpbiBvdGhlciAKPj4gbWFjaGluZSBk
cml2ZXJzPyBJIGNvdWxkIG1ha2UgdGhlIHNhbWUgYXJndW1lbnQgZm9yIGJ5dGNyX3J0NTY0MC81
MSwgCj4+IHNvIHdlIHNob3VsZCBhbGlnbiBhbGwgbWFjaGluZSBkcml2ZXJzIHVzaW5nIHRoaXMg
bWVjaGFuaXNtLgo+IAo+IEkgYWdyZWUgdGhhdCBpZGVhbGx5IGFsbCBtYWNoaW5lIGRyaXZlcnMg
c2hvdWxkIGJlIHVwZGF0ZWQgdG8gdXNlIC0xCj4gZm9yICJxdWlyayBvdmVycmlkZSBub3Qgc2V0
Ii4gVGhlIGRyaXZlcnMgd2hpY2ggYXJlIGN1cnJlbnRseSBub3QKPiB1c2luZyAtMSBhbHJlYWR5
IGhhZCB0aGVpciBjdXJyZW50IHF1aXJrLW92ZXJyaWRlIGltcGxlbWVudGF0aW9uIGluCj4gcGxh
Y2UgYmVmb3JlIEkgc3RhcnRlZCB3b3JraW5nIG9uIHRoZW0uCgpUaGFua3MgSGFucywgSSdsbCBw
cm92aWRlIGFuIHVwZGF0ZSBzaG9ydGx5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
