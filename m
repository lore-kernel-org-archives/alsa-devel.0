From: Mark Knecht <markknecht@comcast.net>
Subject: Re: HDSP 9652: Input channel corruption
Date: Fri, 10 Oct 2003 12:34:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065814483.2164.23.camel@Wizard.knechthome.com>
References: <20031009111238.B5188@nautronix.com.au>
	 <1065672448.3693.12.camel@Wizard.knechthome.com>
	 <20031010165526.A10106@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031010165526.A10106@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Arnold <nick.arnold@nautronix.com.au>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   OK, so let me make sure I'm understanding what you're doing. If I
have it right, then comments below might make soem sense. If I have it
wrong, then disregard everything below and help me get it straight.

   My understanding now is that you are just running using standard 48K
operation, but then adding a second layer of software that takes data
from two channels and stitches them together to make what appears to be
a 96KHz signal. The HDSP 9652 can do this in hardware but you are doing
it in software. Is this correct?

   If so, then my thought and suggestions below might be of some help.

Cheers,
Mark

On Fri, 2003-10-10 at 01:55, Nick Arnold wrote:

> Okay, as usual I'm being ambiguous. :( Sorry.  We attached a signal generator
> to the ADAT input channels and used our software to record the first 12
> capture channels of the HDSP.  (Also, I'm talking about the first 12 96KHz
> channels -- ie. the first 24 48KHz channels.)

Cool. So you have 3 ADAT cables coming in, with this 96KHz-ish signal
arriving, and then on the machine you use the output of the Alsa driver
to stitch the data back together to make the 96KHz data stream. Sounds
good.


> The card is running as a slave device (autosync) off a 48KHz clock
> source.  Our AD/DA is running in double speed mode so we're getting 96KHz
> sampling rate of the raw data.  Our recording software knows we're doing
> double speed and does the interleaving.  So, as far as the driver is
> concerned we are running at 48KHz.  (And, to be clear: there were no problems
> with this setup when we swapped back to a DIGI 9652.)

Yes, and this is important I think, in two ways...

> 
> This might mean we're back on familar ground?

I agree. We are back on familiar ground, and possibly ground I or others
could help with.

Clearly, if this is real, then ALL HDSP 9652 users would have an
interest.

> This sounds promising, however as I just described we're in normal speed too.
> So there seems to still be a problem in normal speed ...

And while I don't *think* I have this problem, and I do use channel 8 on
a regular basis, I have not specifically looked for it. I think it would
be very easy for me to do so.

Assume I take an audio stream from Pro Tools and send it to the HDSP
9652 over ADAT, twice and at the same time. I would send this data
stream over channels 8 & 9, and at the same time over 10 & 11. Further
assume that I record these two data streams as separate wave files,
using Ardour or Audacity or whatever application you think makes sense.

Conceptually, I think, if the problem exists these two wave files should
be different, correct? The left channels would be different, but the
right channels would be identical.

Is this correct?

If I was to measure distortion (using some piece of software, I don't
know what, I should see the second copy being identical to my Pro Tools
database, but the first copy would be distorted.

Or, if you provided me with a wave file I could transmit, then I could
provide the output back to you...


> 
> To elaborate on the problem again: seeing corruption on 96KHz channels 0, 4,
> and 8.  It appears as though every second sample on these channels is wrong.
> Since two 48KHz channels are being combined it seems to indicate that one of
> the 48KHz channels is okay, but the other has something wrong.  
> 
> One explanation that fits what we've observed is a mystery sample (A) on one
> of the channels:
> 
>     48KHz channel 1:  A 0 2 4 6 ...
>     48KHz channel 0:  1 3 5 7 9 ...
> 
> So what we expect (assuming "A" had not been inserted into the stream):
> 
>     0 1 2 3 4 5 6 7 ...
> 
> But we observe instead:
> 
>     A 1 0 3 2 5 4 7 6 9 ...

It does look like an 'off-by-one' type bug, especially if the Hammerfall
did not exhibit the same problem.

Question #1 - I only use 44.1KHz operation. It seems unlikely, but is
there any chance that this changes based on those two frequencies?

Observation - On my system, I output All of my Pro Tools audio over ADAT
to my Linux box on channels 8 & 9, and then the HDSP 9652 forwards it
(in hardware) to channels 0&1 for speakers, and 2&3 for headphones. I
spend most of my time listening on headphones. I have thought this
soulds better than the DigiDesign converters. I would have thought, if I
was having the problem you describe, that it would sound worse.

Question #2 - I have two Linux boxes here, one with a Hammerfall Lite,
and the other with an HDSP 9652. Can you record something using the
Hammerfall on your end, send me a file, and tell me how to transmit this
from my Hammerfall Lite into the HDSP 9652? 

If I then recorded it and got the same problem, that might be
interesting.

Or maybe there are easier ways to do the same things, such as my Pro
Tools dual recording experiment.

Comments?

> >
> > I think I'm not helping much...
> 
> On the contrary.  Its very reassuring to hear we share the same feeling as to
> the location of the problem (ie. the driver).  Your help is gratefully
> received :)
> 
> nick.

I'm very willing to try a few experiments over the weekend. Contact me
off list to discuss what you might like me to try.

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
