From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/18] Documentation: Describe the ux500
 realated audio related DT nodes
Date: Mon, 30 Jul 2012 08:38:49 +0100
Message-ID: <50163A09.8060203@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CCF626526D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 09:38:54 +0200 (CEST)
Received: by eeke50 with SMTP id e50so924352eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 00:38:56 -0700 (PDT)
In-Reply-To: <20120729203106.GD4384@opensource.wolfsonmicro.com>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjkvMDcvMTIgMjE6MzEsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMjcsIDIw
MTIgYXQgMDE6NDU6NDVQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+Cj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC91eDUwMC50eHQKPj4gQEAgLTAsMCAr
MSw2MiBAQAo+PiArKiB1eDUwMCBBdWRpbyBEcml2ZXIgYW5kIGFiODUwMCBBdWRpbyBDT0RFQwo+
PiArCj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+PiArIC0gY29tcGF0aWJsZToKPj4gKyAgIC0g
TWFjaGluZSBEcml2ZXIgOiAic3Rlcmljc3NvbixzbmQtc29jLW1vcDUwMCIKPj4gKyAgIC0gQ1BV
LXNpZGUgREFJICAgOiAic3Rlcmljc3Nvbix1eDUwMC1tc3AtaTJzIgo+PiArICAgLSBETUEgKHBs
YXRmb3JtKSA6ICJzdGVyaWNzc29uLHV4NTAwLXBjbSIKPj4gKyAgIC0gQXVkaW8gQ09ERUMgICAg
OiAic3Rlcmljc3NvbixhYjg1MDAtY29kZWMiCj4KPiBXaGF0IGlzIHRoaXMgYSBiaW5kaW5nIGRv
Y3VtZW50IGZvcj8gIEl0IGxvb2tzIGxpa2UgdGhlIGJpbmRpbmcgZm9yIGEKPiBtYWNoaW5lIGRy
aXZlci4uLgoKTm8sIGl0J3MgYSBiaW5kaW5nIGRvY3VtZW50IGZvciBhbGwgb2YgdGhlIHV4NTAw
IGRyaXZlciBhbmQgQ09ERUMgCmJsb2Nrcy4gRG8geW91IHJlYWxseSB3YW50IG1lIHRvIHNwbGl0
IGl0IGFsbCB1cD8gSSB0aGluayB0aGUgb25seSAKY29tcG9uZW50IHdoaWNoIGNvdWxkIGJlIHNh
bmVseSBzcGxpdC1vdXQgaXMgdGhlIGFiODUwMC1jb2RlYywgd2hpY2ggCmNvdWxkIChzaG91bGQ/
KSBsaXZlIGluIFsxXS4KCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOgo+PiArIC0gcmVnICAgICAg
ICAgICAgICA6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBkZXZpY2Un
cyByZWdpc3RlcnMuCj4+ICsgLSBpbnRlcnJ1cHRzICAgICAgIDogVGhlIGludGVycnVwdCBvdXRw
dXRzIGZyb20gdGhlIGRldmljZS4KPj4gKyAtIGludGVycnVwdC1wYXJlbnQgOiBUaGUgcGFyZW50
IGludGVycnVwdCBjb250cm9sbGVyLgo+PiArIC0gPG5hbWU+LXN1cHBseSAgICA6IFBoYW5kbGUg
dG8gdGhlIHJlZ3VsYXRvciA8bmFtZT4gc3VwcGx5Cj4KPiAuLi5idXQgdGhlc2UgZG9uJ3QgbG9v
ayBhbnl0aGluZyBsaWtlIG1hY2hpbmUgZHJpdmVyIHByb3BlcnRpZXMuCgpUaGVzZSBwcm9wZXJ0
aWVzIGFyZSByZWxldmFudCBmb3Igc29tZSwgYnV0IG5vdCBhbGwgb2YgdGhlIGNvbXBvbmVudHMg
CmFib3ZlLCBoZW5jZSB3aHkgdGhlIGFyZSBsaXN0ZWQgYXQgJ29wdGlvbmFsIHByb3BlcnRpZXMn
LgoKWzFdIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYWI4NTAwLgoKLS0g
CkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9y
ZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZh
Y2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
