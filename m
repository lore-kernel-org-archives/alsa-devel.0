From: Paul Davis <paul@linuxaudiosystems.com>
Subject: oops with current ALSA CVS + gcc3
Date: Wed, 5 Mar 2003 07:42:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303051242.h25Cgi401244@linuxaudiosystems.com>
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

is anybody else using gcc 3.2.2 to compile their kernel and ALSA CVS? 

i switched in the last couple of days, and have found:

  * just trying to load wavefront driver causes lockup without oops message.
  * use of trident driver causes oops whenever used.

i haven't tried the hammerfall/hdsp drivers yet, though they load just
fine and the /proc card-specific files work just fine.

the oops trace from using the trident points to problems with process
wakeup after an interrupt, and doesn't seem to involve ALSA specific
code (the call trace points to a set of functions that start at
synchronize_irq() and end with wake_up_process().

i am not sure if this is an ALSA CVS issue, or if its to do with my
use of gcc 3.2.2. i don't have gcc2.95 around anymore, and am
reluctant to do so, but if i have to ...

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
