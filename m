From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Tue, 26 Apr 2016 11:22:40 -0500
Message-ID: <20160426162240.GB2885@borg.dal.design.ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
 <20160426154313.GA3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9662608B3
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 18:22:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160426154313.GA3217@sirena.org.uk>
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

Hi Mark, thanks for the continued feedback, please see below...

On Tue, Apr 26, 2016 at 04:43:13PM +0100, Mark Brown wrote:
> On Mon, Apr 25, 2016 at 03:17:36PM -0500, Andreas Dannenberg wrote:
> 
> This looks mostly good, a few small things below.
> 
> > +	switch (width) {
> > +	case 16:
> > +	case 18:
> > +	case 20:
> > +	case 24:
> > +		/*
> > +		 * We only support the different left-justified serial audio
> > +		 * formats in which case there is nothing to configure in the
> > +		 * TAS5720.
> > +		 */
> > +		break;
> > +	default:
> > +		dev_err(codec->dev, "unsupported sample size: %d\n", width);
> > +		return -EINVAL;
> > +	}
> 
> If the driver doesn't do anything just remove the code.

Well it's doing something which is making sure the nobody passes in a
sample size that's not supported. Wouldn't we want to catch this?

> 
> > +	if ((curr_fault & TAS5720_OCE) && !(tas5720->last_fault & TAS5720_OCE))
> > +		dev_warn(dev, "The Class-D output stage has experienced an over current event\n");
> 
> "Class D over current".  The verbosity is making the line over long and
> the phrasing is a bit unclear (and makes it seem less critical than it
> really is).  These should probably be dev_crit() or somthing too, over
> current and similar events on a speaker output are generally extremely
> serious.

The overlong line goes through checkpatch --strict and looks like an
accepted practice to prevent breaking "grep" for example. The text is
more or less from the datasheet to give people something they can
cross-associate. But I can try to short this a bit.

You made a good point with the dev_crit(), I can certainly promote this
over current condition.  It happens for example if I drive too big of a
load (a heavy-duty jumper wire in my case, simulating a short of the
output stage).  If so, we should also consider the other two fault
conditions.  For the "over temp" error condition (which is actually
really hard to create on the bench, I've to get the EVM up to like 150C
and things start smelling a bit) this should probably be dev_crit() as
well. And then, maybe leave the "DC error" as a warning, since it's less
critical than the other two conditions. Thoughts?

Regards,
Andreas
