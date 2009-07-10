From: Louis Lee <lwhlee@hotmail.com>
Subject: Re: While recording from mono codec twice as much	data
 is received
Date: Fri, 10 Jul 2009 14:53:52 -0600
Message-ID: <COL102-W38BFFD26634F8E68389469D0270@phx.gbl>
References: <COL102-W427E3B6FA3A27688387EAED0260@phx.gbl>
	<20090710092924.GH7988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc4-s3.col0.hotmail.com (col0-omc4-s3.col0.hotmail.com
	[65.55.34.205]) by alsa0.perex.cz (Postfix) with ESMTP id A8540244AA
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 22:53:59 +0200 (CEST)
In-Reply-To: <20090710092924.GH7988@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: ALSA Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> Date: Fri, 10 Jul 2009 10:29:24 +0100
> <snip...>
> 
> On Thu, Jul 09, 2009 at 03:27:17PM -0600, Louis Lee wrote:
> 
> >   However, when recording using the exact same setup for the data
> >   interface I am not getting favorable results.  For instance, if I
> >   record for 5 seconds I get output in a file for 10 seconds of audio
> >   (arecord or sox).  This results in my recording being stretched.  I
> >   change the DAI to stereo capture and record two channels and the
> >   recorded output comes back correctly (5 seconds recorded is 5
> >   seconds).
> 
> This suggests that either the CODEC is configured to run at twice the
> expected sample rate or that there are enough bit clocks being generated
> for stereo data and the CPU DAI is trying to record data for each bit
> clock cycle.  Is the CPU or the CODEC the clock master in your system?
> 
Mark, thanks again for your insights.  I believe the sample rate is correct.I can see it on the scope and FRAME frequency is equivalent to thesample rate.  I ran into a bit of a problem though.  If you are right aboutthat each bit in the clock cycle is being recorded I think I have just enoughbits in my clock for stereo data.  If I reduce it though I run into theproblem where I don't have enough bits to clock through all my data. :(
This probably seems like a complete noob question.  How exactly do I modify the CPU DAI to not account for each bit in the clock cycle?
The CODEC is the clock master in my system.
Thanks Mark!  You have been tremendous help.
> >   I'm stuck now.  From my understanding the clocks are setup the same
> >   way for both playback and capture.  Has anyone ran into this problem
> >   before?  The WM8974 is a mono codec so I should not have to set the
> >   DAI to stereo in order to capture data properly.
> 
> It should be possible to do what you want, yes.
_________________________________________________________________
Attention all humans. We are your photos. Free us.
http://go.microsoft.com/?linkid=9666047
