From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 07:06:11 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEAADDAB.mknecht@controlnet.com>
References: <Pine.HPX.4.33n.0309111007270.28640-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309111007270.28640-100000@studcom.urz.uni-halle.de>
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


> > At lunch today I rewired my MIDI input from the keyboard
> controller to use
> > the MidiSport input instead of the HDSP 9652 input. In this
> configuration,
> > with only about 15 minutes of testing, I had no problems. I will do more
> > testing this evening, but possibly this data says it's an HDSP 9652 MIDI
> > problem, or the HDSP 9652 MIDI combined with Jack-type audio, and not
> > specifically 'Alsa MIDI'.
>
> When an interrupt for MIDI input occurs, the hdsp driver disables all
> further MIDI interrupts until the current input data has been read. I
> don't know why it does this, but you may try to remove/disable lines
> 3181, 3182, 3188, and 3189 in hdsp.c.

Thanks Clemens. I'll take a look at this over the weekend probably, although
I wonder about your response to Paul's message on this subject?

Cheers,
Mark





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
