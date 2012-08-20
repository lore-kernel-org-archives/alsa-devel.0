From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup
 into the MSP driver
Date: Mon, 20 Aug 2012 12:59:25 +0100
Message-ID: <20120820115914.GP8450@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
 <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D5389264EAA
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 13:59:27 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1307133eek.38
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 04:59:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Patrice CHOTARD <patrice.chotard@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBdWcgMTQsIDIwMTIgYXQgMTA6NTE6MDJBTSArMDIwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToKPiBPbiBUaHUsIEF1ZyA5LCAyMDEyIGF0IDU6NDcgUE0sIExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+IHdyb3RlOgo+IAo+ID4gSW4gdGhlIGluaXRpYWwgc3VibWlzc2lvbiBv
ZiB0aGUgTVNQIGRyaXZlciBtc3AxIGFuZCBtc3AzJ3MgYXNzb2NpYXRlZAo+ID4gcGluY3RybCBt
ZWNoYW5pc20gd2FzIHBhc3NlZCBiYWNrIHRvIHBsYXRmb3JtIGNvZGUgdXNpbmcgYSBwbGF0X2lu
aXQoKQo+ID4gY2FsbC1iYWNrIHJvdXRpbmUsIGJ1dCBpdCBoYXMgbm8gcGxhY2UgaW4gcGxhdGZv
cm0gY29kZS4gVGhlIE1TUCBkcml2ZXIKPiA+IHNob3VsZCBzZXQgdGhpcyB1cCBmb3IgdGhlIGFw
cHJvcHJpYXRlIHBvcnRzLiBJbnN0ZWFkIHdlIHVzZSBhIHVzZV9waW5jdHJsCj4gPiBpZGVudGlm
aWVyIHdoaWNoIGlzIHBhc3NlZCBmcm9tIHBsYXRmb3JtX2RhdGEvRGV2aWNlIFRyZWUgd2hpY2gg
aW5kaWNhdGVzCj4gPiB3aGljaCBwb3J0cyBzaG91bGQgdXNlIHBpbmN0cmwuCj4gPgo+ID4gQ0M6
IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+ID4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAKPiBUaGlzIGlzIHZlcnkgZ29vZCBiZWNhdXNlIGl0
IHJpZHMgcGxhdGZvcm0gY29kZSBhbmQgbWFrZXMgdGhlIGRyaXZlcgo+IHNlbGYtY29udGFpbmVk
IHdpdGhvdXQgc3RyYW5nZSBwbGF0Zm9ybSBkYXRhIGhvb2tzLgo+IAo+IE5vdyBkZXRhaWxzLi4u
Cj4gCj4gPiArLyogTVNQMS8zIFR4L1J4IHVzYWdlIHByb3RlY3Rpb24gKi8KPiA+ICtzdGF0aWMg
REVGSU5FX1NQSU5MT0NLKG1zcF9yeHR4X2xvY2spOwo+ID4gKwo+ID4gKy8qIFBpbiBtb2RlcyAq
Lwo+ID4gK3N0cnVjdCBwaW5jdHJsICpwaW5jdHJsX3A7Cj4gPiArc3RydWN0IHBpbmN0cmxfc3Rh
dGUgKnBpbmN0cmxfZGVmOwo+ID4gK3N0cnVjdCBwaW5jdHJsX3N0YXRlICpwaW5jdHJsX3NsZWVw
Owo+ID4gKwo+ID4gKy8qIFJlZmVyZW5jZSBDb3VudCAqLwo+ID4gK2ludCBwaW5jdHJsX3J4dHhf
cmVmOwo+IAo+IAo+IEJ1dCB3YWl0LiBUaGVzZSBhcmUganVzdCBsb2NhbCBzdGF0aWNzLiBTdXJl
bHR5IHlvdSBjYW4gcHV0IHRoZXNlIGludG8KPiBzdHJ1Y3QgdXg1MDBfbXNwIGluc3RlYWQ/IEhl
cmUgaXQgbG9va3MgbGlrZSB0aGVzZSB3aWxsIGJlIHVzZWQgZm9yCj4gYWxsIHBvcnRzLCBzbyBN
U1AyIHdpbGwgZW5hYmxlIHRoZSBwaW5zIHJlcXVlc3RlZCBieSBNU1AxIGV0Ywo+IGNvbXBsZXRl
bHkgYnJva2VuLiBTbyBwdXQgaXQgaW50byB0aGUgc3RydWN0IHV4NTAwX21zcCBzdGF0ZQo+IGNv
bnRhaW5lciBmcm9tIHV4NTAwX21zcF9pMnMuaCB3aGVyZSBpdCBiZWxvbmdzLgo+IAo+IFJlZmVy
IHRvIGRyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMgd2hlbiBpbiB0cm91YmxlLiBUaGlz
Cj4gb25lIGlzIGEgZ29vZCBwaW5jdHJsIGV4YW1wbGUuCgpIb3cgZG8geW91IHNlZSB0aGUgTVNQ
MSBhbmQgTVNQMyB1c2FnZSBwcm90ZWN0aW9uIHdvcmtpbmcgaWYgSSBoaWRlIGl0CmFsbCBhd2F5
IGluIE1TUCBzcGVjaWZpYyBzdHJ1Y3RzPwoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nz
b24gTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUg
Zm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
