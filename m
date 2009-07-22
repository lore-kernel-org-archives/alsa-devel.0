From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 4/4] Convert all platforms to pass
	platform_data to wm97xx battery
Date: Wed, 22 Jul 2009 20:09:09 +0200
Message-ID: <87ocrczj22.fsf@free.fr>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721223424.GA21147@oksana.dev.rtsoft.ru>
	<200907221301.04239.marek.vasut@gmail.com>
	<200907221305.44952.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 19C9824490
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 20:09:21 +0200 (CEST)
In-Reply-To: <200907221305.44952.marek.vasut@gmail.com> (Marek Vasut's message
	of "Wed\, 22 Jul 2009 13\:05\:44 +0200")
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
IEltIHNlbmRpbmcgdGhlIHNldCBhZ2Fpbi4KPiBBbmQgdGhpcyBkb2VzIHRoZSBwbGF0Zm9ybSBj
b252ZXJzaW9uLiBEZXBlbmRzIG9uIDMvNCBhbmQgc2hvdWxkIGJlIEFja2VkIGJ5IAo+IFJvYmVy
dC4gU28gcGxlYXNlLgpXZWxsLCB0aGVyZSBhcmUgMiB0aGluZ3Mgd3Jvbmcgd2l0aCB0aGUgbWlv
YTcwMSBwYXJ0LgoKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvbWlvYTcwMS5jIGIv
YXJjaC9hcm0vbWFjaC1weGEvbWlvYTcwMS5jCj4gaW5kZXggM2NhYjQ1Mi4uODAzOTE3ZCAxMDA2
NDQKPiAtLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9taW9hNzAxLmMKPiArKysgYi9hcmNoL2FybS9t
YWNoLXB4YS9taW9hNzAxLmMKPiBAQCAtMzQsNyArMzQsNyBAQAo+ICAjaW5jbHVkZSA8bGludXgv
aXJxLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9wZGFfcG93ZXIuaD4KPiAgI2luY2x1ZGUgPGxpbnV4
L3Bvd2VyX3N1cHBseS5oPgo+IC0jaW5jbHVkZSA8bGludXgvd205N3h4X2JhdHQuaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3dtOTd4eC5oPgo+ICAjaW5jbHVkZSA8bGludXgvbXRkL3BoeXNtYXAuaD4K
PiAgI2luY2x1ZGUgPGxpbnV4L3VzYi9ncGlvX3ZidXMuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3Jl
Z3VsYXRvci9tYXgxNTg2Lmg+Cj4gQEAgLTY2MCw2ICs2NjAsMTAgQEAgc3RhdGljIHN0cnVjdCB3
bTk3eHhfYmF0dF9pbmZvIG1pb2E3MDFfYmF0dGVyeV9kYXRhID0gewooMSkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcLT4gc2hvdWxkIGJlIHdtOTd4eF9iYXR0X3BkYXRhCgoo
MikgcmVtb3ZlIHdtOTd4eF9iYXRfc2V0X3BkYXRhKCZtaW9hNzAxX2JhdHRlcnlfZGF0YSkgY2Fs
bCBpbgptaW9hNzAxX21hY2hpbmVfaW5pdCgpLgoKSSdsbCB0cnkgdG8gdGVzdCB0aGlzIGV2ZW5p
bmcsIGFuZCByZXBvcnQuCgpDaGVlcnMuCgotLQpSb2JlcnQKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
