From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: ak4641: Use SND_SOC_DAPM_DAC for
 Voice Playback stream widget
Date: Wed, 19 Oct 2011 17:48:27 +0100
Message-ID: <CABS+qY1o93bsBVtyU+1fZu1xp0HAWZ7i81X_AOvZk2hZUdReVg@mail.gmail.com>
References: <1319037894.7741.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E5141039B5
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 18:48:28 +0200 (CEST)
Received: by mail-yx0-f181.google.com with SMTP id 33so2430753yxt.40
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 09:48:27 -0700 (PDT)
In-Reply-To: <1319037894.7741.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gMTkgT2N0b2JlciAyMDExIDE2OjI0LCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPgo+IC0t
LQo+IMKgc291bmQvc29jL2NvZGVjcy9hazQ2NDEuYyB8IMKgIMKgMiArLQo+IMKgMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9hazQ2NDEuYyBiL3NvdW5kL3NvYy9jb2RlY3MvYWs0NjQxLmMKPiBp
bmRleCBmNTEyNWFlLi43NzgzODU4IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvYWs0
NjQxLmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL2FrNDY0MS5jCj4gQEAgLTIyNSw3ICsyMjUs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgYWs0NjQxX2RhcG1f
d2lkZ2V0c1tdID0gewo+IMKgIMKgIMKgIMKgU05EX1NPQ19EQVBNX1BHQSgiTW9ubyBPdXQgMiIs
IEFLNDY0MV9QTTIsIDMsIDAsIE5VTEwsIDApLAo+Cj4gwqAgwqAgwqAgwqBTTkRfU09DX0RBUE1f
QURDKCJWb2ljZSBBREMiLCAiVm9pY2UgQ2FwdHVyZSIsIEFLNDY0MV9CVElGLCAwLCAwKSwKPiAt
IMKgIMKgIMKgIFNORF9TT0NfREFQTV9BREMoIlZvaWNlIERBQyIsICJWb2ljZSBQbGF5YmFjayIs
IEFLNDY0MV9CVElGLCAxLCAwKSwKPiArIMKgIMKgIMKgIFNORF9TT0NfREFQTV9EQUMoIlZvaWNl
IERBQyIsICJWb2ljZSBQbGF5YmFjayIsIEFLNDY0MV9CVElGLCAxLCAwKSwKPgo+IMKgIMKgIMKg
IMKgU05EX1NPQ19EQVBNX01JQ0JJQVMoIk1pYyBJbnQgQmlhcyIsIEFLNDY0MV9NSUMsIDMsIDAp
LAo+IMKgIMKgIMKgIMKgU05EX1NPQ19EQVBNX01JQ0JJQVMoIk1pYyBFeHQgQmlhcyIsIEFLNDY0
MV9NSUMsIDQsIDApLAo+IC0tCj4gMS43LjUuNAo+CgpBaCwgZ29vZCBjYXRjaC4gU3VycHJpc2Vk
IHRoZSBhdXRob3IgZGlkIG5vdCBub3RpY2UgdGhhdCA6KQoKQWNrZWQtYnk6IExpYW0gR2lyZHdv
b2QgPGxyZ0B0aS5jb20+CgoKPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
