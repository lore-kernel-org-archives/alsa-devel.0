From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 10:49:56 -0600
Message-ID: <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 25D3E2667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:49:59 +0100 (CET)
In-Reply-To: <20190115162155.6308-6-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2NvZGVjLmMgYi9zb3VuZC9wY2kvaGRh
L2hkYV9jb2RlYy5jCj4gaW5kZXggOWY4ZDU5ZTdlODlmLi5mZjZkYmVkNGQzY2QgMTAwNjQ0Cj4g
LS0tIGEvc291bmQvcGNpL2hkYS9oZGFfY29kZWMuYwo+ICsrKyBiL3NvdW5kL3BjaS9oZGEvaGRh
X2NvZGVjLmMKPiBAQCAtMjkyNyw4ICsyOTI3LDYgQEAgc3RhdGljIGludCBoZGFfY29kZWNfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKPiAgIAl1bnNpZ25lZCBpbnQgc3RhdGU7
Cj4gICAKPiAgIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvZGVjLT5qYWNrcG9sbF93b3Jr
KTsKPiAtCWxpc3RfZm9yX2VhY2hfZW50cnkocGNtLCAmY29kZWMtPnBjbV9saXN0X2hlYWQsIGxp
c3QpCj4gLQkJc25kX3BjbV9zdXNwZW5kX2FsbChwY20tPnBjbSk7Cj4gICAJc3RhdGUgPSBoZGFf
Y2FsbF9jb2RlY19zdXNwZW5kKGNvZGVjKTsKPiAgIAlpZiAoY29kZWMtPmxpbmtfZG93bl9hdF9z
dXNwZW5kIHx8Cj4gICAJICAgIChjb2RlY19oYXNfY2xrc3RvcChjb2RlYykgJiYgY29kZWNfaGFz
X2Vwc3MoY29kZWMpICYmCgpxdWVzdGlvbjogc2luY2Ugd2Ugbm93IHVzZSBIREF1ZGlvIGNvZGVj
cyBpbiBhbiBBU29DLWJhc2VkIAppbXBsZW1lbnRhdGlvbiAoYm90aCB3aXRoIHRoZSBTa3lsYWtl
IGFuZCBTT0YgZHJpdmVycyksIGlzIHRoaXMgY3JlYXRpbmcgCmEgY2FzZSB3aGVyZSBzdXNwZW5k
IG5vIGxvbmdlciB3b3Jrcz8gSSBzZWUgbm8gc3VzcGVuZCBzdXBwb3J0IGluIApzb3VuZC9zb2Mv
Y29kZWMvaGRhY19oZGEuYwoKSSBqdXN0IGFkZGVkIGEgcXVpY2sgdHJhY2UgaW4gdGhlIGxpbmVz
IGJlaW5nIGRlbGV0ZWQgYW5kIHRob3NlIGxpbmVzIAp3ZXJlIGRlZmluaXRpdmVseSBleGVjdXRl
ZC4KCiDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShwY20sICZjb2RlYy0+cGNtX2xpc3RfaGVh
ZCwgbGlzdCkgewogwqDCoMKgIMKgwqDCoCBwcl9lcnIoInBsYjogc3VzcGVuZGluZyBwY21cbiIp
OwogwqDCoMKgIMKgwqDCoCBzbmRfcGNtX3N1c3BlbmRfYWxsKHBjbS0+cGNtKTsKIMKgwqDCoCB9
CgpbwqDCoMKgIDIuNTE2MzQ5XSBwbGI6IHN1c3BlbmRpbmcgcGNtClvCoMKgwqAgMi41MTYzNTBd
IHBsYjogc3VzcGVuZGluZyBwY20KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
