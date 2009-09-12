From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] add channel order map interface in asoc
	core
Date: Sat, 12 Sep 2009 20:55:03 +0800
Message-ID: <3c17e3570909120555l630c8232kb725ccf2b667260f@mail.gmail.com>
References: <1252689389-11661-1-git-send-email-21cnbao@gmail.com>
	<20090912124908.GA8998@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
	[209.85.211.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CFA61037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 14:55:24 +0200 (CEST)
Received: by ywh2 with SMTP id 2so2575117ywh.27
	for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2009 05:55:23 -0700 (PDT)
In-Reply-To: <20090912124908.GA8998@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBTZXAgMTIsIDIwMDkgYXQgODo0OSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFNhdCwgU2VwIDEyLCAyMDA5IGF0
IDAxOjE2OjI5QU0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4+IFRoZSBwYXRjaCBhZGRzIGFu
IGludGVyZmFjZSB0byBzZXQgdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGF1ZGlvCj4+IGNoYW5u
ZWwgbnVtYmVyIGFuZCBzbG90IG51bWJlci4gVGhlIGludGVyZmFjZSBzaG91bGQgYmUgcmVhbGx5
IHVzZWZ1bAo+PiBiZWNhdXNlIGF1ZGlvIGNoYW5uZWwgbiBkb2Vzbid0IGFsd2F5cyB1c2Ugc2xv
dCBuIGluIGFsbCBwbGF0Zm9ybXMuIEFuZAo+PiBmb3Igc29tZSBkZXZpY2VzLCB0aGUgcmVsYXRp
b25zaGlwIGV2ZW4gY2FuIGNoYW5nZSB3aXRoIHNvdW5kIG1vZGUKPj4gc3dpdGNoIGluIDIuMSwz
LjEsNC4xLDUuMSw2LjEsNy4xIGV0Yy4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDwy
MWNuYmFvQGdtYWlsLmNvbT4KPgo+IEFwcGxpZWQsIHRoYW5rcy4gwqBJJ2xsIHByb2JhYmx5IGFk
ZCBhbm90aGVyIHBhdGNoIHNob3J0bHkgY2xhcmlmeWluZyB0aGUKPiBkb2N1bWVudGF0aW9uIGEg
bGl0dGxlLgo+CkkgYW0ganVzdCBzZW5kaW5nIHYzIHBhdGNoIHRvIGZpeCBhIHR5cG8gZXhpc3Rp
bmcgaW4gdjEvdjIgdmVyc2lvbgpwYXRjaCBiZWZvcmUgeW91IGFwcGx5IGl0OgorICAgICAgIGlm
IChkYWktPm9wcyAmJiBkYWktPm9wcy0+c2V0X3RkbV9zbG90KQpzaG91bGQgYmU6CiBpZiAoZGFp
LT5vcHMgJiYgZGFpLT5vcHMtPnNldF9jaGFubmVsX21hcCkKSSBhbSByZWFsbHkgc29ycnkgZm9y
IHRoYXQuCisgICAgICAgICAgICAgICByZXR1cm4gZGFpLT5vcHMtPnNldF9jaGFubmVsX21hcChk
YWksIHR4X251bSwgdHhfc2xvdCwKKyAgICAgICAgICAgICAgICAgICAgICAgcnhfbnVtLCByeF9z
bG90KTsKKyAgICAgICBlbHNlCisgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKCi1CYXJy
eQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
