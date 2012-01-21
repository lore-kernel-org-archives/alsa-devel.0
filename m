From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to
 set the msbits constraint"
Date: Sat, 21 Jan 2012 15:20:42 +0000
Message-ID: <20120121152041.GC10751@opensource.wolfsonmicro.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
	<1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
	<20120119182602.GM3178@opensource.wolfsonmicro.com>
	<4F1861E6.1000700@ti.com>
	<20120119190701.GN3178@opensource.wolfsonmicro.com>
	<4F1AC612.3090808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 989EA103807
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:20:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F1AC612.3090808@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 21, 2012 at 04:05:06PM +0200, Peter Ujfalusi wrote:

> AFAIK we only place this constraint to 32bit samples. I have not
> encountered any other HW limitation.
> What if we just simply convert the msbit core support to apply the
> constraint to 32 bit samples only?

I do think we can safely drop the 8 and 16 bit entries from the array,
even where there are lower accuracy devices (like basebands) I can't see
anyone caring.  However I think if we go and check there's also going to
be some cases where 24 bit will be used due to 16-23 bit ADCs and DACs,
grep turned up a few non-ASoC devices using 20 bits for example.  

> With the current code we are not able to apply different constraint to
> different sample size anyway.
> Locally I have added the support for this, but it looks like over
> engineering.

I can't think of any hardware where that would be required, as I as far
as I am aware this mostly comes from devices using a fixed internal
resolution independant of the audio interface format.

> I have the patch(s) for both way, but I think we are better off if we
> support 32 samples only (simple, clean, covers 99% of use case, well as
> it is now it covers 100%).

The 32 bit only one is better, yes, though like I say I think will have
to add in the 24 bit case again if it gets dropped.

> > We've got real CPU consumption problems in ASoC - the DAPM algorithm is

> And things aren't getting any simpler. For sure we need to do something
> about this.

Yeah, I will probably actually do something about the stream start/stop
soon as it's inconvenient for the CODEC<>CODEC link stuff.

> > We'll all get *much* more benefit from working on improvements of things
> > like that (and on the memory consumption which isn't great either and
> > probably manages to burn measurable CPU cycles due to cache misses) than
> > we ever will from anything we do with this code.
> 
> You know Mark, I'm an engineer. It bothers me. It bothers me more since
> I _know_ it is there. I just can not help myself...

One way or another I've always done a lot of work on old code and code
I'm not familiar with and obviously recently I've been doing a lot of
review as well so I do tend to value maintainability really highly, if
only from a "do unto others" point of view.
