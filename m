From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Tue, 26 Apr 2016 13:01:05 -0500
Message-ID: <20160426180105.GF2885@borg.dal.design.ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
 <20160426154313.GA3217@sirena.org.uk>
 <20160426162240.GB2885@borg.dal.design.ti.com>
 <20160426172936.GE3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id B27CC26154F
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 20:01:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160426172936.GE3217@sirena.org.uk>
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

On Tue, Apr 26, 2016 at 06:29:36PM +0100, Mark Brown wrote:
> On Tue, Apr 26, 2016 at 11:22:40AM -0500, Andreas Dannenberg wrote:
> > On Tue, Apr 26, 2016 at 04:43:13PM +0100, Mark Brown wrote:
> 
> > > If the driver doesn't do anything just remove the code.
> 
> > Well it's doing something which is making sure the nobody passes in a
> > sample size that's not supported. Wouldn't we want to catch this?
> 
> Is the device actually going to mess up if someone sends it something
> else or is it just going to ignore the extra bits (given that it's doing
> autodetection anyway).

Hi Mark,
well in any of the left-justified modes (which are the only ones the
driver supports) the device takes and processes as many bits as it can
given the clock and divider settings. Any extra bits provided will get
ignored, and the next sync happens on the frame sync signal and not by
counting bits so there is no downside also as confirmed by some bench
testing I did feeding in 32-bit long frames for one channel. This seems
like a case of preferring tolerance over strictly enforcing
datasheet-advertised bit-widths. Will take out the check code.

> 
> > > > +	if ((curr_fault & TAS5720_OCE) && !(tas5720->last_fault & TAS5720_OCE))
> > > > +		dev_warn(dev, "The Class-D output stage has experienced an over current event\n");
> 
> > > "Class D over current".  The verbosity is making the line over long and
> > > the phrasing is a bit unclear (and makes it seem less critical than it
> > > really is).  These should probably be dev_crit() or somthing too, over
> > > current and similar events on a speaker output are generally extremely
> > > serious.
> 
> > The overlong line goes through checkpatch --strict and looks like an
> > accepted practice to prevent breaking "grep" for example. The text is
> > more or less from the datasheet to give people something they can
> > cross-associate. But I can try to short this a bit.
> 
> It's not just the fact that it's wrapping round to the next line, it's
> also the fact that it's very weakly phrased for something which might
> reasonably indicate an actual fire risk.  I'm pretty sure people will
> not struggle excessively to find the reference to over current in the
> datasheet.

Ok will tweak it.

> > conditions.  For the "over temp" error condition (which is actually
> > really hard to create on the bench, I've to get the EVM up to like 150C
> > and things start smelling a bit) this should probably be dev_crit() as
> 
> If the silicon is flagging an over temperature condition that tends to
> indicate a catastrophic physical failure in the system, it is likely
> that the speaker itself has failed or there's otherwise a short in the
> speaker output path and potentially other physical damage especially in
> smaller systems where you might find that for example there's thermal
> damage to the case (and possibly even the user).

Yes make sense. As suggested promoting this to dev_crit() and making sure
its adequately phrased will help.

> 
> > well. And then, maybe leave the "DC error" as a warning, since it's less
> > critical than the other two conditions. Thoughts?
> 
> If you're pushing DC through a speaker that will generally mean that you
> will shortly see one or both of the over current and over temperature
> errors, it's really not something they're designed for.

I had to actually craft my own DC "audio" file to play with aplay to
trigger this error during testing. So when this happens I'd think it is
likely something userspace is "doing wrong" (of course there could be
other reasons too such a broken-off SAIF DIN/DOUT trace) but let's make
this also for the sake of consistency a dev_crit() too.

Along these lines, earlier as I was rummaging through the existing
drivers looking for a solution I could model after I noticed that
most(?) ASoC codec drivers don't have any type of HW fault checking, at
at least whatever drivers I looked at. Not sure why this is but given
this discussion this seems like a general opportunity to make
improvements.

Regards,
Andreas
