From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Tue, 16 Apr 2013 15:55:14 +0100
Message-ID: <20130416145514.GB29127@gmail.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
 <20130416141105.GB13272@pengutronix.de>
 <20130416143518.GA29127@gmail.com>
 <20130416144210.GD13272@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 048992610A6
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:55:18 +0200 (CEST)
Received: by mail-wg0-f46.google.com with SMTP id e11so563871wgh.25
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 07:55:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130416144210.GD13272@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAxNiBBcHIgMjAxMywgTWFya3VzIFBhcmdtYW5uIHdyb3RlOgoKPiBPbiBUdWUsIEFw
ciAxNiwgMjAxMyBhdCAwMzozNToxOFBNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4g
Ky8qKgo+ID4gPiA+ICsgKiBzbmRfZG1hZW5naW5lX3BjbV9yZWdpc3RlciAtIFJlZ2lzdGVyIGEg
ZG1hZW5naW5lIGJhc2VkIFBDTSBkZXZpY2UKPiA+ID4gPiArICogQGRldjogVGhlIHBhcmVudCBk
ZXZpY2UgZm9yIHRoZSBQQ00gZGV2aWNlCj4gPiA+ID4gKyAqIEBjb25maWc6IFBsYXRmb3JtIHNw
ZWNpZmljIFBDTSBjb25maWd1cmF0aW9uCj4gPiA+ID4gKyAqIEBmbGFnczogUGxhdGZvcm0gc3Bl
Y2lmaWMgcXVpcmtzCj4gPiA+ID4gKyAqLwo+ID4gPiA+ICtpbnQgc25kX2RtYWVuZ2luZV9wY21f
cmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LAo+ID4gPiA+ICsJY29uc3Qgc3RydWN0IHNuZF9k
bWFlbmdpbmVfcGNtX2NvbmZpZyAqY29uZmlnLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCj4gPiA+ID4g
K3sKPiA+ID4gPiArCXN0cnVjdCBkbWFlbmdpbmVfcGNtICpwY207Cj4gPiA+ID4gKwl1bnNpZ25l
ZCBpbnQgaTsKPiA+ID4gPiArCj4gPiA+ID4gKwlpZiAoIWRldi0+b2Zfbm9kZSkKPiA+ID4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsKPiA+IAo+ID4gV2h5IGlzIHRoaXMgY2FsbCBEZXZpY2UgVHJlZSBv
bmx5Pwo+ID4gCj4gPiBBcmUgZGV2aWNlcyB3aGljaCB1c2UgcGxhdGZvcm0gZGF0YSBzdGlsbCBz
dXBwb3J0ZWQ/Cj4gPiAKPiA+ID4gPiArCXBjbSA9IGt6YWxsb2Moc2l6ZW9mKCpwY20pLCBHRlBf
S0VSTkVMKTsKPiA+ID4gPiArCWlmICghcGNtKQo+ID4gPiA+ICsJCXJldHVybiAtRU5PTUVNOwo+
ID4gPiA+ICsKPiA+ID4gPiArCXBjbS0+Y29uZmlnID0gY29uZmlnOwo+ID4gPiA+ICsKPiA+ID4g
PiArCWZvciAoaSA9IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0s7IGkgPD0gU05EUlZfUENNX1NU
UkVBTV9DQVBUVVJFOyBpKyspIHsKPiA+ID4gPiArCQlwY20tPmNoYW5baV0gPSBvZl9kbWFfcmVx
dWVzdF9zbGF2ZV9jaGFubmVsKGRldi0+b2Zfbm9kZSwKPiA+ID4gPiArCQkJCQlkbWFlbmdpbmVf
cGNtX2RtYV9jaGFubmVsX25hbWVzW2ldKTsKPiA+ID4gPiArCX0KPiA+ID4gCj4gPiA+IFBlcmhh
cHMgeW91IHNob3VsZCB1c2UgZG1hX3JlcXVlc3Rfc2xhdmVfY2hhbm5lbCBoZXJlPyBUaGVuIHlv
dSBjb3VsZAo+ID4gPiBhbHNvIGRyb3AgdGhlIG9mX2RtYS5oIGluY2x1ZGUuCj4gPiAKPiA+IFRo
ZW4gaG93IHdvdWxkIERldmljZSBUcmVlIGJlIHN1cHBvcnRlZD8KPiAKPiBkbWFfcmVxdWVzdF9z
bGF2ZV9jaGFubmVsIGNhbGxzIG9mX2RtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWwgaWYKPiBkZXYt
Pm9mX25vZGUgZXhpc3RzLiBBcyBmYXIgYXMgSSBrbm93IGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5u
ZWwgaXMKPiBwcmVmZXJyZWQgZm9yIGNhbGxzIGZyb20gb3V0c2lkZSB0aGUgZG1hZW5naW5lIGNv
cmUuCgpBaCB5ZXMsIGZhaXIgcG9pbnQuIEkgd2FzIHRoaW5raW5nIG9mIGRtYV9yZXF1ZXN0X2No
YW5uZWwoKS4KCkkgdGhpbmsgbXkgZmlyc3QgcXVlc3Rpb24gKGFib3ZlKSBpcyBzdGlsbCB2YWxp
ZCB0aG91Z2guCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0g
TGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9s
bG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
