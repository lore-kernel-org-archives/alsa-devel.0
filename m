From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 01/18] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Thu, 13 Jul 2017 09:02:10 +0100
Message-ID: <20170713080210.lbsjnmlciovoxe4g@dell>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0FB2671E7
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 10:02:13 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id w126so15419147wme.0
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 01:02:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1493050124-5970-2-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyNCBBcHIgMjAxNywgUmljaGFyZCBGaXR6Z2VyYWxkIHdyb3RlOgoKPiBUaGlzIHBh
dGNoIGFkZHMgYSBoZWFkZXIgZmlsZSBvZiByZWdpc3RlciBkZWZpbml0aW9ucyBmb3IgQ2lycnVz
Cj4gTG9naWMgIk1hZGVyYSIgY2xhc3MgY29kZWNzLiBUaGVzZSBjb2RlY3MgYXJlIGFsbCBiYXNl
ZCBvZmYgYSBjb21tb24KPiBzZXQgb2YgaGFyZHdhcmUgSVAgc28gaGF2ZSBhIGNvbW1vbiByZWdp
c3RlciBtYXAgKHdpdGggYSBmZXcgbWlub3IKPiBkZXZpY2UtdG8tZGV2aWNlIHZhcmlhdGlvbnMp
LiBUaGVzZSBhcmUgY29tcGxleCBkZXZpY2VzIHdpdGggYSBsYXJnZQo+IG51bWJlciBvZiBmZWF0
dXJlcyBhbmQgc28gaGF2ZSBhIGNvcnJlc3BvbmRpbmdseSBsYXJnZSByZWdpc3RlciBzZXQuCj4g
VGhlIHJlZ2lzdGVycy5oIGZpbGUgaGFzIGJlZW4gYXV0by1nZW5lcmF0ZWQgZnJvbSB0aGUgaGFy
ZHdhcmUgcmVnaXN0ZXIKPiBkZWZpbml0aW9ucywgc3RyaXBwZWQgZG93biB0byBvbmx5IHJlZ2lz
dGVycyB3ZSBuZWVkIHRvIGFjY2VzcyBmcm9tCj4gdGhlIGRyaXZlci4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBSaWNoYXJkIEZpdHpnZXJhbGQgPHJmQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4K
PiAtLS0KPiAKPiBObyBjaGFuZ2VzIHNpbmNlIFYxLgo+IAo+ICBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEwICsKPiAgaW5jbHVkZS9saW51eC9tZmQvbWFkZXJhL3Jl
Z2lzdGVycy5oIHwgODgzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgODg0MiBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2xpbnV4L21mZC9tYWRlcmEvcmVnaXN0ZXJzLmgKClRoaXMgcGF0Y2ggaGFzIGJlZW4g
cmVqZWN0ZWQgYnkgTGludXMuCgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy83LzcvNTc5Cgot
LSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
