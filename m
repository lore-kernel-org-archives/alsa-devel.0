From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: MIDI timing question
Date: Thu, 28 Aug 2003 09:20:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGMECIDBAB.mknecht@controlnet.com>
References: <Pine.HPX.4.33n.0308281647430.14119-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0308281647430.14119-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens,
   Thanks very much for writing all this up! I'll study it and maybe come
back with a few questions.

With best regards,
Mark

> -----Original Message-----
> From: aezr4@studcom.urz.uni-halle.de
> [mailto:aezr4@studcom.urz.uni-halle.de]On Behalf Of Clemens Ladisch
> Sent: Thursday, August 28, 2003 8:56 AM
> To: Mark Knecht
> Cc: Alsa-Devel
> Subject: Re: [Alsa-devel] MIDI timing question
>
>
> Mark Knecht wrote:
> >    Does anyone have a simple page I could read with an
> explanation about how
> > one would go about transmitting a given number of MIDI events at a known
> > tempo using the Alsa MIDI services?
>
> You'd use the sequencer. There isn't an easy HOWTO that I'd know of.
>
> To send some events at a specific time:
> - open the sequencer
> - create your own (source) port
> - create a queue
> - set the queue's tempo
> - send some events through the queue, and start it
>
<SNIP>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
