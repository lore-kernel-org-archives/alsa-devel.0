From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: Re: HDSP 9652: Input channel corruption
Date: Fri, 10 Oct 2003 16:55:26 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031010165526.A10106@nautronix.com.au>
References: <20031009111238.B5188@nautronix.com.au> <1065672448.3693.12.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1065672448.3693.12.camel@Wizard.knechthome.com>; from markknecht@comcast.net on Wed, Oct 08, 2003 at 09:07:28PM -0700
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

Hi and thanks for the reply,

> > We connect a sine wave to the first 12 channels and record them, and see
> > three channels -- 0, 4, and 8 -- are "corrupted".  The remaining channels
> > appear to be well-formed and look as we expect them to.
> 
> When you say the 'first 12 channels', are you speaking of the
> alsa:playback channels, or are you attaching a sine wave the the ADAT
> input channels from an external source? I'm not clear on that.

Okay, as usual I'm being ambiguous. :( Sorry.  We attached a signal generator
to the ADAT input channels and used our software to record the first 12
capture channels of the HDSP.  (Also, I'm talking about the first 12 96KHz
channels -- ie. the first 24 48KHz channels.)

> > It seems most likely to be some code in the driver, or perhaps the mixer
> > is responsible for this incorrect ordering.
> 
> OK, first, I apologize, but Thomas and I never looked at 96KHz
> operation, and to the best of my knowledge it was only our debug that
> went into the Aug. 27th patch. I think this means you are on new ground.

No need for you to appologize. :)  As it happens I've managed to be ambiguous
and misleading again: 

The card is running as a slave device (autosync) off a 48KHz clock
source.  Our AD/DA is running in double speed mode so we're getting 96KHz
sampling rate of the raw data.  Our recording software knows we're doing
double speed and does the interleaving.  So, as far as the driver is
concerned we are running at 48KHz.  (And, to be clear: there were no problems
with this setup when we swapped back to a DIGI 9652.)

This might mean we're back on familar ground?
 
> Thomas and I saw a similar problem at 44.1KHz with ADAT input signals at
> one point. In hdspmixer I was getting green audio and yellow peak
> information that did not make sense. I do not remember how I came to the
> conclusion that there was an ordering problem, but Thomas pretty quickly
> found it once I pointed it out. Possibly we only fixed normal speed
> operation and missed the double speed equivalent problem.

This sounds promising, however as I just described we're in normal speed too.
So there seems to still be a problem in normal speed ...

To elaborate on the problem again: seeing corruption on 96KHz channels 0, 4,
and 8.  It appears as though every second sample on these channels is wrong.
Since two 48KHz channels are being combined it seems to indicate that one of
the 48KHz channels is okay, but the other has something wrong.  

One explanation that fits what we've observed is a mystery sample (A) on one
of the channels:

    48KHz channel 1:  A 0 2 4 6 ...
    48KHz channel 0:  1 3 5 7 9 ...

So what we expect (assuming "A" had not been inserted into the stream):

    0 1 2 3 4 5 6 7 ...

But we observe instead:

    A 1 0 3 2 5 4 7 6 9 ...

It feels like an off-by-one bug, but one which apparently only effects every
fourth 96KHz channel -- ie. every fourth pair of 48KHz channels; or, if my
hypothesis above is correct, every eighth 48KHz channel.

> > The questions are:
> >     - could this be a bug, perhaps in the hdsp driver?
>
> I think possibly yes.
> 
> >     - alternatively, could this be due to some mixer setting that has been
> >       turned on by default unbeknownst to us?  if so, how can we turn this
> >       off?
>
> I do not think this is likely, or at least I do not know of anything you
> can do.
> 
> > any help much appreciated,
>
> I think I'm not helping much...

On the contrary.  Its very reassuring to hear we share the same feeling as to
the location of the problem (ie. the driver).  Your help is gratefully
received :)

nick.

--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
