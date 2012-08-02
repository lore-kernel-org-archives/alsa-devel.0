From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 18/19] Documentation: Define the MSP Driver
 Device Tree bindings
Date: Thu, 02 Aug 2012 13:45:32 +0100
Message-ID: <501A766C.1060502@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-19-git-send-email-lee.jones@linaro.org>
 <20120731135539.GO4468@opensource.wolfsonmicro.com>
 <5017F2E2.4040100@linaro.org>
 <20120731151024.GA4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AC3265202
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 14:45:32 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1891538eek.38
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2012 05:45:35 -0700 (PDT)
In-Reply-To: <20120731151024.GA4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzEvMDcvMTIgMTY6MTAsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVHVlLCBKdWwgMzEsIDIw
MTIgYXQgMDM6NTk6NDZQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAzMS8wNy8xMiAx
NDo1NSwgTWFyayBCcm93biB3cm90ZToKPgo+Pj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOgo+Pj4+
ICsgLSBpbnRlcnJ1cHRzICAgICAgIDogVGhlIGludGVycnVwdCBvdXRwdXRzIGZyb20gdGhlIGRl
dmljZS4KPgo+Pj4gSWYgdGhlcmUncyBtb3JlIHRoYW4gb25lIGludGVycnVwdCB0aGVuIGhvdyBh
cmUgdGhleSBvcmRlcmVkPwo+Cj4+IEl0IGRvZXNuJ3QgbWF0dGVyLiBJZiB0aGVyZSBhcmUgYW55
IG1vcmUgdGhhbiBvbmUgKHdoaWNoIHRoZXJlCj4+IGFyZW4ndCBpbiB0aGlzIGNhc2UpLCB3ZSB1
c3VhbGx5IHVzZSB0aGUgaW50ZXJydXB0LW5hbWVzIHByb3BlcnR5Cj4+IHRoZW4gcmVxdWVzdCB0
aGVtIGJ5IG5hbWUgaW4gdGhlIGRyaXZlci4KPgo+IFNvIHRoZSBiaW5kaW5nIHRoZXJlZm9yZSBu
ZWVkcyB0byBzYXkgIlRoZSBpbnRlcnJ1cHQgb3V0cHV0IGZyb20gdGhlCj4gZGV2aWNlIiBhcyB0
aGVyZSdzIG9ubHkgb25lIG91dHB1dCBzdXBwb3J0ZWQuICBJZiB3ZSB3ZXJlIHVzaW5nCj4gaW50
ZXJydXB0LW5hbWVzIHRoZW4gd2UnZCBuZWVkIHRvIGRvY3VtZW50IHdoYXQgdGhlIHN1cHBvcnRl
ZCBuYW1lcyBhcmUuCgpPa2F5LCBJJ3ZlIGNoYW5nZWQgJ291dHB1dHMnIHRvICdvdXRwdXQnLgoK
LS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
