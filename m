From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/12] ALSA: hdac: fix memory release for SST
	and SOF drivers
Date: Sat, 18 May 2019 15:27:03 -0500
Message-ID: <20190518202704.7772-12-pierre-louis.bossart@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51920F806E7
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 22:27:31 +0200 (CEST)
In-Reply-To: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

RnJvbTogQW1hZGV1c3ogU8WCYXdpxYRza2kgPGFtYWRldXN6eC5zbGF3aW5za2lAbGludXguaW50
ZWwuY29tPgoKRHVyaW5nIHRoZSBpbnRlZ3JhdGlvbiBvZiBIRGF1ZGlvIHN1cHBvcnQsIHdlIGNo
YW5nZWQgdGhlIHdheSBpbiB3aGljaAp3ZSBnZXQgaGRldiBpbiBzbmRfaGRhY19leHRfYnVzX2Rl
dmljZV9pbml0KCkgdG8gdXNlIG9uZSBwcmVhbGxvY2F0ZWQKd2l0aCBkZXZtX2t6YWxsb2MoKSwg
aG93ZXZlciBpdCBzdGlsbCBsZWZ0IGtmcmVlKGhkZXYpIGluCnNuZF9oZGFjX2V4dF9idXNfZGV2
aWNlX2V4aXQoKS4gSXQgbGVhZHMgdG8gb29wc2VzIHdoZW4gdHJ5aW5nIHRvCnJtbW9kIGFuZCBt
b2Rwcm9iZS4gRml4IGl0LCBieSBqdXN0IHJlbW92aW5nIGtmcmVlIGNhbGwuCgpTT0YgYWxzbyB1
c2VzIHNvbWUgb2YgdGhlIHNuZF9oZGFjXyBmdW5jdGlvbnMgZm9yIEhEQXVkaW8gc3VwcG9ydCBi
dXQKYWxsb2NhdGVkIHRoZSBtZW1vcnkgd2l0aCBremFsbG9jLiBBIG1hdGNoaW5nIGZpeCBpcyBw
cm92aWRlZApzZXBhcmF0ZWx5IHRvIGFsaWduIGFsbCB1c2VycyBvZiB0aGUgc25kX2hkYWNfIGxp
YnJhcnkuCgpGaXhlczogNjI5ODU0MmZhMzNiICgiQUxTQTogaGRhYzogcmVtb3ZlIG1lbW9yeSBh
bGxvY2F0aW9uIGZyb20gc25kX2hkYWNfZXh0X2J1c19kZXZpY2VfaW5pdCIpClNpZ25lZC1vZmYt
Ynk6IEFtYWRldXN6IFPFgmF3acWEc2tpIDxhbWFkZXVzenguc2xhd2luc2tpQGxpbnV4LmludGVs
LmNvbT4KU2lnbmVkLW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5i
b3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KLS0tCiBzb3VuZC9oZGEvZXh0L2hkYWNfZXh0X2J1cy5j
IHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L2hkYS9leHQvaGRhY19leHRfYnVzLmMgYi9zb3VuZC9oZGEvZXh0L2hkYWNfZXh0X2J1cy5jCmlu
ZGV4IGVjNzcxNWM2YjBjMC4uYzE0N2ViZTU0MmRhIDEwMDY0NAotLS0gYS9zb3VuZC9oZGEvZXh0
L2hkYWNfZXh0X2J1cy5jCisrKyBiL3NvdW5kL2hkYS9leHQvaGRhY19leHRfYnVzLmMKQEAgLTE3
Miw3ICsxNzIsNiBAQCBFWFBPUlRfU1lNQk9MX0dQTChzbmRfaGRhY19leHRfYnVzX2RldmljZV9p
bml0KTsKIHZvaWQgc25kX2hkYWNfZXh0X2J1c19kZXZpY2VfZXhpdChzdHJ1Y3QgaGRhY19kZXZp
Y2UgKmhkZXYpCiB7CiAJc25kX2hkYWNfZGV2aWNlX2V4aXQoaGRldik7Ci0Ja2ZyZWUoaGRldik7
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChzbmRfaGRhY19leHRfYnVzX2RldmljZV9leGl0KTsKIAot
LSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
