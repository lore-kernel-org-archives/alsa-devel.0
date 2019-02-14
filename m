From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 05/14] ASoC: SOF:
 Add PCM operations support
Date: Thu, 14 Feb 2019 14:42:51 -0600
Message-ID: <707d8855-2f89-b0fb-4b1e-7e3cd133bfab@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-6-pierre-louis.bossart@linux.intel.com>
 <s5hftsqzked.wl-tiwai@suse.de>
 <0092ac90-10fe-fbf8-9a77-dff05e0c4525@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <0092ac90-10fe-fbf8-9a77-dff05e0c4525@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TWlzc2VkIHRoZSBjb21tZW50cyBiZWxvdyBpbiBteSBlYXJsaWVyIGFuc3dlci4KPj4+ICvCoMKg
wqAgcmV0ID0gCj4+PiBzbmRfcGNtX2xpYl9wcmVhbGxvY2F0ZV9wYWdlcyhwY20tPnN0cmVhbXNb
c3RyZWFtXS5zdWJzdHJlYW0sCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBTTkRSVl9ETUFfVFlQRV9ERVZfU0csIHNkZXYtPmRldiwKPj4+ICsgbGUz
Ml90b19jcHUoY2Fwcy0+YnVmZmVyX3NpemVfbWluKSwKPj4+ICsgbGUzMl90b19jcHUoY2Fwcy0+
YnVmZmVyX3NpemVfbWF4KSk7Cj4+PiArwqDCoMKgIGlmIChyZXQpIHsKPj4+ICvCoMKgwqDCoMKg
wqDCoCBkZXZfZXJyKHNkZXYtPmRldiwgImVycm9yOiBjYW4ndCBhbGxvYyBETUEgYnVmZmVyIHNp
emUgCj4+PiAweCV4LzB4JXggZm9yICVzICVkXG4iLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY2Fwcy0+YnVmZmVyX3NpemVfbWluLCBjYXBzLT5idWZmZXJfc2l6ZV9tYXgsCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjYXBzLT5uYW1lLCByZXQpOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiByZXQ7Cj4+PiArwqDCoMKgIH0KPj4KPj4gVGhlIGVycm9yIGNoZWNrIGhlcmUgaXMg
cmVkdW5kYW50LCBwbGVhc2UgZHJvcC4KPj4gc25kX3BjbV9saWJfcHJlYWxsb2NhdGVfcGFnZXMo
KSB3YXMgY2hhbmdlZCB0byBiZSB2b2lkIGZ1bmN0aW9uCj4+IHJlY2VudGx5LCBzbyBpdCdsbCBi
ZSBhIGJ1aWxkIGVycm9yLgp5ZXMgaW5kZWVkLiBJdCdzIG5vdCBvbiBNYXJrJ3MgZm9yLW5leHQg
YnJhbmNoIHNvIEkgbWlzc2VkIGl0LiBGaXhlZCAKbm93LCB0aGFua3MKPj4KPj4+ICsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBzbmRfbWFza19ub25lKGZtdCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc25k
X21hc2tfc2V0KGZtdCwgKF9fZm9yY2UgaW50KVNORFJWX1BDTV9GT1JNQVRfUzE2X0xFKTsKPj4K
Pj4gVXNlIHNuZF9tYXNrX3NldF9mb3JtYXQoKSBtYWNyby7CoCBUaGF0IGF2b2lkcyB0aGUgdWds
eSBjYXN0LgoKQWggeWVzLiBJcm9uaWNhbGx5IEkgd2FzIHRoZSBvbmUgd2hvIHJlcG9ydGVkIHRo
aXMgdWdseSBjYXN0IGFuZCBkaWRuJ3QgCnVwZGF0ZSBvdXIgY29kZSB3aXRoIHRoZSBuZXcgaGVs
cGVyLiBPb3BzLiBGaXhlZCBub3cuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
