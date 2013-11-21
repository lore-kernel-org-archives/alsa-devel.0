From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] mfd: Immutable branch for ASoC
Date: Thu, 21 Nov 2013 09:07:24 +0000
Message-ID: <20131121090724.GB19368@lee--X1>
References: <1384877043-5640-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1384877043-5640-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131120091636.GA30012@lee--X1>
 <20131120102045.GW2674@sirena.org.uk>
 <20131120104526.GA30524@lee--X1>
 <20131120113400.GY2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id E74892607C8
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 10:07:32 +0100 (CET)
Received: by mail-pb0-f50.google.com with SMTP id rr13so4770589pbb.23
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 01:07:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131120113400.GY2674@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

PiBTdXJlLCBhZGQgbXkgYWNrIGFuZCBnaXZlIG1lIGEgc2lnbmVkIHRhZyB0byBwdWxsIGZyb20g
cGxlYXNlLgoKVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1ZTAxZGM3YjI2ZDlm
MjRmMzlhYmFjZTVkYTk4Y2NiZDZhNWNlYjUyOgoKICBMaW51eCAzLjEyICgyMDEzLTExLTAzIDE1
OjQxOjUxIC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6Cgog
IGdpdDovL2dpdC5saW5hcm8ub3JnL3Blb3BsZS9sam9uZXMvbWZkLmdpdCB0YWdzL2liLWFzb2Mt
MQoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDkzNDE1NjYzOWRjMDgwMmE4OTBhZWJh
NjA1N2Y3ZGU3ZGU4NGUwMmQ6CgogIEFTb0M6IHdtNTExMDogRXhwb3NlIGlucHV0IGhpZ2ggcGFz
cyBmaWx0ZXIgY29udHJvbHMgKDIwMTMtMTEtMjEgMDg6NTk6NTcgKzAwMDApCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFT
b0MgaW1tdXRhYmxlIGJyYW5jaCwgYXMgcmVxdWVzdGVkIGJ5IE1hcmsgQnJvd24uCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
Q2hhcmxlcyBLZWVwYXggKDEpOgogICAgICBBU29DOiB3bTUxMTA6IEV4cG9zZSBpbnB1dCBoaWdo
IHBhc3MgZmlsdGVyIGNvbnRyb2xzCgogZHJpdmVycy9tZmQvd201MTEwLXRhYmxlcy5jICAgICAg
ICAgICB8ICA0ICsrKysKIGluY2x1ZGUvbGludXgvbWZkL2FyaXpvbmEvcmVnaXN0ZXJzLmggfCAz
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBzb3VuZC9zb2MvY29kZWNz
L2FyaXpvbmEuYyAgICAgICAgICAgIHwgMTAgKysrKysrKysrKwogc291bmQvc29jL2NvZGVjcy9h
cml6b25hLmggICAgICAgICAgICB8ICAxICsKIHNvdW5kL3NvYy9jb2RlY3Mvd201MTEwLmMgICAg
ICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDcxIGlu
c2VydGlvbnMoKykKCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFu
ZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFS
TSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
