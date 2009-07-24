From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 3/4] Convert WM97xx driver to use
	platform_data
Date: Fri, 24 Jul 2009 21:44:01 +0200
Message-ID: <87k51xeuim.fsf@free.fr>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721223424.GA21147@oksana.dev.rtsoft.ru>
	<200907221301.04239.marek.vasut@gmail.com>
	<200907221304.16534.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id E78CB1037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 21:44:12 +0200 (CEST)
In-Reply-To: <200907221304.16534.marek.vasut@gmail.com> (Marek Vasut's message
	of "Wed\, 22 Jul 2009 13\:04\:16 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

TWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QGdtYWlsLmNvbT4gd3JpdGVzOgoKPiBEbmUgU3QgMjIu
IMSNZXJ2ZW5jZSAyMDA5IDEzOjAxOjAzIE1hcmVrIFZhc3V0IG5hcHNhbChhKToKPj4gT2ssCj4+
IEltIHNlbmRpbmcgdGhlIHNldCBhZ2Fpbi4KPgo+IFRoaXMgb25lIHNob3VsZCBiZSBhY2tlZCBi
eSBBbnRvbiBhbHJlYWR5Lgo+Cj4gRnJvbSA1NGZlYmU4Mjg0N2FlZWYzZmNjMDJhMDc0ZmQ5ZDIx
ZGVmOTdmMTc0IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dEBnbWFpbC5jb20+Cj4gRGF0ZTogVHVlLCAyMSBKdWwgMjAwOSAxODo1MjoyOCAr
MDIwMAo+IFN1YmplY3Q6IFtQQVRDSCAzLzRdIENvbnZlcnQgV005N3h4IGRyaXZlciB0byB1c2Ug
cGxhdGZvcm1fZGF0YQo+Cj4gVGhpcyBwYXRjaCBjb252ZXJ0cyB0aGUgd205N3h4IGRyaXZlciB0
byB1c2UgcGxhdGZvcm1fZGF0YSBzdXBwbGllZCBieQo+IGFjOTcgYnVzLiBBbHNvLCB0aGlzIGZp
eGVzIHRoZSByZWxhdGVkIHdtOTd4eC1iYXR0ZXJ5IGRyaXZlciB0byB1c2UKPiBpdCdzIHBsYXRm
b3JtX2RhdGEgYW5kIHByZXBhcmVzIGEgc3RydWN0dXJlIGZvciB0b3VjaHNjcmVlbiBkcml2ZXIu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPgoK
PiBAQCAtOTcsNiArMTA1LDcgQEAgc3RhdGljIHZvaWQgd205N3h4X2JhdF9leHRlcm5hbF9wb3dl
cl9jaGFuZ2VkKHN0cnVjdCBwb3dlcl9zdXBwbHkgKmJhdF9wcykKPiAgc3RhdGljIHZvaWQgd205
N3h4X2JhdF91cGRhdGUoc3RydWN0IHBvd2VyX3N1cHBseSAqYmF0X3BzKQo+ICB7Cj4gIAlpbnQg
b2xkX3N0YXR1cyA9IGJhdF9zdGF0dXM7Cj4gKwlzdHJ1Y3Qgd205N3h4X2JhdHRfcGRhdGEgKnBk
YXRhID0gZGV2X2dldF9kcnZkYXRhKGJhdF9wcy0+ZGV2LT5wYXJlbnQpOwpBcmUgeW91IHN1cmUg
b2YgdGhpcyBsaW5lID8KQmVjYXVzZSB3aGVuIEkgYWRkIHRoaXMgbGluZSBuZXh0IHRvIGl0IDoK
CXByaW50ayhLRVJOX0lORk8gIlJKSzogY2hhcmdlX2dwaW8gPSAlZFxuIiwgcGRhdGEtPmNoYXJn
ZV9ncGlvKTsKSSBnZXQgOgpbICAxNjAuMDc5MjM5XSBwb3dlcl9zdXBwbHkgbWlvYTcwMV9iYXR0
ZXJ5OiBwcm9wIFZPTFRBR0VfTk9XPTQwMTIKWyAgMTYwLjA4OTc2N10gcG93ZXJfc3VwcGx5IG1p
b2E3MDFfYmF0dGVyeTogcHJvcCBWT0xUQUdFX01BWD00MDMyClsgIDE2MC4wOTk3NzJdIHBvd2Vy
X3N1cHBseSBtaW9hNzAxX2JhdHRlcnk6IHByb3AgVk9MVEFHRV9NSU49MzA3MgpbICAxNjAuMTEx
Nzc2XSBSSks6IGNoYXJnZV9ncGlvID0gMjYwNDQwMDYyCgpOZWVkbGVzcyB0byBzYXkgdGhhdCBt
eSBrZXJuZWwgZG9lc24ndCBib290IGluIHRoYXQgY2FzZSAoYmVjYXVzZSBvZiB0aGUKZm9sbG93
aW5nIGdwaW9fZ2V0X3ZhbHVlKCkpLiBJIHdhcyBleHBlY3RpbmcgdG8gaGF2ZSAiLTEiIGluIG15
IHByaW50ay4KCkNoZWVycy4KCi0tClJvYmVydApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
