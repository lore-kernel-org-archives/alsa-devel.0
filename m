From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: snd_pcm_writei() -last value sustained
Date: Thu, 17 Jul 2008 14:56:50 +0100
Message-ID: <200807171456.50182.gineera@aspect135.co.uk>
References: <200807040938.53662.gineera@aspect135.co.uk>
	<200807161222.07440.gineera@aspect135.co.uk>
	<200807161301.08608.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 029952438D
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 15:38:08 +0200 (CEST)
In-Reply-To: <200807161301.08608.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 July 2008 13:01, Alan Horstmann wrote:
> On Wednesday 16 July 2008 12:22, Alan Horstmann wrote:
> > On Wednesday 16 July 2008 00:15, you wrote:
> > > At Mon, 7 Jul 2008 14:53:35 +0100,
>
> (snip)
>
> > > Well, I'd call it's a hardware "feature".  No other hardwares do like
> > > that.
> > >
> > > As a workaround, we'll need to put zero'ed short samples before
> > > actually stopping the stream.
> > >
> > > I wonder whether this also occurs to pause operation, too.  In the
> > > case of pause, it's a tougher problem...
> >
> > Thanks for the response on this one.  I'm not sure how to test pause,
> > unless xmms uses that for 'PAUSE' button action, when the same effect is
> > seen.
> >
> > I did try setting various values for silence threshold and size, and when
> > (as per the original test) writing 1 period of sine followed by a 2nd
> > writei of experimental data, silence values could be found that would
> > eliminate the 'sustain effect'.  However, when only the single period
> > writei occured I could not find any effective values.
> >
> > Unsurprisingly, my other ice1712 card, ST Audio /Hoontech DSP2000 shows
> > the same effect, so if it is a 'hardware feature' it presumably relates
> > to the way the envy24 chip operates?
> >
> > How would I go about experimenting with zeroing the stream just before
> > stopping?  Do you mean in _pro_trigger()?
>
> Further info, I noticed in the envy24 datasheet, (rev 2.2 1.03.00) p 4-24
> states (near bottom of page)
>
> '... when DMAs are stopped, the last latched value is retained.  This "DC"
> value ...'
>
> so you were right about 'hardware feature'!

Perhaps I should mention now another odd effect I am getting on this card.  
Using the same pcm.c test code, if after writei() 1 period of sine I write, 
say 1/3 period from a zeroed samples area, what I see is 1 period of sine 
followed by 1/3 period of zero, then 2/3 period of sine, apparently appearing 
out of nowhere.  (Presumably from the sound buffers somewhere).

This suggests to me that the pcm system, once started, is always transfering a 
full period, even if there is not a full period of new data.  Is this 
possible or to be expected, or another feature of the hardware?  In other 
cases where I simply writei() less than 1 period of data I see phantom 
garbage following on to a complete period size.

How can I trace this further, as it is deeper than my present Alsa knowledge 
(apart from the slow process of learning of course!).

Thanks

Alan
