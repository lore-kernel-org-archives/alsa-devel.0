From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usb midi devices.
Date: Sun, 14 Dec 2003 11:19:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031214101942.GA920@tuba.home>
References: <3FDC2E4A.2050105@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3FDC2E4A.2050105@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 14, 2003 at 06:32:58PM +0900, Patrick Shirkey wrote:
> Could someone send me a list of all the usbmidi devices that require 
> firmware to be inserted. I am redesigning the docs for these cards.
> 

snd-usb-audio with MidiSport firmware loader:
MidiSport 1x1, 2x2, 4x4, 8x8, KeyStation, Oxygen, Radium, Uno, and maybe
MidiSport 2x4. (It's the latest list from http://usb-midi-fw.sf.net).

snd-usb-usx2y with usx2yloader:
Tascam US122, US224 ( 224 needs fw, but we have no driver:-( ), US428 

And there are some other cards (Sonica, ...) which need a firmware download,
but there's no linux loader available. 


martin


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
