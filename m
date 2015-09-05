From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
Date: Sat, 5 Sep 2015 09:31:08 +0100
Message-ID: <20150905083107.GK21084@n2100.arm.linux.org.uk>
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
cm90ZToKPiBBS0E6IGp1c3QgcmVwbGFjZSB5b3VyIGVudGlyZSAiY29tcHV0ZV9uIiBmdW5jdGlv
biB3aXRoOgo+IAo+IHJldHVybiAoMTI4ICogZnJlcSkgLyAxMDAwOwo+IAo+IC4uLmFuZCBpdCdz
IDEwMCUgc2ltcGxlciBfYW5kXyBnZXRzIHlvdSBhIChtYXJnaW5hbGx5KSBiZXR0ZXIgcmF0ZQo+
IChhc3N1bWluZyB5b3UgcmVhbGx5IGhhdmUgMjIuMTc1MDAwKS4gIElmIGl0IHdhcyBqdXN0IGFi
b3V0IGEKPiAzMjAwMC4yMjIgdnMgMzIwMDAgSSdkIG5vdCBiZSBzYXlpbmcgYW55dGhpbmcgcmln
aHQgbm93LiAgSXQncyBhYm91dAo+IGFkZGluZyBjb21wbGV4aXR5LgoKTm8uICBJdCBkb2Vzbid0
IHdvcmsgZm9yIGFsbCBjYXNlcy4gIERvIHRoZSBjYWxjdWxhdGlvbnMgZm9yIGV2ZXJ5CnNhbXBs
ZSByYXRlIGluIHRob3NlIHRhYmxlcyBpbiB0aGUgSERNSSBzcGVjLCBhbmQgeW91J2xsIGZpbmQg
b3V0CndoeS4KCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lOiBjdXJyZW50bHkg
YXQgOS42TWJwcyBkb3duIDQwMGticHMgdXAKYWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5uZXQuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
