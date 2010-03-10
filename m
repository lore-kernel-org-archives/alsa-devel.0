From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 19/20] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Wed, 10 Mar 2010 21:57:01 +0900
Message-ID: <1b68c6791003100457r83b0fecyf79d3e571ae7265a@mail.gmail.com>
References: <1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-12-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-13-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-14-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-15-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-16-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-17-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-18-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-19-git-send-email-jassi.brar@samsung.com>
	<20100310113922.GJ24422@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f192.google.com (mail-qy0-f192.google.com
	[209.85.221.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F3CD103903
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:57:03 +0100 (CET)
Received: by qyk30 with SMTP id 30so8026814qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 04:57:02 -0800 (PST)
In-Reply-To: <20100310113922.GJ24422@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgMTAsIDIwMTAgYXQgODozOSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTWFyIDEwLCAyMDEwIGF0
IDA0OjQ5OjA4UE0gKzA5MDAsIEphc3NpIEJyYXIgd3JvdGU6Cj4KPj4gK3N0YXRpYyBpbnQgczNj
NjR4eF9pMnN2NF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHNuZF9zb2NfZGFpICpkYWkp
Cj4+ICt7Cj4+ICsgwqAgwqAgLyogY29uZmlndXJlIEdQSU8gZm9yIGkycyBwb3J0ICovCj4+ICsg
wqAgwqAgczNjX2dwaW9fY2ZncGluKFMzQzY0WFhfR1BDKDQpLCBTM0M2NFhYX0dQQzRfSTJTX1Y0
MF9ETzApOwo+PiArIMKgIMKgIHMzY19ncGlvX2NmZ3BpbihTM0M2NFhYX0dQQyg1KSwgUzNDNjRY
WF9HUEM1X0kyU19WNDBfRE8xKTsKPj4gKyDCoCDCoCBzM2NfZ3Bpb19jZmdwaW4oUzNDNjRYWF9H
UEMoNyksIFMzQzY0WFhfR1BDN19JMlNfVjQwX0RPMik7Cj4+ICsgwqAgwqAgczNjX2dwaW9fY2Zn
cGluKFMzQzY0WFhfR1BIKDYpLCBTM0M2NFhYX0dQSDZfSTJTX1Y0MF9CQ0xLKTsKPj4gKyDCoCDC
oCBzM2NfZ3Bpb19jZmdwaW4oUzNDNjRYWF9HUEgoNyksIFMzQzY0WFhfR1BIN19JMlNfVjQwX0NE
Q0xLKTsKPj4gKyDCoCDCoCBzM2NfZ3Bpb19jZmdwaW4oUzNDNjRYWF9HUEgoOCksIFMzQzY0WFhf
R1BIOF9JMlNfVjQwX0xSQ0xLKTsKPj4gKyDCoCDCoCBzM2NfZ3Bpb19jZmdwaW4oUzNDNjRYWF9H
UEgoOSksIFMzQzY0WFhfR1BIOV9JMlNfVjQwX0RJKTsKPgo+IEl0IHNlZW1zIHJldHJvZ3JhZGUg
dG8gYWRkIHRoaXMgcmF0aGVyIHRoYW4gdXNpbmcgdGhlIHBsYXRmb3JtIGRhdGEKPiBjYWxsYmFj
ayB0aGF0IHlvdSBhZGRlZC4gwqBXZSdsbCBuZWVkIHNvbWUgYXJjaC9hcm0gY2hhbmdlcyBmb3Ig
dGhlCj4gZHJpdmVyIHRvIHByb2JlIGFueXdheSBzbyBpdCd0IG5vdCBhIGJpZyBkZWFsIHRvIGFk
ZCB0aGUgZGVwZW5kZW5jeS4KSSBrbm93LCBidXQgdGhhdCB3YXkgSSB3b3VsZCBoYXZlIGhhZCB0
byB3YWl0IG9uIFMzQyBBUkNIIHRyZWUgcmVmbGVjdAp0aGUgcGF0Y2goZm9yIHdoaWNoIHMzYzY0
eHgtaTJzLmMgZGVwZW5kcyBhbHJlYWR5KS4KV2hlbiBteSBsYXRlc3QgQVJDSCBwYXRjaGVzIGFy
ZSB2aXNpYmxlIGluIHlvdXIgdHJlZSwgd2UgY2FuIGVhc2lseSBzd2l0Y2gKdG8gdXNpbmcgY2Zn
X2dwaW8gaW4gYm90aCB0aGUgZHJpdmVycy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
