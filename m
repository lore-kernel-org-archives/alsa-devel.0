From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/5] ALSA: hda: Add api to program
 stripe control bits
Date: Mon, 14 Jan 2019 11:28:43 -0600
Message-ID: <3c0d78dc-44a2-bf72-257b-e89cd309288d@linux.intel.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
 <1547227328-32558-3-git-send-email-spujar@nvidia.com>
 <13164ff6-1ea0-9e28-b3b2-a590949a7200@linux.intel.com>
 <99e9230d-9e23-d79d-005f-9396f7d219c1@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F38822667E7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 18:28:51 +0100 (CET)
In-Reply-To: <99e9230d-9e23-d79d-005f-9396f7d219c1@nvidia.com>
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
To: Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4+PiArwqDCoMKgIC8qIGZvbGxvd2luZyBpcyBmcm9tIEhEIGF1ZGlvIHNwZWMgKi8KPj4+ICvC
oMKgwqAgZm9yIChzZG9fbGluZSA9IG1heF9zZG9fbGluZXM7IHNkb19saW5lID4gMDsgc2RvX2xp
bmUgPj49IDEpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmF0ZSA+IDQ4MDAwKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsdWUgPSAoY2hhbm5lbHMgKiBiaXRzX3Blcl9zYW1wbGUg
Kgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChyYXRlIC8gNDgw
MDApKSAvIHNkb19saW5lOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHZhbHVlID0gY2hhbm5lbHMgKiBiaXRzX3Blcl9zYW1wbGUgLyBzZG9fbGlu
ZTsKPj4gKGNoYW5uZWxzICogYml0X3Blcl9zYW1wbGUpIC8gc2RvX2xpbmUgYXMgaW4gdGhlIHNw
ZWM/Cj4KPiBUaG91Z2ggSSBoYXZlIG5vdCB1c2VkIGV4cGxpY2l0IGJyYWNlcywgYnV0IGFzIHBl
ciBvcGVyYXRvciBwcmVjZWRlbmNlIAo+IGl0IHdpbGwgYmUgdHJlYXRlZCB0aGUgc2FtZSB3YXkg
YXMgaXQgaXMgbWVudGlvbmVkIGluIHNwZWMuCj4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgdGhp
cyB0byBiZSBleHBsaWNpdGx5IG1lbnRpb25lZC4KCklmIHlvdSBpbXBsZW1lbnQgYSBzcGVjIGl0
J3MgYmV0dGVyIHRvIGVpdGhlciBmb2xsb3cgaXQgdmVyYmF0aW0gb3IgYWRkIAphIGNvbW1lbnQg
d2hlbiB5b3Ugb3B0aW1pemUgcGFydHMgYXdheSwgdGhhdCB3YXkgcmV2aWV3ZXJzIHVuZGVyc3Rh
bmQgCnlvdXIgaW50ZW50IHdpdGhvdXQgaGF2aW5nIHRvIHJlZmVyIHRvIGVtYWlsIGFyY2hpdmVz
LiBpZiB5b3Ugd2FudCB0byAKcmVzZW5kIGEgdjMgcGxlYXNlIGFkZCBteSB0YWcgZm9yIHRoZSBz
ZXJpZXM6CgpSZXZpZXdlZC1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5i
b3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KClRoYW5rcyEKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
