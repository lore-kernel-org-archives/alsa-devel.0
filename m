From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Fri, 19 Aug 2016 00:26:42 +0100
Message-ID: <20160818232642.GF1041@n2100.armlinux.org.uk>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id A81432663E5
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 01:26:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1471545449-29516-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2016 at 07:37:29PM +0100, Mark Brown wrote:
> Both the card and DAPM cleanups recursively delete their debugfs
> directories.  Since the DAPM debugfs subdirectory for the card is
> located within the card debugfs this means we end up trying to double
> free the DAPM subdirectory.  Reorder the cleanup to free the card
> debugfs after we've cleaned up DAPM and it has deleted its own
> subdirectory.
> 
> Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Not tested at all yet, just about done for today.

Thanks - that appears to solve the oops on rmmod of
snd-soc-omap-abe-twl6040!

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

So this allows me to test a bit more... and there's more bad news.
On re-inserting this module...

twl6040 0-004b: Unable to sync registers 0xc-0xd. -121
genirq: Flags mismatch irq 242. 00000004 (McPDM) vs. 00000004 (McPDM)
omap-mcpdm 40132000.mcpdm: Request for IRQ failed
omap-mcpdm 40132000.mcpdm: ASoC: failed to probe DAI 40132000.mcpdm: -16
omap-abe-twl6040 sound: ASoC: failed to instantiate card -16
omap-abe-twl6040 sound: snd_soc_register_card() failed: -16
omap-abe-twl6040: probe of sound failed with error -16

Looks like removing and re-inserting these modules has never been
tested. :(  And oh my...

static int omap_mcpdm_probe(struct snd_soc_dai *dai)
{
        ret = devm_request_irq(mcpdm->dev, mcpdm->irq, omap_mcpdm_irq_handler,
                                0, "McPDM", (void *)mcpdm);

static struct snd_soc_dai_driver omap_mcpdm_dai = {
        .probe = omap_mcpdm_probe,
        .remove = omap_mcpdm_remove,

Using devm_* stuff in a context where it doesn't get automatically
freed when the DAI driver is unbound, and nothing in omap_mcpdm_remove()
to undo that request.

I suspect that isn't the full story though, because of the regmap
complaint (which I've not even looked at yet.)

At the moment, omap_mcpdm_probe() should _not_ be making use of any
devm_* calls, and omap_mcpdm_remove() should be _explicitly_ releasing
everything that was claimed in omap_mcpdm_probe() because ASoC does
nothing with devres groups.  The alternative solution here is that
ASoC gains devres group support so resources claimed in the DAI
driver .probe function can be automatically released in the same way
as happens with normal driver model probe/release and component
helper bind/unbind.

Maybe we should have a test mode in the kernel where every device
goes through a bind-unbind-rebind sequence during boot to test more
of these paths...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
