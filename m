From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH v4 2/9] ASoC: Intel: Skylake: Add
 set_tristate DAI ops to enable SSP MCLK
Date: Tue, 10 Jan 2017 15:01:13 +0530
Message-ID: <20170110093112.GA15578@kpjeeja-desk>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
 <1483341277-14475-3-git-send-email-jeeja.kp@intel.com>
 <20170106183233.n6vbqzyczkclnbtc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ADC4266CC3
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 10:20:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170106183233.n6vbqzyczkclnbtc@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2017 at 06:32:33PM +0000, Mark Brown wrote:
> On Mon, Jan 02, 2017 at 12:44:29PM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Some machine requires MCLK to be enabled before SSP start up, so add
> > set_tristate() DAI ops to enable/disable SSP MCLK. This ops will be
> > called from machine which requires early MCLK and removes the usage of
> > enabling early MLCK in platform DAI prepare by default which is not
> > machine specific.
> 
> This isn't an *obvious* use of the tristate operation...
> 
> > +	/*
> > +	 * To enable ssp clk explicitly before gateway copier is configured,
> > +	 * need to use dma control IPC.
> > +	 * Disable will be done when DSP gateway copier modules are deleted.
> > +	 */
> > +	if (!tristate)
> > +		return skl_dsp_set_dma_control(ctx, mconfig);
> 
> So we never clear this?  And to be frank I'd have no idea looking at
> this that it's doing anything to do with clocks though that's a bit of a
> separate thing.  It feels like DAPM might be a more natural place to do
> this, have a clock widget supplying the AIF widget for the interface.
> That'd be a bit more idiomatic.
The clk will be cleared, when DSP pipeline is deleted, that is when audio device
is closed. 
My bad, yes this is not the correct usage of tristate operation, we need to model
it as a clock supply widget, will rework on this patch.
-- 
