From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: new alsa docs.
Date: Wed, 14 Aug 2002 18:01:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208141801.11087.plcl@telefonica.net>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D591A58.11ABEA9@ladisch.de> <3D591F57.1060601@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D591F57.1060601@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Mar 13 Ago 2002 17:01, Patrick Shirkey escribió:
> Clemens Ladisch wrote:
> > I didn't bother to report USB MIDI devices - until now:
>
> Thanks. I'm collecting them for now until I or Dan get the energy to add
> them to the matrix.

The "usb generic" instructions for USB-MIDI devices is a copy of the Midiman 
MidisportNxN page. This is very inaccurate and confusing, as many devices 
(e.g. the Roland/Edirol ones) aren't EZ-USB devices and don't need/accept the 
ezusbmidi firmware at all. Please, remove the ezusbmidi references from the 
generic usb-midi page.

On the other hand, this device is reported by Clemens:
 Steinberg        http://www.steinberg.net/
    USB-2-MIDI       http://www.steinberg.net/products/ae/hardware/usb2midi/
It is another EZ-USB based device, and needs the ezusbmidi firmware to work. 
You can safely copy the Midisport page for it.

I would like to insist again about including "EZ-USB" in the chipset column 
for  these devices: 
	Midiman Midisport NxN
	Midiman USB Keystations: 
http://www.midiman.net/products/midiman/keystations.php
	Steinberg USB-MIDI-2 adaptor:
http://www.steinberg.net/products/ae/hardware/usb2midi/

For the "chipset" column you can put here EZ-USB (or "Cypress AN2131XX") 
http://www.cypress.com/products/datasheet.cfm?partnum=AN2131SC

This chipset is widely used in USB peripherals, not only MIDI ones, and it is  
related to Intel 8051 chip. The firmware loader (fxload) for this chipset is 
included in linux-hotplug: http://linux-hotplug.sourceforge.net/
And SDCC (Small Device C Compiler) is a GPL tool that can be used to build 
firmware drivers: http://sdcc.sourceforge.net/

Regards,
Pedro



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
