From: "Kuankuan.Yang" <ykk@rock-chips.com>
Subject: Re: [RFC PATCH 0/6] Those patches is used for dw_hdmi
	audio.
Date: Mon, 15 Dec 2014 19:45:37 +0800
Message-ID: <548EC9E1.5040206@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <20141215103830.GD11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.137])
 by alsa0.perex.cz (Postfix) with ESMTP id DB4A0260437
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 12:46:06 +0100 (CET)
In-Reply-To: <20141215103830.GD11285@n2100.arm.linux.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Bard Liao <bardliao@realtek.com>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Takashi Iwai <tiwai@suse.de>, linux-rockchip@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dylan Reid <dgreid@chromium.org>, Xu Jianqun <jay.xu@rock-chips.com>, Oder Chiou <oder_chiou@realtek.com>, Zubair.Kakakhel@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Rob Herring <robh+dt@kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu@chromium.org>
List-Id: alsa-devel@alsa-project.org

SGkgUnVzc2VsbDoKCiAgIHRoa3MgZm9yIHlvdXIgcmVwbGF5LCBhY3R1YWxseSB5b3UgYWxzbyBo
YXZlIHNlbmQgbWUgdGhvc2UgCmR3LWhkbWktYXVkaW8uYyBwYXRjaGVzLCBhbmQgSSBhbHNvIGFn
cmVlIGl0J3MgYW4gYmVhdXRpZnVsIHdheSB0byBtYWtlIApoZG1pLWF1ZGlvIHdvcmtzLiBCZXNp
ZGUsCkkgdHJ5IHRvIHJldXNlIGl0IGludG8gb3VyIHBsYXRmb3JtLCBhbmQgYWN0dWFsbHkgdGhl
IHN5c3RlbSBoYXZlIApjcmVhdGVkIHRoZSBEV19IRE1JIHNvdW5kIGNhcmQgc3VjY2Vzc2Z1bGx5
LCBidXQgaSBjYW5ub3QgcGxheSBhbnkgCnNvdW5kICB3aXRoIHRoaXMgc291bmQgY2FyZC4KICAg
QWZ0ZXIgZHVtcCB0aGUgcmVnaXN0ZXJzLCBJIGZvdW5kIHRoZSBwYXJ0IG9mICJBdWRpbyBETUEg
UmVnaXN0ZXJzIiAKY2Fubm90IHdyaXRlIGFuZCBhbHdheXMgcmVhZCB3aXRoIDB4MDAuICBTbyBJ
IHNlYXJjaGluZyB0aGUgZG9jdW1lbnQgIAoiRGVzaWdud2FyZSBDb3JlCkhETUkgVHJhbnNtaXR0
ZXIgQ29udHJvbGxlciBEYXRhYm9vayIsIGFuZCBmb3VuZCB0aGF0ICAiQXVkaW8gRE1BIApSZWdp
c3RlcnMiIG9ubHkgcHJlc2VudCB3aGVuIHRoZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIHBhcmFt
ZXRlciAKQVVESU9fSUYgaXMgc2V0IHRvCkFIQkFVRERNQS4gVGhhbiBJIGNvbW11bmljYXRlIHdp
dGggb3VyIElDIGNvbGxlYWd1ZXMsIHRoZXkgdG9sZCBtZSB0aGF0IApvdXIgY3B1IHJrMzI4OCBv
bmx5IHN1cHBvcnQgdHdvIHdheSB0byAgdHJhbnNtaXQgYXVkaW8gZGF0YSggSTJTICYgU1BESUYg
CiksIGluIHRoYXQKd2F5IHdlIGRvIG5vdCBzdXBwb3J0IEFIQl9ETUEsIGl0J3MgdmVyeSBzYWQs
IGFuZCB0aGlzIGl0IHdoeSBpIGdpdmUgdXAgCnRoaXMgd2F5LCBhbHNvIGl0J3MgbXkgYmFkIHRo
YXQgaSBzaG91bGQgcmVwbGF5IHRvIHUgZmlyc3QgaW4gdGhlIGJlZm9yZSAKbWFpbC4KCkJlc3Qg
UmVnYXJkcy4KCuWcqCAyMDE05bm0MTLmnIgxNeaXpSAxODozOCwgUnVzc2VsbCBLaW5nIC0gQVJN
IExpbnV4IOWGmemBkzoKPiBPbiBNb24sIERlYyAxNSwgMjAxNCBhdCAxMDoxMToyOEFNICswODAw
LCBZYWtpciBZYW5nIHdyb3RlOgo+PiByazMyODggdXNlIERlc2lnbndhcmUgSERNSSBJUCwgRGVz
aWdud2FyZSBIRE1JIHN1cHBvcnRzIGZvdXIgaW50ZXJmYWNlcyB0bwo+PiBjb25maWcgaGRtaSBh
dWRpbyhJMlMsIFMvUERJRiwgR2VuZXJpYyBQYXJhbGxlbCBBdWRpbywgQUhCIEF1ZGlvIERNQSks
IGJ1dAo+PiByazMyODggb25seSBzdXBwb3J0IHR3byB3YXlzIHRvIGNvbmZpZyBoZG1pIGF1ZGlv
KEkyUywgUy9QRElGKSwgU28gd2UgdGFrZQo+PiBJMlMgYXMgaGRtaSBhdWRpbyBvcGVyYXRpb24g
aW50ZXJmYWNlcywgYW5kIHRoZW4gdHJlYXQgaGRtaSBhdWRpbyBhcyBhbgo+PiBzdGFuZGFyZCBB
TFNBIGRldmljZXMob25seSBnb3QgcGxhdGJhY2sgZnVuY3Rpb24pLgo+IFRoZXJlIGlzIG5vIG5l
ZWQgZm9yIGR3LWhkbWkgYXVkaW8gdG8gYmUgaW1wbGVtZW50ZWQgYXMgYW4gQVNvQwo+IGRldmlj
ZSAtIGFzIEkndmUgYWxyZWFkeSBzZW50IHBhdGNoZXMgdG8gQW5keSB3aXRoIG15IEFMU0EgZHJp
dmVyCj4gd2hpY2ggaGFzIGJlZW4gYXJvdW5kIGZvciB0aGUgbGFzdCB0d28geWVhcnMsIGFuZCB3
b3JrcyB3ZWxsLCBhbmQKPiBkb2Vzbid0IHJlcXVpcmUgYW55IGFkZGl0aW9uYWwgRFQgZGVzY3Jp
cHRpb24uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
