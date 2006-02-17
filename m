From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Fri, 17 Feb 2006 12:35:35 +1030 (CST)
Message-ID: <200602170205.k1H25ZMA018989@auster.physics.adelaide.edu.au>
References: <20060216100553.GB32525@soften.ktu.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060216100553.GB32525@soften.ktu.lt> from "Rimas Kudelis" at Feb 16, 2006 12:05:53 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Rimas Kudelis <rq@akl.lt>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Another wild guess: is it intended so, that I can feel absolutely no
> difference when changing the LINE1 mode from Line Out to Headphones and
> vice-versa?

This is the pin you *can* get sound from, right?

Whether you notice a difference between the modes depends on the nature of
what you plug into the jack.  A cable going to a line-level input on some
other equipment is unlikely to cause much change beyond a *slight* increase
in the hiss level.  With high-impedence headphones you are also unlikely to
notice much difference.  The biggest difference comes if driving low
impedence headphones - 32 ohms or there abouts.  Most earbuds for example
are low impedence.

> Would it be sane to try to apply Bias voltage to output
> jacks too, not only the Mic jacks?.

The bias voltage is only needed for certain types of microphones which use
it to power small amplifiers/signal conditioners.  Applying a bias to
an output doesn't really make sense.  In the case of a jack it will simply
cause a DC offset which will either be ignored by connected gear or (in the
case of DC-coupled amplifiers) cause a lot of problems.  For the internal
speaker it makes no sense at all because any power the speaker amplifier
needs can be more efficiently taken from other sources within the computer.

So the short answer is that it should not be necessary to apply bias to
an output.  A good thought though.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
