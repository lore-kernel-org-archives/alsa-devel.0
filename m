From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Wed, 25 Sep 2013 13:51:39 +0100
Message-ID: <20130925125139.GJ5132@lee--X1>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
 <20130925113103.GN3226@sirena.org.uk>
 <20130925114643.GH5132@lee--X1> <20130925115502.GI5132@lee--X1>
 <20130925123536.GO3226@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ECC4261B2E
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:51:45 +0200 (CEST)
Received: by mail-ee0-f47.google.com with SMTP id d49so3127979eek.20
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 05:51:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130925123536.GO3226@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAyNSBTZXAgMjAxMywgTWFyayBCcm93biB3cm90ZToKCj4gT24gV2VkLCBTZXAgMjUs
IDIwMTMgYXQgMTI6NTU6MDJQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+IAo+ID4gaHR0cHM6
Ly9naXQubGluYXJvLm9yZy9naXR3ZWI/cD1wZW9wbGUvbGpvbmVzL21mZC5naXQgbWZkLWFzb2MK
PiAKPiBUaGFua3MsIGNvdWxkIHlvdSBpbmNsdWRlIHRoZSBmaXJzdCBwYXRjaCBhcyB3ZWxsIHBs
ZWFzZSAodGhlcmUncyBhCj4gZGVwZW5kZW5jeSBmb3IgYmlzZWN0aW9uIGR1ZSB0byB0aGUgQlVH
X09Ocyk/IAoKT2theSwgZG9uZS4gU2FtZSBicmFuY2guCgotLSAKTGVlIEpvbmVzCkxpbmFybyBT
VE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdp
dHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
