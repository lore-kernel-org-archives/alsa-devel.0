From: Philip Willoughby <pgw99@doc.ic.ac.uk>
Subject: Master volume control
Date: Mon, 17 Feb 2003 13:46:22 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50.0302171306190.28786-100000@kungfu.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I need a programmatic way to change the master volume control from a C
program.  At the moment I'm fork()ing and exec()ing

/usr/bin/amixer --quiet set Master xx%

which works, but sometimes does nothing because the resolution of the card
is insufficient.  Now I could parse the output of

/usr/bin/amixer get Master

to find out the limits of the volume control on the board, but that's messy
in C and I'd rather do it properly.

Anyway, I need C functions to:

Mute all sound
unMute all sound
get current volume level
get max volume level
get min volume level (only if it's ever not zero)
set current volume level

I know these are possible because other apps use them...

However I have not been able to find a simple way to do this.

Ideally I need the code to do this for both alsa 0.5 which we use here at
the moment, and alsa 0.9.  The target application is a little daemon to use
the media keys on recent keyboards to control alsa and xmms, as a bribe
I'll be releasing the code under the GPL as soon as get the volume changing
code ;-).

Regards,

Philip Willoughby

Systems Programmer, Department of Computing, Imperial College, London, UK
-- 
echo bzidd@nfo.ho.co.se | tr "bizndfohces" "pwgd9ociaku"

Why reinvent the wheel? . . . . . . . . . Because we can make it rounder...


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
