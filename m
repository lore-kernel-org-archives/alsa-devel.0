From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 16:19:28 +0000
Message-ID: <20100322161928.GA30295@rakim.wolfsonmicro.main>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221646.08974.peter.ujfalusi@nokia.com>
	<20100322150602.GD1379@rakim.wolfsonmicro.main>
	<201003221731.14380.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FA9410385C
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 17:19:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003221731.14380.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 22, 2010 at 05:31:14PM +0200, Peter Ujfalusi wrote:
> On Monday 22 March 2010 17:06:03 ext Mark Brown wrote:

> > Remember, the register cache is below the controls and transparent to
> > them - if the controls haven't written a value to the chip then it will
> > not appear in the register cache so other controls will not be affected.

> Yes, but it also means, that the change will be not visible at all.
> I mean, if we did not update the reg_cache (when we should not write to the HW), 
> than that change will be gone.
> So you will only be able to change the gain on the output, when the path is 
> active?

No, the control will have to take care of only writing to the chip when
it knows it's safe to do so.

> Also, I think, if we can somehow prevent the gain change on the HW, when the 
> associated DAPM widget is not active, we would still have the problem of the 
> DAPM_MIXER. That operates from the cache, and if the cache has no 0 for the 
> gain, than that will be written to the chip.

Once again, the cache is operating below the controls transparently to
them.  If the controls haven't written a value to the chip then the
write won't have gone to the register cache either and so other parts of
the system won't be affected.  As far as the control layer is concerned
the register cache and the hardware are identical - I'm not sure why you
believe that they are separate.

Please take a look at the old PGA code I mentioned, it implements this
without any problem.  The control suppresses the write unless the
widget is powered, storing the value separately.  If the widget is
powered down then the registers aren't referred to at all when the
control is accessed.

> How I see this: we can go and introduce new controls, DAPM widgets for all type 
> just for the sake of the TWL codec. But at the end it will be still TWL 
> specific.

> I'm not saying that other codecs could not use some generic way (in a way, that 
> you have described) to make their amps muted when they are not needed.
> What I'm saying, is that I don't see a generic way which can handle the TWL 
> codec.

Could you please be more specific about what you believe is going on
with TWL4030 here?  It would really help if you could be more specific
about how you see the register cache getting updated.
