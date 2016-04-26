From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: add TA5720 digital
 amplifier DT bindings
Date: Tue, 26 Apr 2016 12:00:51 -0500
Message-ID: <20160426170051.GD2885@borg.dal.design.ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-2-git-send-email-dannenberg@ti.com>
 <20160426153707.GZ3217@sirena.org.uk>
 <20160426161425.GA2885@borg.dal.design.ti.com>
 <20160426165006.GD3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 05FDF2612CC
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 19:00:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160426165006.GD3217@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2016 at 05:50:06PM +0100, Mark Brown wrote:
> On Tue, Apr 26, 2016 at 11:14:25AM -0500, Andreas Dannenberg wrote:
> > On Tue, Apr 26, 2016 at 04:37:07PM +0100, Mark Brown wrote:
> > > On Mon, Apr 25, 2016 at 03:17:35PM -0500, Andreas Dannenberg wrote:
> 
> > > > +Optional properties:
> 
> > > > +- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
> > > > +- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
> 
> > > This suggests that the device doesn't need power...  
> 
> > no power, now that would be nice! :)  What this was supposed to mean is
> > that the properties are optional, the power of course is not. The DT has
> 
> They should only be optional if they may really be missing.  We may
> attempt to be liberal in the DTs we accept but we should not encourage
> sloppily written DTs.

Thanks for the guidance and the background. Will move them to "required"
but I'll wait a few more days before re-submitting in case there is
additional feedback on the patch series.

Regards,
Andreas

> 
> > really no control over how I wire up my HW and I'd argue most folks just
> > permanently power the TAS5720 since the shutdown current is just a few
> > uAs IIRC in order to save some BOM cost. But I suppose the DT description
> > is such that the Kernel can more intelligently handle things based on
> > what the driver is doing if somebody choses and implements additional
> > regulator/power switch HW. Or did I misunderstand your point?
> 
> It doesn't really matter if a given system ends up controlling things
> actively, we still want to be consistent in describing them since it is
> less error prone when it does become relevant.
