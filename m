From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/18] Documentation: Describe the ux500
 realated audio related DT nodes
Date: Mon, 30 Jul 2012 15:32:08 +0100
Message-ID: <50169AE8.4020601@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
 <50163A09.8060203@linaro.org>
 <20120730134804.GE4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A1ED5265338
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 16:32:08 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1055652eek.38
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 07:32:10 -0700 (PDT)
In-Reply-To: <20120730134804.GE4468@opensource.wolfsonmicro.com>
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

T24gMzAvMDcvMTIgMTQ6NDgsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMzAsIDIw
MTIgYXQgMDg6Mzg6NDlBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAyOS8wNy8xMiAy
MTozMSwgTWFyayBCcm93biB3cm90ZToKPj4+IE9uIEZyaSwgSnVsIDI3LCAyMDEyIGF0IDAxOjQ1
OjQ1UE0gKzAxMDAsIExlZSBKb25lcyB3cm90ZToKPgo+Pj4+ICsgICAtIE1hY2hpbmUgRHJpdmVy
IDogInN0ZXJpY3Nzb24sc25kLXNvYy1tb3A1MDAiCj4+Pj4gKyAgIC0gQ1BVLXNpZGUgREFJICAg
OiAic3Rlcmljc3Nvbix1eDUwMC1tc3AtaTJzIgo+Pj4+ICsgICAtIERNQSAocGxhdGZvcm0pIDog
InN0ZXJpY3Nzb24sdXg1MDAtcGNtIgo+Pj4+ICsgICAtIEF1ZGlvIENPREVDICAgIDogInN0ZXJp
Y3Nzb24sYWI4NTAwLWNvZGVjIgo+Cj4+PiBXaGF0IGlzIHRoaXMgYSBiaW5kaW5nIGRvY3VtZW50
IGZvcj8gIEl0IGxvb2tzIGxpa2UgdGhlIGJpbmRpbmcgZm9yIGEKPj4+IG1hY2hpbmUgZHJpdmVy
Li4uCj4KPj4gTm8sIGl0J3MgYSBiaW5kaW5nIGRvY3VtZW50IGZvciBhbGwgb2YgdGhlIHV4NTAw
IGRyaXZlciBhbmQgQ09ERUMKPj4gYmxvY2tzLiBEbyB5b3UgcmVhbGx5IHdhbnQgbWUgdG8gc3Bs
aXQgaXQgYWxsIHVwPyBJIHRoaW5rIHRoZSBvbmx5Cj4+IGNvbXBvbmVudCB3aGljaCBjb3VsZCBi
ZSBzYW5lbHkgc3BsaXQtb3V0IGlzIHRoZSBhYjg1MDAtY29kZWMsIHdoaWNoCj4+IGNvdWxkIChz
aG91bGQ/KSBsaXZlIGluIFsxXS4KPgo+IFllcywgb2YgY291cnNlISAgRWFjaCBkZXZpY2Ugd2ls
bCBoYXZlIGEgc2VwYXJhdGUgYmluZGluZyB3aXRoIGRpZmZlcmVudAo+IHJlcXVpcmVtZW50cy4K
Pgo+PiBUaGVzZSBwcm9wZXJ0aWVzIGFyZSByZWxldmFudCBmb3Igc29tZSwgYnV0IG5vdCBhbGwg
b2YgdGhlCj4+IGNvbXBvbmVudHMgYWJvdmUsIGhlbmNlIHdoeSB0aGUgYXJlIGxpc3RlZCBhdCAn
b3B0aW9uYWwgcHJvcGVydGllcycuCj4KPiBXaGljaCBpcyBwYXJ0IG9mIHRoZSBwcm9ibGVtIGhl
cmUsIGl0IG1ha2VzIGl0IG11Y2ggaGFyZGVyIHRvIHRlbGwgd2hhdAo+IHlvdSBuZWVkIHRvIGRv
IGZvciB0aGUgaW5kaXZpZHVhbCBkZXZpY2VzLgoKT25jZSBhZ2FpbiwgSSdsbCBzcGxpdCB0aGVt
IG91dCwgYnV0IEkgdGhpbmsgdGhlcmUgYXJlIHBlb3BsZSB0YWxraW5nIAphYm91dCBkb2N1bWVu
dGF0aW9uIGNvbnNvbGlkYXRpb24sIGFzIGl0J3MgZ29pbmcgdG8gYmVjb21lIHZlcnkgbWVzc3ks
IAp2ZXJ5IHF1aWNrbHkgaWYgd2Uga2VlcCBhZGRpbmcgbmV3IGZpbGVzIGZvciBlYWNoIGRldmlj
ZS4gU29vbiB0aGUgCkRvY3VtZW50YXRpb24gZGlyZWN0b3J5IHdpbGwgYmUgYXMgbGFyZ2UgYXMg
dGhlIGRyaXZlciBiYXNlLiA6KQoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFu
ZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFS
TSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
