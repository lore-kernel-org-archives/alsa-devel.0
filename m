From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 02/10] extcon: axp288: Convert to use
 acpi_dev_get_first_match_dev()
Date: Fri, 29 Mar 2019 09:53:09 +0900
Message-ID: <c5090422-e707-a774-f3ab-b5bf49cd6851@samsung.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <CGME20190328171737epcas5p2f2bc38aebfcd986cee75928fae36eee7@epcas5p2.samsung.com>
 <20190328171729.44002-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A52AF80C16
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 01:52:51 +0100 (CET)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190329005245epoutp03d68da714c01c109f066cd82bf17f82ff~QR8EGWCwY0627006270epoutp03f
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 00:52:45 +0000 (GMT)
In-Reply-To: <20190328171729.44002-3-andriy.shevchenko@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: alsa-devel@alsa-project.org

SGkgQW5keSwKCk9uIDE5LiAzLiAyOS4g7Jik7KCEIDI6MTcsIEFuZHkgU2hldmNoZW5rbyB3cm90
ZToKPiBhY3BpX2Rldl9nZXRfZmlyc3RfbWF0Y2hfbmFtZSgpIGlzIGRlcHJlY2F0ZWQgYW5kIGdv
aW5nIHRvIGJlIHJlbW92ZWQKPiBiZWNhdXNlIGl0IGxlYWtzIGEgcmVmZXJlbmNlLgo+IAo+IENv
bnZlcnQgdGhlIGRyaXZlciB0byB1c2UgYWNwaV9kZXZfZ2V0X2ZpcnN0X21hdGNoX2RldigpIGlu
c3RlYWQuCj4gCj4gQ2M6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+IENj
OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4KPiBDYzogQ2hlbi1ZdSBU
c2FpIDx3ZW5zQGNzaWUub3JnPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5k
cml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2V4dGNvbi9l
eHRjb24tYXhwMjg4LmMgfCA5ICsrKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2V4dGNvbi9l
eHRjb24tYXhwMjg4LmMgYi9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXhwMjg4LmMKPiBpbmRleCBh
OTgzNzA4Yjc3YTYuLjUwZjk0MDJmYjMyNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2V4dGNvbi9l
eHRjb24tYXhwMjg4LmMKPiArKysgYi9kcml2ZXJzL2V4dGNvbi9leHRjb24tYXhwMjg4LmMKPiBA
QCAtMzMzLDcgKzMzMyw3IEBAIHN0YXRpYyBpbnQgYXhwMjg4X2V4dGNvbl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJc3RydWN0IGF4cDI4OF9leHRjb25faW5mbyAqaW5m
bzsKPiAgCXN0cnVjdCBheHAyMHhfZGV2ICpheHAyMHggPSBkZXZfZ2V0X2RydmRhdGEocGRldi0+
ZGV2LnBhcmVudCk7Cj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+IC0JY29u
c3QgY2hhciAqbmFtZTsKPiArCXN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsKPiAgCWludCByZXQs
IGksIHBpcnE7Cj4gIAo+ICAJaW5mbyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2Yo
KmluZm8pLCBHRlBfS0VSTkVMKTsKPiBAQCAtMzU3LDkgKzM1NywxMCBAQCBzdGF0aWMgaW50IGF4
cDI4OF9leHRjb25fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCQlpZiAo
cmV0KQo+ICAJCQlyZXR1cm4gcmV0Owo+ICAKPiAtCQluYW1lID0gYWNwaV9kZXZfZ2V0X2ZpcnN0
X21hdGNoX25hbWUoIklOVDM0OTYiLCBOVUxMLCAtMSk7Cj4gLQkJaWYgKG5hbWUpIHsKPiAtCQkJ
aW5mby0+aWRfZXh0Y29uID0gZXh0Y29uX2dldF9leHRjb25fZGV2KG5hbWUpOwo+ICsJCWFkZXYg
PSBhY3BpX2Rldl9nZXRfZmlyc3RfbWF0Y2hfZGV2KCJJTlQzNDk2IiwgTlVMTCwgLTEpOwo+ICsJ
CWlmIChhZGV2KSB7Cj4gKwkJCWluZm8tPmlkX2V4dGNvbiA9IGV4dGNvbl9nZXRfZXh0Y29uX2Rl
dihhY3BpX2Rldl9uYW1lKGFkZXYpKTsKPiArCQkJcHV0X2RldmljZSgmYWRldi0+ZGV2KTsKPiAg
CQkJaWYgKCFpbmZvLT5pZF9leHRjb24pCj4gIAkJCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsKPiAg
Cj4gCgpBcHBsaWVkIGl0LiBUaGFua3MuCgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kK
U2Ftc3VuZyBFbGVjdHJvbmljcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
