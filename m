From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver driver
Date: Wed, 19 Aug 2015 09:28:06 +0200
Message-ID: <2559509.ITzpmR5XN3@phil>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk> <1463451.tH10lfH9Hm@phil> <1439967408.4135.84.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439967408.4135.84.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Sjoerd,

Am Mittwoch, 19. August 2015, 08:56:48 schrieb Sjoerd Simons:
> Hey Heiko,
> 
> Thanks for the comments, i'm hoping to address them and Marks comments
> in a next patch series next week.
> 
> On Tue, 2015-08-18 at 20:25 +0200, Heiko Stuebner wrote:
> > > +
> > > +     spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");
> > 
> > I guess this could be named just "hclk" - as it is the identifier
> > local to the spdif-ip. (Of course in the binding too)
> 
> I'm entirely happy to change that, just wanted to note that the reason
> i used spdif_hclk and spidf_clk is for consistency with the rockchip
> -i2s binding which uses i2s_hclk ans i2s_mclk.

I was also just remembering something Thierry Reding said in the edp thread: 
"The names are in a per-driver scope, so "dp-phy" is implied by the device 
tree binding and driver already. You could simply use shorter names such as 
"phy" and "24m" for example."


> However i guess we could update the i2s binding at some poit as well to
> follow similar names (with fallbacks to the old one). In general a lot
> of the comments yourself and Mark have given actually apply to the
> rockchip-i2s code as well so there is some cleanup to do there :)

I'm not sure about updating the binding though, as it we'd need to provide 
backwards-compatibility for the old names as well. So I don't think renaming 
these will bring much benefit, but we can choose better names for followup 
drivers like the spdif.

I haven't looked to much into the i2s stuff yet. But with me getting a grasp on 
the fractional dividers and the hardware drivers making it into the asoc tree 
now, I also plan to give the i2s audio on the Chromebooks a try :-)


Heiko
