From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: intel8x0 driver motorboots (gets caught in loop) in Quake 3
Date: Wed, 12 Feb 2003 18:54:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4A8A39.9000608@uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

When running Quake 3 Arena the sound initializes
properly and plays correctly during the game until the
end of a match. At this point, the game abruptly enters
a different mode (this is where the models of the
players for the first, second, and third placements are
shown on pedestals and a voice says "Grunt Wins!" or
whatever) and the game locks up with a small segment of
sound being repeated in a loop.


This does not occur when sound is disabled in quake.

This does not occur on the same machine while running
quake 3 under Windows 2000 with sound.

This also occurs using the linux kernel 2.4.18 oss
kernel sound driver for intel8x0.


I set up the quake mmap stuff for alsa like this:

echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss


I'm using alsa-0.9rc7 on Debian 3.0r1 running kernel 2.4.20 on an AMD
1800+ Elitegroup K7S5A with SIS 7012 sound on board (intel8x0 driver.)


This has happened on all the ALSA 0.9rcx drivers I have
tried, including 0.9rc7.



-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
