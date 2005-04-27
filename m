From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell how many frames gone to PCM
Date: Wed, 27 Apr 2005 19:22:50 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504271910000.28618-100000@studcom.urz.uni-halle.de>
References: <426FC448.9050609@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <426FC448.9050609@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> Clemens Ladisch wrote:
> > You should check the error code, but otherwise this looks OK.
>
> Error code for which function?

snd_seq_set_queue_timer (it's the only nontrivial function, the others
just set parameters for this one)

As a rule, every error code should be checked.

> Here's a question... I'd like to get the current time from both
> the PCM and the MIDI device in order to confirm they've got the
> clock linked. Is there a meaningful way to test that?

There is no PCM time per se, you have to use the frame count as time.

A MIDI queue doesn't have its own "real time" either; whenever you use
a "real time" timestamp you end up using the system clock.  Only the
tick counter is synchronized to the timer interrupt.  (And no, this
isn't documented anywhere.)

And I guess this is your problem -- it should go away if you schedule
the MIDI events using ticks instead of real time.

The nice thing about using ticks is that you can set them up to be any
quantity you want (in this case probably the same as one PCM frame or
period).


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
