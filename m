From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/4] ASoc: kirkwood: simplify probe error
Date: Sat, 3 Aug 2013 17:10:29 +0100
Message-ID: <20130803161029.GD23006@n2100.arm.linux.org.uk>
References: <20130731081739.76aae84c@armhf> <20130803123954.GX23006@n2100.arm.linux.org.uk> <20130803175513.7b765b0d@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130803175513.7b765b0d@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 03, 2013 at 05:55:13PM +0200, Jean-Francois Moine wrote:
> On Sat, 3 Aug 2013 13:39:54 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > This doesn't apply to mainline as there's a clk_put() there.
> 
> Right, it applies to linux-next:
> 
> On Fri, 26 Jul 2013 11:32:50 +0100, Mark Brown <broonie@kernel.org> wrote:
> 
> > Always submit against where the code will be applied - -next in this
> > case.

Sorry, I'm just not going to bother with your patches unless you start
posting them in such a way that interested parties can test them without
having to run around and pull random trees.  In other words, you should
have Cc'd interested parties on that devm_* change patch - especially
myself as I was the one who introduced that code.
