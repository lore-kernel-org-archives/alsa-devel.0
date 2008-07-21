From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Mon, 21 Jul 2008 15:15:18 +0400
Message-ID: <20080721111518.GA17872@polina.dev.rtsoft.ru>
References: <20080703143714.GA7003@polina.dev.rtsoft.ru>
	<20080703144254.GB652@sirena.org.uk>
	<B615D57E-324C-4812-997C-9E5C90FDE967@freescale.com>
	<20080704154313.GA11635@polina.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 63D93245F6
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 13:15:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080704154313.GA11635@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2008 at 07:43:13PM +0400, Anton Vorontsov wrote:
[...]
> >>> Since we're using SSI in synchronous mode, the STCCR register  
> >>> controls
> >>> both the receive and transmit sections. So, when we're trying to  
> >>> record
> >>> anything, stccr register does not get initialized, thus the output  
> >>> file
> >>> filled with the white noise.
> >>
> >>> Fix this by initializing the STCCR for both playback and capture. If
> >>> TX/RX widths don't match, return that we're busy at the moment.
> >>
> >>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >>
> >> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >>
> >> but Timur needs to ack it since I don't have any particular knowledge 
> >> of
> >> the hardware.
> >
> > Anton has the right idea, but I'm not sure the fix is the best.  I was  
> > planning on posting my fix after I got back from vacation.
> >
> > Part of the problem is that STCK and SRCK can be wired together, which  
> > means that even though you're not in synchronous mode, the sample rates 
> > have to match.  For the 8610 HPCD, this isn't a problem, but the SSI 
> > driver is supposed to support more than just that board.  We need device 
> > tree additions to cover all cases.
> 
> Ok, we can set both.
> 
> > Anton, are you sure returning -EBUSY is the right fix? 
> 
> Since we're using prepare(), yes. But we probably should use
> hw_params() and return -EINVAL.
> 
> > Would this make 
> > applications like mplayer detect the problem and automatically pick a 
> > matching sample format that does work?
> 
> I don't think that anyone tries to negotiate if/when prepare() failed.
> But if hw_params() failed, then yes. Here is updated patch.
> 
> Also new patch for the codec used on the HPCD: it seem has the similar
> issue, but wrt sampling rate.

Timur, have you had a chance to look into these two patches?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
