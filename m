From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: fix
 compilation warning and quirk handling
Date: Wed, 10 Apr 2019 12:58:48 -0500
Message-ID: <cbd7885e-07a0-fadb-b5dd-21e7cdec9b25@linux.intel.com>
References: <20190410160548.24317-1-pierre-louis.bossart@linux.intel.com>
 <fec99a28-8109-659a-a51e-f1475a015144@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8D91F8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 19:58:51 +0200 (CEST)
In-Reply-To: <fec99a28-8109-659a-a51e-f1475a015144@redhat.com>
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

Cj4gVGhlcmUgaXMgYSBnb29kIHJlYXNvbiB0byB1c2UgLTEgZm9yIHF1aXJrLW92ZXJyaWRlIG5v
dCBzZXQuCj4gCj4gVGhlIHVzZXIgbWF5IHdhbnQgdG8gb3ZlcnJpZGUgdGhlIHF1aXJrIHZhcmlh
YmxlIHRvIGFjdHVhbCAwLCBvbgo+IENIVCB3ZSBkZWZhdWx0IHRvOgo+IAo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT3RoZXJzIGRlZmF1bHQgdG8gaW50ZXJuYWwtbWljLWlu
MS1tYXAsIG1vbm8tc3BlYWtlciAqLwo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cXVpcmsgPSBCWVRfQ0hUX0VTODMxNl9JTlRNSUNfSU4xX01BUCB8Cj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQllUX0NIVF9FUzgzMTZfTU9OT19TUEVB
S0VSOwo+IAo+IFdoaWNoIGlzIDB4MjAwMDAsIGlmIHRoZSB1c2VyIG5vdyBqdXN0cyB3YW50cyB0
byBjbGVhciB0aGUKPiBCWVRfQ0hUX0VTODMxNl9NT05PX1NQRUFLRVIgZmxhZyB0aHJvdWdoIHRo
ZSBvdmVycmlkZSwgdGhlbiB0aGUgdXNlcgo+IG11c3QgYmUgYWJsZSB0byBzcGVjaWZ5IDAgYXMg
b3ZlcnJpZGUuCgpvaywgSSBhY2NlcHQgdGhlIGFyZ3VtZW50IGJ1dCB0aGVuIHdoeSBkb24ndCB3
ZSBkbyB0aGUgc2FtZSBpbiBvdGhlciAKbWFjaGluZSBkcml2ZXJzPyBJIGNvdWxkIG1ha2UgdGhl
IHNhbWUgYXJndW1lbnQgZm9yIGJ5dGNyX3J0NTY0MC81MSwgc28gCndlIHNob3VsZCBhbGlnbiBh
bGwgbWFjaGluZSBkcml2ZXJzIHVzaW5nIHRoaXMgbWVjaGFuaXNtLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
