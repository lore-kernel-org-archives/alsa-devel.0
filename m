From: Chris Purnell <cjp@lost.org.uk>
Subject: EMU10K1 and the extra voice
Date: Sat, 5 Jun 2004 12:59:36 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040605125936.GA3478@lost.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


For PCM playback the EMU10K1 driver is allocating an extra voice.
This is somewhat wastefull and I kind of need all 64 voices.
Is appears to be using it to generate the period interrupts.
Does anyone know what it would take to rewrite the driver to
not need this extra voice?

-- 
Christopher John Purnell  | I thought I'd found a reason to live
http://www.lost.org.uk/   | Just like before when I was a child
--------------------------| Only to find that dreams made of sand
What gods do you pray to? | Would just fall apart and slip through my hands


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
