From: Bob Ham <node@users.sourceforge.net>
Subject: sblive line capture woes
Date: Fri, 18 Oct 2002 18:53:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021018175259.GA20966@depression.ath.cx>
References: <1027973318.10978.62.camel@insanity> <s5hr8hkeyqa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr8hkeyqa.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2002 at 04:52:29PM +0200, Takashi Iwai wrote:

> on emu10k1, the signals from ac97 are routed to the capture fifo and
> then you can record them.  in addition, you can route other sources
> and mix them to this capture fifo.  the switch shown above does this.
> if these switches are on, then the signals from livedrive are routed
> and mixed with the signals from ac97 (if enabled).
> 
> there are another switches, "Line LiveDrive Playback Volume".
> this will route the input of livedrive to the DAC, i.e. you'll hear 
> the sounds from front speakers.
> i guess, these switches are still turned on, in your case.

Having eventually compiled alsa from cvs, I hoped maybe this problem had
been solved.  It's still there :(  To recap, I'm setting the livedrive line to
capture, putting the linedrive line capture level right up and the livedrive
line level right down, putting the ac97 capture level right up and setting the
"Capture" thingy (whatever that is) to capture and putting its level right up.
It does NOT capture the livedrive line.  From what was said before, it
should be.  The output of amixer is attached, so as there's no ambiguity.

I sincerely hope this can be fixed.

Bob


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
