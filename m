From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
Date: Sat, 5 Sep 2015 09:34:22 +0100
Message-ID: <20150905083422.GL21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBTZXAgMDQsIDIwMTUgYXQgMDc6MDM6MTFQTSAtMDcwMCwgRG91ZyBBbmRlcnNvbiB3
cm90ZToKPiBUaGVuIHBlcmhhcHMgeW91IHNob3VsZG4ndCBiZSB1c2luZyBhIHN3aXRjaCBzdGF0
ZW1lbnQuICBZb3Ugd29uJ3QKPiBjYXRjaCBhbGwgdmFsdWVzIHRoYXQgYXJlIHdpdGhpbiAuMDUl
IG9mICgyNS4yIC8gMS4wMDEpLgoKTm8uCgpUaGUgY2xvY2sgcmF0ZXMgeW91IGdldCB1bHRpbWF0
ZWx5IGNvbWUgZnJvbSB0aGUgRURJRCB2aWEgZWl0aGVyIHRoZQpkZXRhaWxlZCB0aW1pbmcgbW9k
ZXMgb3IgZnJvbSB0aGUgQ0VBIG1vZGUgSURzLCB3aGljaCBhcmUgdGhlbiBsb29rZWQKdXAgaW4g
dGFibGVzIGluIHRoZSBEUk0gRURJRCBwYXJzaW5nIGNvZGUuCgpFaXRoZXIgd2F5LCB5b3Ugd2ls
bCBlbmQgdXAgd2l0aCAyNTE3NSBhbmQgbm90IDI1MTcwIG9yIHNvbWV0aGluZwpzdHJhbmdlIGJh
c2VkIG9uIHdoYXQgdGhlIHBsYXRmb3JtIGRvZXMuCgotLSAKRlRUQyBicm9hZGJhbmQgZm9yIDAu
OG1pbGUgbGluZTogY3VycmVudGx5IGF0IDkuNk1icHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGlu
ZyB0byBzcGVlZHRlc3QubmV0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
