From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/10] ASoC: Intel: Add ACPI match table
 entry for ES8316 codec on BYTCR platform
Date: Thu, 3 Jan 2019 17:45:33 +0100
Message-ID: <2b2c82ed-dd0b-e3c5-a790-f5bc991acf81@redhat.com>
References: <20190103134535.13861-1-hdegoede@redhat.com>
 <20190103134535.13861-11-hdegoede@redhat.com>
 <ba03ffe0-abe6-84c2-dcc9-a788aceb0006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 88629267C07
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 17:45:35 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id c14so34219002wrr.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2019 08:45:35 -0800 (PST)
In-Reply-To: <ba03ffe0-abe6-84c2-dcc9-a788aceb0006@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAwMy0wMS0xOSAxNzo0MywgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4g
T24gMS8zLzE5IDc6NDUgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4+IFNvbWUgQllUQ1IgZGV2
aWNlcyB1c2UgYW4gRVM4MzE2IGNvZGVjLCBhZGQgYW4gQUNQSSBtYXRjaCB0YWJsZSBlbnRyeQo+
PiBmb3IgdGhpcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVA
cmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIHNvdW5kL3NvYy9pbnRlbC9jb21tb24vc29jLWFjcGkt
aW50ZWwtYnl0LW1hdGNoLmMgfCA5ICsrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3Nv
Yy1hY3BpLWludGVsLWJ5dC1tYXRjaC5jIGIvc291bmQvc29jL2ludGVsL2NvbW1vbi9zb2MtYWNw
aS1pbnRlbC1ieXQtbWF0Y2guYwo+PiBpbmRleCAwMjdkYzI3MjYyYjcuLjk2ZjljNTUzZmU2YyAx
MDA2NDQKPj4gLS0tIGEvc291bmQvc29jL2ludGVsL2NvbW1vbi9zb2MtYWNwaS1pbnRlbC1ieXQt
bWF0Y2guYwo+PiArKysgYi9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NvYy1hY3BpLWludGVsLWJ5
dC1tYXRjaC5jCj4+IEBAIC0xODUsNiArMTg1LDE1IEBAIHN0cnVjdCBzbmRfc29jX2FjcGlfbWFj
aMKgIHNuZF9zb2NfYWNwaV9pbnRlbF9iYXl0cmFpbF9tYWNoaW5lc1tdID0gewo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgLnNvZl90cGxnX2ZpbGVuYW1lID0gImludGVsL3NvZi1ieXQtZGE3MjEzLnRw
bGciLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmFzb2NfcGxhdF9uYW1lID0gInNzdC1tZmxkLXBs
YXRmb3JtIiwKPj4gwqDCoMKgwqDCoCB9LAo+PiArwqDCoMKgIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IC5pZCA9ICJFU1NYODMxNiIsCj4+ICvCoMKgwqDCoMKgwqDCoCAuZHJ2X25hbWUgPSAiYnl0Y2h0
X2VzODMxNiIsCj4+ICvCoMKgwqDCoMKgwqDCoCAuZndfZmlsZW5hbWUgPSAiaW50ZWwvZndfc3N0
XzBmMjguYmluIiwKPj4gK8KgwqDCoMKgwqDCoMKgIC5ib2FyZCA9ICJieXRjaHRfZXM4MzE2IiwK
PiAKPiBDb21pbmcgZnJvbSB0aGUgaG9saWRheSBicmVhayBJIHNhdyB0aGlzIC5ib2FyZCBmaWVs
ZCBhbmQgY291bGRuJ3QgcmVjYWxsIHdoeSB3ZSBuZWVkZWQgaXQuIE5vbmUgb2YgdGhlIG1vcmUg
cmVjZW50IGJvYXJkcyBzZXQgdGhpcyBmaWVsZC4gSXMgdGhpcyBsZWdhY3kgc3R1ZmYgdGhhdCBp
c24ndCB1c2VkIGJ5IGFueW9uZT8KCkkgd291bGQgZXhwZWN0IHlvdSB0byBrbm93IHRoYXQgYmV0
dGVyIHRoZW4gSSBkbyA6KSAgSSBqdXN0IGNvcGllZCB0aGlzIGZyb20gdGhlCm90aGVyIGVudHJp
ZXMuCgpJZiB5b3Ugd2FudCB0byBzdWJtaXQgYSBwYXRjaCByZW1vdmluZyB0aGUgLmJvYXJkIGVu
dHJpZXMgSSdtIGFsbCBmb3IgaXQuCgpSZWdhcmRzLAoKSGFucwoKCgo+IAo+IAo+PiArwqDCoMKg
wqDCoMKgwqAgLnNvZl9md19maWxlbmFtZSA9ICJpbnRlbC9zb2YtYnl0LnJpIiwKPj4gK8KgwqDC
oMKgwqDCoMKgIC5zb2ZfdHBsZ19maWxlbmFtZSA9ICJpbnRlbC9zb2YtYnl0LWVzODMxNi50cGxn
IiwKPj4gK8KgwqDCoMKgwqDCoMKgIC5hc29jX3BsYXRfbmFtZSA9ICJzc3QtbWZsZC1wbGF0Zm9y
bSIsCj4+ICvCoMKgwqAgfSwKPj4gwqDCoMKgwqDCoCAvKiBzb21lIEJheXRyYWlsIHBsYXRmb3Jt
cyByZWx5IG9uIFJUNTY0NSwgdXNlIENIVCBtYWNoaW5lIGRyaXZlciAqLwo+PiDCoMKgwqDCoMKg
IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5pZCA9ICIxMEVDNTY0NSIsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
