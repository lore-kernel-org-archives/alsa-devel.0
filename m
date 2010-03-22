From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 15:06:03 +0000
Message-ID: <20100322150602.GD1379@rakim.wolfsonmicro.main>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003221604.56497.peter.ujfalusi@nokia.com>
	<20100322141543.GC1379@rakim.wolfsonmicro.main>
	<201003221646.08974.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C7A524405
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 16:06:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003221646.08974.peter.ujfalusi@nokia.com>
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

On Mon, Mar 22, 2010 at 04:46:08PM +0200, Peter Ujfalusi wrote:
> On Monday 22 March 2010 16:15:44 ext Mark Brown wrote:

> > I don't see any fundamental problem here - mostly this just maps on to
> > "if the widget is powered on write this value, otherwise write the
> > value configured by the control.".

> Hmm, I suppose it could be possible to pass the name of the DAPM widget, a 
> bitmask to a control...
> Than in the handler in the core we could walk through the DAPM widgets, and find 
> the one, check the status, and if it is on, we allow the write, otherwise we 
> could use the mask to write only the things, that it is needed.

Something like that, yes - the walk could happen at startup time to
avoid having to do it repeatedly.

> But, in TWL case I'd like to filter out also the writes which is done by the 
> DAPM widgets (which is visible from the user space, the mixers).
> As it is now, if user changes the mixer, which is associated with DAPM widget 
> (and it is different than the PGA, they are DAPM_MIXER), than that write goes 
> directly to the register, and this write takes the cached value, makes the 
> changes and than writes it to register. This also enables the gain (which 
> enables the amp, which takes power).

Remember, the register cache is below the controls and transparent to
them - if the controls haven't written a value to the chip then it will
not appear in the register cache so other controls will not be affected.

> > Well, I was rather hoping I could convince you to make this more
> > generic.  But if that's not possible then yes, please do make the commit
> > message clearer.

> I need to study other codes as well, before I could start doing something more 
> generic, which I totally agree would be beneficial for others as well.
> But for now, I would like to update the commit message, and come back later, and 
> revisit the possibility of similar, and more generic ways of doing this.

I guess.
