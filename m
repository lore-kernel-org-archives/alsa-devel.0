From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Thu, 12 Apr 2018 22:15:41 +0800
Message-ID: <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de> <20180412105909.tbyfcjm55sb47hiq@pali>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C46266BBC
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 16:15:48 +0200 (CEST)
Received: from mail-pl0-f70.google.com ([209.85.160.70])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1f6d0u-0006bj-2z
 for alsa-devel@alsa-project.org; Thu, 12 Apr 2018 14:15:48 +0000
Received: by mail-pl0-f70.google.com with SMTP id 91-v6so3871872pla.18
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 07:15:48 -0700 (PDT)
In-Reply-To: <20180412105909.tbyfcjm55sb47hiq@pali>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

YXQgNjo1OSBQTSwgUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPiB3cm90ZToKCj4g
T24gVGh1cnNkYXkgMTIgQXByaWwgMjAxOCAxMjo1MDowMiBUYWthc2hpIEl3YWkgd3JvdGU6Cj4+
PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0RFTExfTEFQVE9QKQo+Pj4gK3N0YXRpYyBib29sIGNo
ZWNrX2RlbGxfc3dpdGNoYWJsZV9nZngoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+PiArewo+Pj4g
Kwlib29sICgqZGVsbF9zd2l0Y2hhYmxlX2dmeF9pc19lbmFibGVkX2Z1bmMpKHZvaWQpOwo+Pj4g
Kwlib29sIGVuYWJsZWQ7Cj4+PiArCj4+PiArCS8qIE9ubHkgbmVlZCB0byBjaGVjayBmb3IgRGVs
bCBsYXB0b3BzIGFuZCBBSU9zICovCj4+PiArCWlmICghZG1pX2ZpbmRfZGV2aWNlKERNSV9ERVZf
VFlQRV9PRU1fU1RSSU5HLCAiRGVsbCBTeXN0ZW0iLCBOVUxMKSB8fAo+Pj4gKwkgICAgIShkbWlf
bWF0Y2goRE1JX0NIQVNTSVNfVFlQRSwgIjEwIikgfHwKPj4+ICsJICAgICAgZG1pX21hdGNoKERN
SV9DSEFTU0lTX1RZUEUsICIxMyIpKSB8fAo+Pj4gKwkgICAgIShwZGV2LT52ZW5kb3IgPT0gUENJ
X1ZFTkRPUl9JRF9BVEkgfHwKPj4+ICsJICAgICAgcGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1Jf
SURfTlZJRElBKSkKPj4+ICsJCXJldHVybiBmYWxzZTsKPiAuLi4KPj4+IEBAIC0xNzExLDYgKzE3
NDUsMTEgQEAgc3RhdGljIGludCBhenhfY3JlYXRlKHN0cnVjdCBzbmRfY2FyZCAqY2FyZCwgIAo+
Pj4gc3RydWN0IHBjaV9kZXYgKnBjaSwKPj4+ICAJaWYgKGVyciA8IDApCj4+PiAgCQlyZXR1cm4g
ZXJyOwo+Pj4KPj4+ICsJaWYgKGNoZWNrX2RlbGxfc3dpdGNoYWJsZV9nZngocGNpKSkgewo+Pj4g
KwkJcGNpX2Rpc2FibGVfZGV2aWNlKHBjaSk7Cj4KPiBIaSEKPgo+IE5vdyBsb29raW5nIGF0IGl0
IGFnYWluLi4uIFRoaXMgY29kZSBkaXNhYmxlcyBhbGwgQVRJIGFuZCBOVklESUEgc291bmQKPiBj
YXJkcyBhdmFpbGFibGUgaW4gYW55IERlbGwgU3lzdGVtIChsYXB0b3Agb3IgQUlPKSBpZiBzeXN0
ZW0gc2F5cyB0aGF0Cj4gU0cgaXMgZW5hYmxlZCwgcmlnaHQ/CgpZZXMuCgo+Cj4gSXQgbWVhbnMg
dGhhdCBhbHNvIGFueSBleHRlcm5hbCBBVEkgb3IgTlZJRElBIFBDSSBjYXJkIHdpdGggYXVkaW8g
ZGV2aWNlCj4gY29ubmVjdGVkIHRvIFRodW5kZXJib2x0IChlLmcuIHZpYSBQQ0kgPC0tPiBUQiBi
cmlkZ2UpIGlzIGFsd2F5cwo+IHVuY29uZGl0aW9uYWxseSBkaXNhYmxlZCB0b28/CgpJIG5ldmVy
IHRob3VnaHQgb2YgdGhpcyBjYXNlLCB0aGFua3MgZm9yIGJyaW5naW5nIHRoaXMgdXAuCkRvIHlv
dSBoYXZlIGFueSBzdWdnZXN0aW9uIHRvIGNoZWNrIGlmIGl0IGNvbm5lY3RzIHRvIHRoZSBzeXN0
ZW0gdmlhICAKVGh1bmRlcmJvbHQ/CgpLYWktSGVuZwoKPgo+Pj4gKwkJcmV0dXJuIC1FTk9ERVY7
Cj4+PiArCX0KPgo+IC0tIAo+IFBhbGkgUm9ow6FyCj4gcGFsaS5yb2hhckBnbWFpbC5jb20KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
