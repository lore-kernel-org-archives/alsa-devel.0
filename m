From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: sgtl5000: fix devres handling
Date: Mon, 30 Jun 2014 15:47:43 +0100
Message-ID: <20140630144743.GB32514@n2100.arm.linux.org.uk>
References: <E1X1YLq-0004E1-MT@rmk-PC.arm.linux.org.uk>
 <20140630144417.GY23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 09258261A76
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 16:47:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140630144417.GY23300@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 30, 2014 at 03:44:17PM +0100, Mark Brown wrote:
> On Mon, Jun 30, 2014 at 10:58:18AM +0100, Russell King wrote:
> 
> > You may wish to give some consideration to whether ASoC core code should
> > be doing this instead, this is probably a very common source of brokenness
> > where two-stage driver initialisation exists.  These kinds of issues are
> > why I consider (as a general rule) that two-stage driver initialisation
> > is really bad.
> 
> What we've been doing here is getting everyone to move their resource
> allocation to the device level probe where it should be, leaving only
> things that genuinely need the card to be there (mainly controls and so
> on) in the ASoC level probe.  Is that possible for this device - now
> that it's been converted to regmap I'd expect so?

I have no idea, and I can't help beyond this patch.  Needless to say
that the driver as it stands right now oopses the kernel when you
try and remove it, so it really needs fixing.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
