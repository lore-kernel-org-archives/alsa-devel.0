From: "Rajwa, Marcin" <marcin.rajwa@linux.intel.com>
Subject: [PATCH v4 1/2] ASoC: SOF: introduce no_stream_position
 so host_period_bytes preserves its data
Date: Tue, 30 Jul 2019 12:16:22 +0200
Message-ID: <9d92551a-fa10-4ecd-47f1-5b3b67824a12@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 159CBF80214
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 12:16:26 +0200 (CEST)
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
To: marcin.rajwa@intel.com, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

RnJvbTogTWFyY2luIFJhandhIDxtYXJjaW4ucmFqd2FAbGludXguaW50ZWwuY29tPgoKQ2hhbmdl
IHRoZSB1c2Ugb2YgaG9zdF9wZXJpb2RfYnl0ZXMuIFNvIGZhciB0aGlzIGZpZWxkIHdhcyB1c2Vk
CmFzIGFuIGJvb2wgdmFsdWUgaW5kaWNhdGluZyB3aGV0aGVyIEZXIHNob3VsZCBzZW5kIHN0cmVh
bSBwb3NpdGlvbgp1cGRhdGUuIFdpdGggdGhpcyBwYXRjaCB3ZSB1c2UgaG9zdF9wZXJpb2RfYnl0
ZXMgdG8gcHJvdmlkZSBmaXJtd2FyZQppbmZvcm1hdGlvbiBhYm91dCB0aGUgZnJlcXVlbmN5IG9m
IGhvc3QgaW50ZXJydXB0cyBhaW1lZCB0byByZWFkCml0cyBpbnB1dCBidWZmZXIuIFRoaXMgaXMg
YWNjb3JpbmcgdG8gQUxTQSBkZWZpbml0aW9uIG9mICdGcmFtZVBlcmlvZCcuCktub3dpbmcgdGhp
cyBmaXJtd2FyZSBjYW4gc2FmZWx5IGNvcHkgbGFyZ2UvaXJyZWd1bGFyIGNodW5rcyBvZiBkYXRh
CihsaWtlIGRhdGEgY29tbWluZyBmcm9tIGkuZSBkcmFpbmluZyB0YXNrKSB3aXRob3V0IHRoZSBy
aXNrIG9mIGJ1ZmZlcgpvdmVyZmxvdy4KClNpZ25lZC1vZmYtYnk6IE1hcmNpbiBSYWp3YSA8bWFy
Y2luLnJhandhQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogS2V5b24gSmllIDx5YW5n
LmppZUBsaW51eC5pbnRlbC5jb20+ClJldmlld2VkLWJ5OiBSYW5qYW5pIFNyaWRoYXJhbiA8cmFu
amFuaS5zcmlkaGFyYW5AbGludXguaW50ZWwuY29tPgoKLS0tCiDCoGluY2x1ZGUvc291bmQvc29m
L3N0cmVhbS5oIHwgNCArKy0tCiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb3VuZC9zb2Yvc3RyZWFtLmggYi9p
bmNsdWRlL3NvdW5kL3NvZi9zdHJlYW0uaAppbmRleCA2NDNmMTc1Y2I0NzkuLjA2YWY0ZWNiMjU4
NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zb3VuZC9zb2Yvc3RyZWFtLmgKKysrIGIvaW5jbHVkZS9z
b3VuZC9zb2Yvc3RyZWFtLmgKQEAgLTgzLDEwICs4MywxMCBAQCBzdHJ1Y3Qgc29mX2lwY19zdHJl
YW1fcGFyYW1zIHsKIMKgwqDCoMKgIHVpbnQxNl90IHNhbXBsZV92YWxpZF9ieXRlczsKIMKgwqDC
oMKgIHVpbnQxNl90IHNhbXBsZV9jb250YWluZXJfYnl0ZXM7CgotwqDCoMKgIC8qIGZvciBub3Rp
ZnlpbmcgaG9zdCBwZXJpb2QgaGFzIGNvbXBsZXRlZCAtIDAgbWVhbnMgbm8gcGVyaW9kIElSUSAq
LwogwqDCoMKgwqAgdWludDMyX3QgaG9zdF9wZXJpb2RfYnl0ZXM7CivCoMKgwqAgdWludDE2X3Qg
bm9fc3RyZWFtX3Bvc2l0aW9uOyAvKiAxIG1lYW5zIG5vIElQQyBmb3IgcG9zaXRpb24gdXBkYXRl
ICovCgotwqDCoMKgIHVpbnQzMl90IHJlc2VydmVkWzJdOworwqDCoMKgIHVpbnQxNl90IHJlc2Vy
dmVkWzNdOwogwqDCoMKgwqAgdWludDE2X3QgY2htYXBbU09GX0lQQ19NQVhfQ0hBTk5FTFNdO8Kg
wqDCoCAvKio8IGNoYW5uZWwgbWFwIC0gClNPRl9DSE1BUF8gKi8KIMKgfSBfX3BhY2tlZDsKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
