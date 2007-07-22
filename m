From: stan <stanl@cox.net>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Sun, 22 Jul 2007 12:56:39 -0700
Message-ID: <20070722125639.350d6a11@localhost.localdomain>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<s5hy7hcu49f.wl%tiwai@suse.de> <20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 3627B10380C
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jul 2007 21:56:44 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao102.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070722195639.NDYG1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2007 15:56:39 -0400
In-Reply-To: <200707201333.38449.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Jul 2007 13:33:38 +0100
Alan Horstmann <gineera@aspect135.co.uk> wrote:

[snip]

> I have less concern with dmix than the hidden rate conversion, but
> would happily loose both.  Using "hw" forces use of 12 capture and 10
> playback channels in this case, doesn't it?  So I need some plugin to
> play 2 channels?
> 
> There are 2 issues for me:
> 
> 1. With the cards rate state = 'locked' alsa (not sure what bit of
> it) was unable to set the desired clock rate, yet did not report an
> error.  Data was then eg captured from the card as if it was running
> at 48K, but actually it remained at 44.1K.  Thus the recorded data
> was wrong.
> 
> snd_pcm_hw_params_set_rate_near(..)
> 
> did not report error because it was asking for 44.1K; somewhere else
> the configuration decided 48K was better, but did not highlight that
> the card refused to change setting.  Surely this should class as a
> bug.
> 
> Since the inverse error happens on capture, it is not immediately
> obvious that there is a problem with the recording, so important
> recordings could be completely messed up.
> 
> 2. These ice1712-based pro/semi-pro hardware systems should IMO NEVER
> perform secret rate conversion.  They are designed for readers of
> 'Sound on Sound' etc, and Paul White et al would rightly blast
> M-Audio or Terratec if their Windows drivers quietly set the card to
> a different rate to that requested and rate converted the data!
> Especially so on a capture stream.  Remember the cards are 24-bit
> 96KHz capable and approach 100dB signal-to-noise ratio.
> 
> Whilst there may be circumstances in which material recorded at
> different rates has to be used in the same project, it is only
> converted once, in full knowledge.
> 
> Can't dmix be configured to run at whatever rate is set on the card,
> or the requested rate, rather than attempt to overule both of them?
> 
> Alan

For what it's worth, I agree with Alan here.  Any sound library with
aspirations to professional use can't have hidden conversions and
silent corrections going on.

However, I also agree with Takashi that for the average user having the
dmix plugin as a default is a very good thing.

So, would it be possible to have an api call in the interface to
disable the dmix plugin for any instance of alsa.  For example,  I call
the interface to open the default sound device.  Another call gets me
the hardware associated with the default device.  I then tell the
interface to bypass any filters or plugins, basically giving access to
the hw interface for whichever card is default for this stream only.

Maybe this already exists.  If it does, could you point me in the right
direction (which function).  If not, where would it be best implemented
(which source file)?  I don't know that I could or will write it, but I
would like to have a look at how difficult it would be.

Thanks.
stan
