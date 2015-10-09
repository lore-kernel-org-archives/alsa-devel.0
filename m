From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: add rockchip
 tranceiver bindings
Date: Fri, 09 Oct 2015 13:52:08 +0200
Message-ID: <1444391528.9895.274.camel@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1444311079-2892-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAL_JsqL_ox3TtjAL552X8-D21n47_hBCpeSkUcNdZu6+wj2h3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id CEAAB265011
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:52:12 +0200 (CEST)
In-Reply-To: <CAL_JsqL_ox3TtjAL552X8-D21n47_hBCpeSkUcNdZu6+wj2h3A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hey Rob,

On Thu, 2015-10-08 at 11:50 -0500, Rob Herring wrote:
> On Thu, Oct 8, 2015 at 8:31 AM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> > Add devicetree bindings for the spdif tranceiver found on
> > found on rk3066, rk3188 and rk3288 SoCs
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > 
> > ---
> > 
> > Changes in v4:
> > - Require rockchip,grf on RK3288 as the 8 channel solution has to
> > be
> >   selected on that SoC
> > - Make the compatibility string one of a known list rather then
> >   requiring a precise list of options.
> > - Change the clock names to hclk and mclk instead of spdif_hclk and
> >   spdif_mclk to better match the implementation and data sheets.
> > 
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  .../devicetree/bindings/sound/rockchip-spdif.txt   | 44
> > ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/rockchip-spdif.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/rockchip
> > -spdif.txt b/Documentation/devicetree/bindings/sound/rockchip
> > -spdif.txt
> > new file mode 100644
> > index 0000000..33dd82c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
> > @@ -0,0 +1,44 @@
> > +* Rockchip SPDIF transceiver
> > +
> > +The S/PDIF audio block is a stereo transceiver that allows the
> > +processor to receive and transmit digital audio via an coaxial
> > cable or
> > +a fibre cable.
> > +
> > +Required properties:
> > +
> > +- compatible: should be one of the following:
> > +   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
> > +     "rockchip,rk3066-spdif"
> > +- reg: physical base address of the controller and length of
> > memory mapped
> > +  region.
> > +- interrupts: should contain the SPDIF interrupt.
> 
> > +- #address-cells: should be 1.
> > +- #size-cells: should be 0.
> 
> Why do you need these? Are you going to have sub nodes?

Oh good spot, it looks like I indeed don't need this. (for reference,
this came from the rockchip i2s' drivers device-tree documentation and
i mindlessly left it in).

Thanks!,

-- 
Sjoerd Simons
Collabora Ltd.
