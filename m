From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_set_params faild on set_buffer_time_near
	and set_period_time_near
Date: Mon, 27 Jul 2015 16:36:56 +0800
Message-ID: <CAN8ccibKnZwMJ8aD9HnR3UX916HtL-bthmKEfwVFEw6Su__FXg@mail.gmail.com>
References: <55AE0831.2010206@streamunlimited.com>
 <s5htwsvwawr.wl-tiwai@suse.de>
 <55B1EEAE.3080307@streamunlimited.com>
 <s5h8ua6vude.wl-tiwai@suse.de>
 <55B21E9C.9010506@streamunlimited.com>
 <CAN8ccibJoih-XhbySf4KPKyvQjQRuZ53g60d_BmODRAvvyZdqg@mail.gmail.com>
 <55B5D9D7.4060502@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6718E2619E7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:36:57 +0200 (CEST)
Received: by oibn4 with SMTP id n4so47612138oib.3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 01:36:56 -0700 (PDT)
In-Reply-To: <55B5D9D7.4060502@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Geier <martin.geier@streamunlimited.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

MjAxNS03LTI3IOS4i+WNiDM6MTLmlrwgIk1hcnRpbiBHZWllciIgPG1hcnRpbi5nZWllckBzdHJl
YW11bmxpbWl0ZWQuY29tPuWvq+mBk++8mgo+Cj4gSGkgUmF5bW9uZCwKPgo+IE91dHB1dCBwYXJh
bWV0ZXJzIHdpdGggY3VzdG9tIGxvZ3M6Cj4gc2V0X2J1ZmZlcl90aW1lX25lYXI6IC0yMgo+IHNl
dCBwZXJpb2QgdGltZTogMTI1MTcKPiBnZXQgcGVyaW9kIHNpemU6IDI3Ngo+IHNldCBidWZmZXIg
c2l6ZTogMTEwNAo+IGdldCBidWZmZXIgc2l6ZTogMTEwNAo+Cj4KPiBBQ0NFU1M6ICBSV19JTlRF
UkxFQVZFRAo+IEZPUk1BVDogIFMxNl9MRQo+IFNVQkZPUk1BVDogIFNURAo+IFNBTVBMRV9CSVRT
OiAxNgo+IEZSQU1FX0JJVFM6IDMyCj4gQ0hBTk5FTFM6IDIKPiBSQVRFOiAyMjA1MAo+IFBFUklP
RF9USU1FOiAoMTI1MTcgMTI1MTgpCj4gUEVSSU9EX1NJWkU6IDI3Ngo+IFBFUklPRF9CWVRFUzog
MTEwNAo+IFBFUklPRFM6IDQKPiBCVUZGRVJfVElNRTogKDUwMDY4IDUwMDY5KQo+IEJVRkZFUl9T
SVpFOiAxMTA0Cj4gQlVGRkVSX0JZVEVTOiA0NDE2Cj4KPiBXaGF0IGRvIHlvdSBtZWFuLCBhcmUg
bGF0ZW5jeSBhbHdheXMgPD0gNTBtcz8gSW4gd2hhdCBjYXNlcz8KCmh0dHA6Ly93d3cuYWxzYS1w
cm9qZWN0Lm9yZy9hbHNhLWRvYy9hbHNhLWxpYi9ncm91cF9fX3BfY19tLmh0bWwjZ2E0NWQ1MDg0
MWIzMDdmMjE1NmZjZTE4NTdiZmFjMjI4YwoKU2V0IHRoZSBoYXJkd2FyZSBhbmQgc29mdHdhcmUg
cGFyYW1ldGVycyBpbiBhIHNpbXBsZSB3YXkuClBhcmFtZXRlcnM6cGNtIFBDTSBoYW5kbGUKZm9y
bWF0IHJlcXVpcmVkIFBDTSBmb3JtYXQKYWNjZXNzIHJlcXVpcmVkIFBDTSBhY2Nlc3MKY2hhbm5l
bHMgcmVxdWlyZWQgUENNIGNoYW5uZWxzCnJhdGUgcmVxdWlyZWQgc2FtcGxlIHJhdGUgaW4gSHoK
c29mdF9yZXNhbXBsZSAwID0gZGlzYWxsb3cgYWxzYS1saWIgcmVzYW1wbGUgc3RyZWFtLCAxID0g
YWxsb3cgcmVzYW1wbGluZwpsYXRlbmN5IHJlcXVpcmVkIG92ZXJhbGwgbGF0ZW5jeSBpbiB1cwoK
UmVmZXIgdG8geW91ciByZXN1bHQgc2VlbSBsYXRlbmN5IG9ubHkgY2xvc2UgdG8gNTBtcwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
