From: Giuliano Pochini <pochini@shiny.it>
Subject: a lot of different cards and controls
Date: Mon, 22 Mar 2004 23:39:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040322233928.60245c51.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



My driver is almost complete and I'm working to make it acceptable for
inclusion in alsa-driver. It drives 8 different cards and it raises some
problems. The main file is echoaudio.c and is contains all the control
interfaces of all cards. It registers only the controls a card has at
runtime, so there is some useless bloat for some cards. It's not very much
because the lowlevel functions are defined in <card>Dsp.c and they are just
empty functions if the card hasn't that feature. I wonder if this is ok.
Otherwise I could split echoaudio.c into smaller peices and create several
echoaudio_<card>.c files that contain something like this:

#include "mixer_ctl.c"
#include "inputclock_ctl.c"
...
#include "echoaudio_main.c"

So it compiles only the parts that are really needed, at the cost of having
a lot more files and a bit less clear structure. What is the preferred
method ?



--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
