From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Tue, 16 Apr 2013 15:35:18 +0100
Message-ID: <20130416143518.GA29127@gmail.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
 <20130416141105.GB13272@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C919726109C
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:35:23 +0200 (CEST)
Received: by mail-wi0-f175.google.com with SMTP id c10so2692849wiw.2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 07:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130416141105.GB13272@pengutronix.de>
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

PiA+ICsvKioKPiA+ICsgKiBzbmRfZG1hZW5naW5lX3BjbV9yZWdpc3RlciAtIFJlZ2lzdGVyIGEg
ZG1hZW5naW5lIGJhc2VkIFBDTSBkZXZpY2UKPiA+ICsgKiBAZGV2OiBUaGUgcGFyZW50IGRldmlj
ZSBmb3IgdGhlIFBDTSBkZXZpY2UKPiA+ICsgKiBAY29uZmlnOiBQbGF0Zm9ybSBzcGVjaWZpYyBQ
Q00gY29uZmlndXJhdGlvbgo+ID4gKyAqIEBmbGFnczogUGxhdGZvcm0gc3BlY2lmaWMgcXVpcmtz
Cj4gPiArICovCj4gPiAraW50IHNuZF9kbWFlbmdpbmVfcGNtX3JlZ2lzdGVyKHN0cnVjdCBkZXZp
Y2UgKmRldiwKPiA+ICsJY29uc3Qgc3RydWN0IHNuZF9kbWFlbmdpbmVfcGNtX2NvbmZpZyAqY29u
ZmlnLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCj4gPiArewo+ID4gKwlzdHJ1Y3QgZG1hZW5naW5lX3Bj
bSAqcGNtOwo+ID4gKwl1bnNpZ25lZCBpbnQgaTsKPiA+ICsKPiA+ICsJaWYgKCFkZXYtPm9mX25v
ZGUpCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKCldoeSBpcyB0aGlzIGNhbGwgRGV2aWNlIFRyZWUg
b25seT8KCkFyZSBkZXZpY2VzIHdoaWNoIHVzZSBwbGF0Zm9ybSBkYXRhIHN0aWxsIHN1cHBvcnRl
ZD8KCj4gPiArCXBjbSA9IGt6YWxsb2Moc2l6ZW9mKCpwY20pLCBHRlBfS0VSTkVMKTsKPiA+ICsJ
aWYgKCFwY20pCj4gPiArCQlyZXR1cm4gLUVOT01FTTsKPiA+ICsKPiA+ICsJcGNtLT5jb25maWcg
PSBjb25maWc7Cj4gPiArCj4gPiArCWZvciAoaSA9IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0s7
IGkgPD0gU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFOyBpKyspIHsKPiA+ICsJCXBjbS0+Y2hhbltp
XSA9IG9mX2RtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWwoZGV2LT5vZl9ub2RlLAo+ID4gKwkJCQkJ
ZG1hZW5naW5lX3BjbV9kbWFfY2hhbm5lbF9uYW1lc1tpXSk7Cj4gPiArCX0KPiAKPiBQZXJoYXBz
IHlvdSBzaG91bGQgdXNlIGRtYV9yZXF1ZXN0X3NsYXZlX2NoYW5uZWwgaGVyZT8gVGhlbiB5b3Ug
Y291bGQKPiBhbHNvIGRyb3AgdGhlIG9mX2RtYS5oIGluY2x1ZGUuCgpUaGVuIGhvdyB3b3VsZCBE
ZXZpY2UgVHJlZSBiZSBzdXBwb3J0ZWQ/CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3Nv
biBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBm
b3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
