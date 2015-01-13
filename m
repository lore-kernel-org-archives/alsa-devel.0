From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Tue, 13 Jan 2015 20:02:52 +0100
Message-ID: <20150113200252.3dbfab14@armhf>
References: <20150109200127.GD12302@n2100.arm.linux.org.uk>
 <1421054728.3081.28.camel@pengutronix.de>
 <20150112122527.GF12302@n2100.arm.linux.org.uk>
 <1421071197.3081.44.camel@pengutronix.de>
 <20150112140456.GI12302@n2100.arm.linux.org.uk>
 <20150112181341.4a53ea24@armhf>
 <20150112175705.GN12302@n2100.arm.linux.org.uk>
 <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
 <20150113165411.5469930d@armhf>
 <20150113160313.GR12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150113160313.GR12302@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAxMyBKYW4gMjAxNSAxNjowMzoxMyArMDAwMApSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPiBPbiBUdWUsIEphbiAxMywgMjAx
NSBhdCAwNDo1NDoxMVBNICswMTAwLCBKZWFuLUZyYW5jb2lzIE1vaW5lIHdyb3RlOgo+ID4gNCBz
dHJlYW1zIG9uIDQgZGlmZmVyZW50IEFQcyAoc291cmNlcykgc2hvdWxkIHdvcmssIGJ1dCA0IHN0
cmVhbXMgZnJvbQo+ID4gYSBzYW1lIHNvdXJjZSBzaG91bGQgYmUgZGV0YWlsZWQuCj4gCj4gSSdk
IGxpa2UgdG8ga25vdyBob3cgeW91IGludGVuZCB0byB3aXJlIHVwIGZvdXIgZGlmZmVyZW50IEky
UyBzb3VyY2VzCj4gdG8gdGhlIFREQTk5OHguCj4gCj4gUmVtZW1iZXIsIGFuIEkyUyBzb3VyY2Ug
cHJvZHVjZXMgdGhlIEkyUyBkYXRhIGFuZCB0aGUgd29yZCBjbG9jayAtIHRoYXQncwo+IHR3byBv
dXRwdXRzLiAgWW91IGNhbid0IGVsZWN0cm9uaWNhbGx5IHdpcmUgdGhlIHdvcmQgY2xvY2tzIHRv
Z2V0aGVyLgoKRnJvbSB0aGUgc3BlYywgdGhlIHRkYTk5OHggZ2V0cyBpbmRlcGVuZGVudGx5IHRo
ZSBzZXJpYWwgY2xvY2sgYW5kIHRoZQpzZXJpYWwgd29yZCBzZWxlY3QgZnJvbSBlYWNoIEkyUyAo
c3RlcmVvKSBpbnB1dCBjaGFubmVsICg9IGF1ZGlvIHBpbiksCnNvLCB5b3UgbWF5IGhhdmUgNCBh
dWRpbyBjaGlwcyBnaXZpbmcgNCBpbmRlcGVuZGVudCBhdWRpbyBzdHJlYW1zLgpJIGRvbid0IGtu
b3cgd2hhdCBjYW4gYmUgdGhlIHJlc3VsdCBpbiBIRE1JIGlmIHRoZXNlIHN0cmVhbXMgYXJlIGFj
dGl2ZWQKYXQgdGhlIHNhbWUgdGltZSEKCkluIHRoZSBvdGhlciBjb25maWd1cmF0aW9uLCBhbiBh
dWRpbyBjaGlwIG1heSBoYXZlIDQgc3luY2hyb25pemVkIHN0ZXJlbwpjaGFubmVscyAoc29mdHdh
cmUgUENNcykuIFRoZXNlIG9uZXMgbWF5IGJlIGNvbnNpZGVyZWQgYXMgb25lIGxpbmsgKG9uZQpw
b3J0IG91dCBmcm9tIHRoZSBhdWRpbyBjaGlwIHRvIG9uZSBwb3J0IGluIHRvIHRoZSB0ZGE5OTh4
KSwgdGhlIEFQCmNvbmZpZ3VyYXRpb24gYmVpbmcgMHgxZi4KCi0tIApLZW4gYXIgYydoZW50YcOx
CXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJfAkJaHR0cDovL21vaW5l
amYuZnJlZS5mci8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
