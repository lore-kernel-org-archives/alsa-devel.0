From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa sequencer port type flags
Date: Thu, 11 Dec 2003 11:18:05 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312101536120.776-100000@studcom.urz.uni-halle.de>
References: <200312101335.39428.dgarcia@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200312101335.39428.dgarcia@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Garcia Garzon <dgarcia@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Garcia Garzon wrote:
> SND_SEQ_PORT_TYPE_SPECIFIC Hardware specific port

something hardware-specific (obviously :-)

> SND_SEQ_PORT_TYPE_MIDI_GENERIC Generic MIDI device

Understands MIDI events/commands.

> SND_SEQ_PORT_TYPE_MIDI_GM General MIDI compatible device
> SND_SEQ_PORT_TYPE_MIDI_GS GS compatible device
> SND_SEQ_PORT_TYPE_MIDI_XG XG compatible device
> SND_SEQ_PORT_TYPE_MIDI_MT32 MT-32 compatible device

Support for these standards.  Not necessarily full support, and the
availability of instruments may depend on loaded soundfonts, but basic
things like bank selection and drum channel selection should work.

This is not set for external ports like MPU-401 which may have a
compatible device connected to them.

> SND_SEQ_PORT_TYPE_SYNTH Synth device

Device can playback sound via the SAMPLE_* events.  (The OPL3 driver
sets this flag too, so either this driver or my description is wrong.)

> SND_SEQ_PORT_TYPE_DIRECT_SAMPLE Sampling device (supporting download)

Can download instrument samples (SND_SEQ_EVENT_INSTR_PUT etc.)

> SND_SEQ_PORT_TYPE_SAMPLE Sampling device (sample can be downloaded at any time)

No ALSA driver sets this.  I don't know what "at any time" means; the
INSTR_* events _can_ be sent at any time.

> SND_SEQ_PORT_TYPE_APPLICATION Application (sequencer/editor)

This port is (usually) controlled by the user, and not by events sent
to it.

> But which are the implications of setting up a port with such flags?
> - Are they merely informative?

Yes.

> - Will Alsa coerce or enhance the port usage depending on that type?

No.  ALSA never looks at these flags, except when someone wants to
read port information.

> - Can the user see that information in any way?

It isn't even shown in the proc files AFAIK.


> What is the use, in a programmer view, of alsa sequencer port type
> flags?

Not much.  They're more or less useless for automatic selection/
filtering of ports.  It may be possible to show them to the user, but
they won't be accurate in every case.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
