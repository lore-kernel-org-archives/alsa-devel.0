From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Thu, 12 Apr 2018 12:59:09 +0200
Message-ID: <20180412105909.tbyfcjm55sb47hiq@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 84AE8266E30
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 12:59:11 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id c24so4673682wrc.6
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 03:59:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hr2nk8zs5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1cnNkYXkgMTIgQXByaWwgMjAxOCAxMjo1MDowMiBUYWthc2hpIEl3YWkgd3JvdGU6Cj4g
PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0RFTExfTEFQVE9QKQo+ID4gK3N0YXRpYyBib29sIGNo
ZWNrX2RlbGxfc3dpdGNoYWJsZV9nZngoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gPiArewo+ID4g
Kwlib29sICgqZGVsbF9zd2l0Y2hhYmxlX2dmeF9pc19lbmFibGVkX2Z1bmMpKHZvaWQpOwo+ID4g
Kwlib29sIGVuYWJsZWQ7Cj4gPiArCj4gPiArCS8qIE9ubHkgbmVlZCB0byBjaGVjayBmb3IgRGVs
bCBsYXB0b3BzIGFuZCBBSU9zICovCj4gPiArCWlmICghZG1pX2ZpbmRfZGV2aWNlKERNSV9ERVZf
VFlQRV9PRU1fU1RSSU5HLCAiRGVsbCBTeXN0ZW0iLCBOVUxMKSB8fAo+ID4gKwkgICAgIShkbWlf
bWF0Y2goRE1JX0NIQVNTSVNfVFlQRSwgIjEwIikgfHwKPiA+ICsJICAgICAgZG1pX21hdGNoKERN
SV9DSEFTU0lTX1RZUEUsICIxMyIpKSB8fAo+ID4gKwkgICAgIShwZGV2LT52ZW5kb3IgPT0gUENJ
X1ZFTkRPUl9JRF9BVEkgfHwKPiA+ICsJICAgICAgcGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1Jf
SURfTlZJRElBKSkKPiA+ICsJCXJldHVybiBmYWxzZTsKLi4uCj4gPiBAQCAtMTcxMSw2ICsxNzQ1
LDExIEBAIHN0YXRpYyBpbnQgYXp4X2NyZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQsIHN0cnVj
dCBwY2lfZGV2ICpwY2ksCj4gPiAgCWlmIChlcnIgPCAwKQo+ID4gIAkJcmV0dXJuIGVycjsKPiA+
ICAKPiA+ICsJaWYgKGNoZWNrX2RlbGxfc3dpdGNoYWJsZV9nZngocGNpKSkgewo+ID4gKwkJcGNp
X2Rpc2FibGVfZGV2aWNlKHBjaSk7CgpIaSEKCk5vdyBsb29raW5nIGF0IGl0IGFnYWluLi4uIFRo
aXMgY29kZSBkaXNhYmxlcyBhbGwgQVRJIGFuZCBOVklESUEgc291bmQKY2FyZHMgYXZhaWxhYmxl
IGluIGFueSBEZWxsIFN5c3RlbSAobGFwdG9wIG9yIEFJTykgaWYgc3lzdGVtIHNheXMgdGhhdApT
RyBpcyBlbmFibGVkLCByaWdodD8KCkl0IG1lYW5zIHRoYXQgYWxzbyBhbnkgZXh0ZXJuYWwgQVRJ
IG9yIE5WSURJQSBQQ0kgY2FyZCB3aXRoIGF1ZGlvIGRldmljZQpjb25uZWN0ZWQgdG8gVGh1bmRl
cmJvbHQgKGUuZy4gdmlhIFBDSSA8LS0+IFRCIGJyaWRnZSkgaXMgYWx3YXlzCnVuY29uZGl0aW9u
YWxseSBkaXNhYmxlZCB0b28/Cgo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gPiArCX0KCi0tIApQ
YWxpIFJvaMOhcgpwYWxpLnJvaGFyQGdtYWlsLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
