From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the
 HDMI transmitter
Date: Fri, 9 Jan 2015 12:45:31 +0100
Message-ID: <20150109124531.493bece4@armhf>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
 <54AD4C77.5000401@arm.com>
 <20150107154138.GL12302@n2100.arm.linux.org.uk>
 <20150107190241.27ebac8b@armhf> <54AFAC4C.7010209@ti.com>
 <20150109111935.GF12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id B8A7C2605CB
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 12:43:13 +0100 (CET)
In-Reply-To: <20150109111935.GF12302@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCA5IEphbiAyMDE1IDExOjE5OjM1ICswMDAwClJ1c3NlbGwgS2luZyAtIEFSTSBMaW51
eCA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cgo+IFdvdWxkIGl0IGJlIG1vcmUgc2Vu
c2libGUgdG8gbWFrZSBTTkRfU09DX1REQTk5OFggZGVwZW5kIG9uCj4gRFJNX0kyQ19OWFBfVERB
OTk4WCBpbnN0ZWFkLCBtYXliZSB3aXRoIGEgJ2RlZmF1bHQgeScgLSB3aGljaCBpcyBhCj4ga2lu
ZGVyIHdheSB0byBoYXZlIFNORF9TT0NfVERBOTk4WCBiZSBlbmFibGVkLiAgSWYgU05EX1NPQ19U
REE5OThYCj4gZG9lc24ndCBoYXZlIGEgcHJvbXB0LCB0aGVuIGl0J2xsIGF1dG9tYXRpY2FsbHkg
ZW5hYmxlIGl0c2VsZiB0b28KPiB0aGlzIHdheSB3aGVuIGFsbCBpdHMgZGVwZW5kZW5jaWVzIGFy
ZSBzYXRpc2ZpZWQuCgpZb3UgYXJlIHJpZ2h0LCBJIHdpbGwgc2V0IGJhY2sgdGhlIHdheSBJIGhh
ZCBpbiB0aGUgdmVyc2lvbiAzOgoKPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9LY29u
ZmlnIGIvc291bmQvc29jL2NvZGVjcy9LY29uZmlnCj4gaW5kZXggYjMzYjQ1ZC4uNzQ3ZTM4NyAx
MDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKPiArKysgYi9zb3VuZC9zb2Mv
Y29kZWNzL0tjb25maWcKPiBAQCAtMzUyLDYgKzM1MiwxMiBAQCBjb25maWcgU05EX1NPQ19TVEFD
OTc2Ngo+ICBjb25maWcgU05EX1NPQ19UQVM1MDg2Cj4gIAl0cmlzdGF0ZQo+ICAKPiArY29uZmln
IFNORF9TT0NfVERBOTk4WAo+ICsJdHJpc3RhdGUKPiArCWRlZmF1bHQgeSBpZiBEUk1fSTJDX05Y
UF9UREE5OThYPXkKPiArCWRlZmF1bHQgbSBpZiBEUk1fSTJDX05YUF9UREE5OThYPW0KPiArCgot
LSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoqIEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpK
ZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIvCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
