From: Mark Knecht <markknecht@attbi.com>
Subject: Re: alsasound init script (Re: possible problems with
	rc6 aplay )
Date: 16 Dec 2002 13:18:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040073528.1312.18.camel@Godzilla>
References: <20021216152035.CZFC3512.sccrgwc01.attbi.com@newmx1.fast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021216152035.CZFC3512.sccrgwc01.attbi.com@newmx1.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, martin-langer@gmx.de, Alsa-Devel <alsa-devel@lists.sourceforge.net>, swpatrick@earthlink.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-12-16 at 07:23, Paul Davis wrote:
> >> that reminds me. the last version of the alsasound script that i saw
> >> did something very dangerous. it seemed to try to install *every*
> >> snd-card module it could find. if you have a system with an ISA bus,
> >> this can prove fatal to the system - many ISA device probes will kill
> >> the machine if the device is not present.
> > 
> >well, you can find that the alsasound script tries to load the modules
> >aliased as "snd-card-[0-9]", not the all snd-card-* modules.
> >remember that there is no module named as such.  that means, if such a
> >module is found, it was certainly configured by some means.
> 
> ah. sorry, i missed the -c on modprobe. i take it all back :(
> 
> --p

I wonder if this could have anything to do with a different problem I'm
seeing. I have a HDSP 9652 and a MidiMan 2X2 interface. The HDSP is
installed by alsaconf. The 2X2 is installed usign Fernando's
instructions from the Planet.

When I do a cold boot, the HDSP is always recognized first, and then the
MidiMan comes up as card 2, at least by reading the numbers of the
devices in /dev/snd. However, if I reboot, many times the system makes
the 2X2 card 1 and the HDSP card 2, and that breaks a lot of this
software.

What would cause this to happen and how could I stop it?

I have found that everything seems to work fine if I remember to unplug
the 2X2 when the reboot begins, but sometimes I don't remember and have
to go through one more boot cycle.

Cheers,
Mark



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
