From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Fri, 13 May 2016 09:04:20 -0500
Message-ID: <20160513140420.GH9174@borg.dal.design.ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
 <20160426154313.GA3217@sirena.org.uk>
 <20160426162240.GB2885@borg.dal.design.ti.com>
 <20160426172936.GE3217@sirena.org.uk>
 <20160426180105.GF2885@borg.dal.design.ti.com>
 <20160513115540.GI22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B6A9260564
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 16:04:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160513115540.GI22038@sirena.org.uk>
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

Mark, please see below...

On Fri, May 13, 2016 at 12:55:40PM +0100, Mark Brown wrote:
> On Tue, Apr 26, 2016 at 01:01:05PM -0500, Andreas Dannenberg wrote:
> > On Tue, Apr 26, 2016 at 06:29:36PM +0100, Mark Brown wrote:
> 
> > > Is the device actually going to mess up if someone sends it something
> > > else or is it just going to ignore the extra bits (given that it's doing
> > > autodetection anyway).
> 
> > well in any of the left-justified modes (which are the only ones the
> > driver supports) the device takes and processes as many bits as it can
> > given the clock and divider settings. Any extra bits provided will get
> > ignored, and the next sync happens on the frame sync signal and not by
> > counting bits so there is no downside also as confirmed by some bench
> > testing I did feeding in 32-bit long frames for one channel. This seems
> > like a case of preferring tolerance over strictly enforcing
> > datasheet-advertised bit-widths. Will take out the check code.
> 
> OK, accepting extra bits is fine.  You should set sig_bits in the DAI so
> userspace can see what's going on if it cares.

I just had a quick look to see what sig_bits does, yes this is a good
addition. Will post a follow-up patch based on the driver that you
already accepted into your tree.

(Btw I'm working on another codec driver and I don't stop getting
positively surprised how flexible and powerful the overall ASoC
framework is).

Regards,
Andreas

> > Along these lines, earlier as I was rummaging through the existing
> > drivers looking for a solution I could model after I noticed that
> > most(?) ASoC codec drivers don't have any type of HW fault checking, at
> > at least whatever drivers I looked at. Not sure why this is but given
> > this discussion this seems like a general opportunity to make
> > improvements.
> 
> There are some with over temperature handling (eg, wm8962) but it's
> relatively uncommon for observable protection features to be implemented
> in silicon and even rarer for the interrupts to be hooked up (and hence
> useful to support in software) unless there is also accessory detection
> in the device.  On older devices the required digital logic was often
> excessively expensive and realistically only relatively high power
> speaker drivers have much risk of something going wrong - things like
> headphone outputs or smaller speaker drivers end up with protection from
> their supplies collapsing well before the device is in physical danger.
