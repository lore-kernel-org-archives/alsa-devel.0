From: Martin Langer <martin-langer=Mmb7MZpHnFY@public.gmane.org>
Subject: [ANN] MidiSport and Tascam firmware loader 0.1
Date: Wed, 27 Aug 2003 20:53:48 +0200
Sender: linux-audio-dev-admin=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20030827185348.GA701@tuba.home>
Reply-To: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-audio-dev-admin@music.columbia.edu>
Content-Disposition: inline
Errors-To: linux-audio-dev-admin@music.columbia.edu
List-Help: <mailto:linux-audio-dev-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-dev@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev/>
To: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: usb-midi-fw-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, usb-midi-fw-user=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, us428=g1zhK3NZ1fYYtQj7fl1lsA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


Firmware loaders for Midiman and Tascam USB MIDI devices

These packages allow you to use Midiman's MidiSport USB MIDI interfaces and
Tascam's USB Audio interfaces with Linux. These devices require a firmware
download before an operating system driver (e.g. ALSA's snd-usb-audio) can
access them.

These loaders use the same firmware used by the Windows drivers, so you need
a file of the respective Windows driver to install them. (See README files
for details.) 

-*-

The MidiSport firmware loader is required to use USB MIDI devices from
M-Audio/Midiman under Linux. Release 0.1 contains some slight enhancements
to the installation process, and is the first release hosted on
SourceForge.net.

Supported devices:
MidiSport 1x1, 2x2, 4x4, 8x8, KeyStation, Oxygen, Radium, Uno, and maybe
MidiSport 2x4.

-*-

The Tascam firmware loader is required to use USB MIDI/Audio devices    
from Tascam under Linux. There is also a loader for the FPGA
configuration data included. The firmware and the FPGA configuration
data will be extracted from your Windows driver files during
installation. This is an initial release.

Supported devices:
US-122, US-224 and US-428

-*-

To download the loaders, go to the project home page:
http://usb-midi-fw.sf.net/


martin
