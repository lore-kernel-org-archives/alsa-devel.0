From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ASoC: kirkwood: add S/PDIF support
Date: Sun, 20 Oct 2013 18:56:27 +0100
Message-ID: <20131020175627.GP25034@n2100.arm.linux.org.uk>
References: <20131018203750.7b981d62@armhf>
 <20131020171255.GP2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B2FB2261717
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 19:57:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131020171255.GP2443@sirena.org.uk>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 20, 2013 at 06:12:55PM +0100, Mark Brown wrote:
> On Fri, Oct 18, 2013 at 08:37:50PM +0200, Jean-Francois Moine wrote:
> > This patch adds S/PDIF input/output for mvebu DT boards.
> 
> This looks basically good, thanks.  A couple of things though:
> 
> > +	if (dai->name[0] == 'i')
> > +		ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
> > +	else
> > +		ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
> > +
> 
> This works and isn't actively a problem but it's not really normal
> either - the normal thing would be to use dai->id.
> 
> > +static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
> > +    {
> > +	.name = "i2s",
> > +	.playback = {
> 
> This should cause problems for the existing (non-DT) machine drivers?
> They're using cpu_dai_name to bind the CPU DAI and you're now setting an
> explicit name instead of letting the dev_name() be used.  The patch
> should be updating those machine drivers too unless I'm missing
> something.

For your information, I intend to nobble you and Liam at the kernel
summit and knock your two heads together over this.  You both have
been dysfunctional over this driver and its about time someone banged
some sense into you both.
