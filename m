From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] [RFC] sis7019: Initial support for
	the	SiS	7019 Audio Accelerator
Date: Tue, 09 Oct 2007 07:48:14 -0400
Message-ID: <1191930494.27906.8.camel@obelisk.thedillows.org>
References: <11915588983461-git-send-email-dave@thedillows.org>
	<s5hzlysty91.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 79A1A1038D9
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 13:48:25 +0200 (CEST)
In-Reply-To: <s5hzlysty91.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-10-09 at 11:48 +0200, Takashi Iwai wrote:
> At Fri,  5 Oct 2007 00:34:58 -0400,
> Dave Dillow wrote:
> > 
> > Basic audio support for the SiS 7019 Audio Accelerator as found in
> > the SiS 55x SoC. There is currently no synth or power management
> > support at the moment, but the audio playback has been tested with
> > several channel and rate combinations, as well as various period
> > and buffer configurations.
> > 
> > Signed-off-by: David Dillow <dave@thedillows.org>
> 
> Thanks for the patch.  The code looks almost OK to me.
> 
> Below is a very brief review.

Great, thanks for the review! I'll fix up the issues you pointed out,
and I hope to have hardware for testing again next week -- I've got an
untested implementation of power management coded up. Aside from the PM
code, this driver has been in production for almost a year. 

I'll also diff this against alsa-driver, instead of the kernel proper.

> > diff --git a/include/sound/sis7019.h b/include/sound/sis7019.h
> 
> Any reason to put this to include/sound?  It's basically a place for
> headers used publicly.  If the header is for the driver-only, better
> placed in sound/pci or a place where is private.

I agree, I was just following several other driver's lead, specifically
trident. I'll be happy to move it.


> > +struct sis7019 {
> > +	long unsigned  ioport;
> 
> unsigned long is a more common style.

Doh! It's also the style I use everywhere else in the driver.

> You need to unlock sis->hw_lock before calling
> snd_pcm_period_elapsed().  It may call snd_pcm_stop() at XRUN, and
> this invokes the trigger callback, which locks hw_lock again.
> Simply re-acquire hw_lock after calling snd_pcm_period_elapsed().

Can do.

Dave
