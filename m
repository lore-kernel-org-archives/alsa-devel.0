From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_sai: Add clock controls for SAI
Date: Tue, 15 Apr 2014 10:26:58 +0800
Message-ID: <20140415022656.GC7197@MrMyself>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <12898efab7a5907e6ed1c438a486692f59ef9d8b.1396432924.git.Guangyu.Chen@freescale.com>
 <20140414204331.GE25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140414204331.GE25182@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: shawn.guo@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2014 at 09:43:31PM +0100, Mark Brown wrote:
> On Wed, Apr 02, 2014 at 06:10:19PM +0800, Nicolin Chen wrote:
> 
> > -- clock-names : Must include the "sai" entry.
> > +- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
> > +  "mclk3" for bit clock and frame clock providing.
> 
> This breaks compatibilty with old DTs - it just removes the "sai" name.
> It's OK to deprecate the "sai" clock name but you need to keep support
> for DTs that only specify that, there's no code for that left in the
> driver.

Sir, you've already applied the v6 of this patch last week :)
And I can still find it in topic/fsl-sai.

ca3e35c ASoC: fsl_sai: Add clock controls for SAI

And regarding the old DTs compatibilty, Shawn has already reminded me
in his comments against one of the version. I took his advice and made
the patch compatible with the old 'sai' clock binding within that v6.

Thank you,
Nicolin

