From: Owen Fraser-Green <owen@discobabe.net>
Subject: Mixer sanity
Date: Sat, 05 Jun 2004 15:51:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086443486.3656.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

After some tinkering around with ALSA's mixer with a couple of different
cards it's become apparent to me that there's not too much
standardization when it comes to track naming. 

What I'd like to be able to do is adjust the different levels on
different channels and to adjust the mast mixer - in fact, I'm sure this
must be about the most common use case for a mixer. The problem is,
however, it isn't really possible to decide consistently across all
sound cards which mixer elements the program should use to achieve this.
For example, the Maestro3-based sound card on my laptop has a Master
element and a stereo PCM element. Fair enough. On my workstation, my
envy24-based card shows no usable master element and, even worse, each
of the 8 mono channels has it's own stereo mixer element where the L-R
levels control how much of the mono signal is mixed into the L-R
channels of the master mix. Just to alter the level for regular stereo
playback, therefore, I have to first lower the L level for HW1 and then
alter the R level for HW2 (with HW1's R and HW2's L muted). This is
weird!

Now, I know an envy24mixer exists to make life easier for me but surely
it would be a bit nicer if the mixer interface provided a more
consistent abstraction. In my situation, I want my software to be useful
without a screen so the envy24mixer is out of the question. The only
other solution, therefore, is for me to provide a map for every sound
card which ALSA supports.

Having spoken to some guys involved in gstreamer/GNOME I gather this is
a pet grumble of theirs too as they would like to provide a generalized
mixer interface.

Cheers,
Owen




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
