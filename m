From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Tascam US-122: tascam_firmware-0.1 and alsa-firmware
Date: Sun, 30 Nov 2003 16:26:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031130152615.GB24063@tuba.home>
References: <3FC60BAA.4060809@laposte.net> <200311271556.36745.annabellesgarden@yahoo.de> <20031127192437.GA561@tuba.home> <3FC8D323.4060206@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3FC8D323.4060206@laposte.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: JoDaY <jo.day@laposte.net>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 29, 2003 at 06:10:59PM +0100, JoDaY wrote:
> 
> It's ok :) I'm sorry for my bad question ... I should have ask you where 
> can I reach the US-122, my problem in fact is that I can't find this 
> card in /dev in order to point a sound or midi player to it so that the 
> US-122 make noise (sound :) ).

The card should be listed in /proc/asound/cards.

aplay, arecord, aconnect and pmidi are running fine here (with alsa access).

What do you try? OSS access (/dev/dspX)?
Have you ever run ./snddevices in alsa-driver?

> I've also noticed that the Midi in LED is lighting, the US-122 's owner 
> doesn't seem to have this when he uses it on windows.

Hmmm, my LED is only burning when MIDI data is passing the port. But if you
send weird data to the port it will burn until christmas, that's correct. I
don't know how to reset it. I guess the solution is somewhere in the
firmware, but the firmware is the original Tascam/Frontier firmware and
we've never got any docs from them. And I fear we don't get them in the
future :-( 
Nevertheless my MIDI keyboard at MIDI IN doesn't produce errors and the LED
is only blinking. Same with pmidi during sending data to MIDI OUT. In both
cases it will stop blinking if no MIDI data is passing the ports.

martin


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
