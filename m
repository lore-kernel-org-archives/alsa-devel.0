From: Giuliano Pochini <pochini@shiny.it>
Subject: echoaudio.c, Revision 1.6
Date: Sat, 12 Mar 2005 12:32:15 +0100
Message-ID: <20050312123215.0d9e8d94.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I'm a bit confused about the latest changes to pci/echoaudio/echoaudio.c

The CVS interface says: "Use spin_lock_irqsave() instead of spin_lock() in
places where we could be interrupted by another hardware interrupt that
could call the rawmidi trigger callback that could try to take the same
lock."

But in snd_echo_interrupt() we are running in hard irq context, so we know
irqs are already disabled. We should change midi.c:snd_echo_midi_*_trigger()
instead, or am I missing something ?


Then: "Additionally, remove locking code that is no longer needed now that
the trigger callback is no longer called recursively from the rawmidi
"event" handler."

Your patch does not remove anything. It only replaces spin_lock() in
pcm_trigger() which is a stupid bug of mine, sorry.



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
