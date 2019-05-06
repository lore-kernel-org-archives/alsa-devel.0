From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: SOF: Fix a compile warning with
 CONFIG_PCI=n
Date: Mon, 06 May 2019 11:21:57 -0700
Message-ID: <b8f759f63a64b7e9ea21ae8b659a5e1d5ff294df.camel@linux.intel.com>
References: <20190506150224.1394-1-tiwai@suse.de>
 <20190506150224.1394-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69A95F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 20:22:13 +0200 (CEST)
In-Reply-To: <20190506150224.1394-3-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDE5LTA1LTA2IGF0IDE3OjAyICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4g
QSB0cml2aWFsIGZpeCBmb3IgdGhlIHJhbmRjb25maWcgYnVpbGQgZXJyb3I6Cj4gICBzb3VuZC9z
b2Mvc29mL29wcy5jOjIwOjY6IHdhcm5pbmc6IOKAmHJldOKAmSBpcyB1c2VkIHVuaW5pdGlhbGl6
ZWQgaW4KPiB0aGlzIGZ1bmN0aW9uIFstV3VuaW5pdGlhbGl6ZWRdCkxvb2tzIGdvb2QuIFRoYW5r
cywgVGFrYXNoaS4KClJhbmphbmkKPiAKPiBGaXhlczogZDFkOTVmY2I2M2UzICgiQVNvQzogU09G
OiBBZGQgRFNQIEhXIGFic3RyYWN0aW9uIG9wZXJhdGlvbnMiKQo+IFNpZ25lZC1vZmYtYnk6IFRh
a2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KPiAtLS0KPiAgc291bmQvc29jL3NvZi9vcHMuYyB8
IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2Yvb3BzLmMgYi9zb3VuZC9zb2Mvc29mL29wcy5j
Cj4gaW5kZXggODBmOTA3NzQwYjgyLi43YTI3YzNiNzE5ZTcgMTAwNjQ0Cj4gLS0tIGEvc291bmQv
c29jL3NvZi9vcHMuYwo+ICsrKyBiL3NvdW5kL3NvYy9zb2Yvb3BzLmMKPiBAQCAtMTcsNyArMTcs
NyBAQCBib29sIHNuZF9zb2ZfcGNpX3VwZGF0ZV9iaXRzX3VubG9ja2VkKHN0cnVjdAo+IHNuZF9z
b2ZfZGV2ICpzZGV2LCB1MzIgb2Zmc2V0LAo+ICB7Cj4gIAlzdHJ1Y3QgcGNpX2RldiAqcGNpID0g
dG9fcGNpX2RldihzZGV2LT5kZXYpOwo+ICAJdW5zaWduZWQgaW50IG9sZCwgbmV3Owo+IC0JdTMy
IHJldDsKPiArCXUzMiByZXQgPSAwOwo+ICAKPiAgCXBjaV9yZWFkX2NvbmZpZ19kd29yZChwY2ks
IG9mZnNldCwgJnJldCk7Cj4gIAlvbGQgPSByZXQ7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
