From: Lee Revell <rlrevell@joe-job.com>
Subject: Using hardware timers for the ALSA sequencer
Date: Mon, 14 Mar 2005 19:07:16 -0500
Message-ID: <1110845236.15588.23.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hey,

The emu10k1 timer thread reminded me of an idea I had.

Currently the ALSA sequencer always uses the system timer by default.
If your sound cards timer is supported by ALSA (emu10k1 and ymfpci),
this provides 50-100x better resolution.  But in order to get the ALSA
sequencer to use it you have to use the seq_default_timer_*  options
(which BTW I had never heard of on the list, I stumbled across them
reading the source).

How hard would it be to get the sequencer to prefer the hardware timer
by default and fall back to the system timer otherwise?  Probably would
not be noticeable for a MIDI keyboard, but for applications like sending
MIDI clock/MTC, the system timer resolution can be inadequate.

Would this be a good idea?

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
