From: Mark Knecht <markknecht@comcast.net>
Subject: Re: HDSP 9652: Input channel corruption
Date: Wed, 08 Oct 2003 21:07:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065672448.3693.12.camel@Wizard.knechthome.com>
References: <20031009111238.B5188@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031009111238.B5188@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-10-08 at 20:12, Nick Arnold wrote:
> The symptoms:
> ------------
> 
> We connect a sine wave to the first 12 channels and record them, and see
> three channels -- 0, 4, and 8 -- are "corrupted".  The remaining channels
> appear to be well-formed and look as we expect them to.

When you say the 'first 12 channels', are you speaking of the
alsa:playback channels, or are you attaching a sine wave the the ADAT
input channels from an external source? I'm not clear on that.

> 
> It seems most likely to be some code in the driver, or perhaps the mixer is
> responsible for this incorrect ordering.

OK, first, I apologize, but Thomas and I never looked at 96KHz
operation, and to the best of my knowledge it was only our debug that
went into the Aug. 27th patch. I think this means you are on new ground.

Thomas and I saw a similar problem at 44.1KHz with ADAT input signals at
one point. In hdspmixer I was getting green audio and yellow peak
information that did not make sense. I do not remember how I came to the
conclusion that there was an ordering problem, but Thomas pretty quickly
found it once I pointed it out. Possibly we only fixed normal speed
operation and missed the double speed equivalent problem.

> 
> The questions are:
> 
>     - could this be a bug, perhaps in the hdsp driver?

I think possibly yes.

> 
>     - alternatively, could this be due to some mixer setting that has been
>       turned on by default unbeknownst to us?  if so, how can we turn this
>       off?

I do not think this is likely, or at least I do not know of anything you
can do.

> 
> any help much appreciated,

I think I'm not helping much...

> 
> nick.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
