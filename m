From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Thu, 15 Aug 2002 17:56:34 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5B6CC2.5040304@boosthardware.com>
References: <Pine.LNX.4.44.0208061855490.23759-100000@yme.mo.himolde.no> <3D591A58.11ABEA9@ladisch.de> <3D591F57.1060601@boosthardware.com> <200208141801.11087.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> El Mar 13 Ago 2002 17:01, Patrick Shirkey escribió:
> 
>>Clemens Ladisch wrote:
>>
>>>I didn't bother to report USB MIDI devices - until now:
>>
>>Thanks. I'm collecting them for now until I or Dan get the energy to add
>>them to the matrix.
> 
> 
> The "usb generic" instructions for USB-MIDI devices is a copy of the Midiman 
> MidisportNxN page. This is very inaccurate and confusing, as many devices 
> (e.g. the Roland/Edirol ones) aren't EZ-USB devices and don't need/accept the 
> ezusbmidi firmware at all. Please, remove the ezusbmidi references from the 
> generic usb-midi page.
> 

Currently I am trying to maintain as few pages as possible so the 
generic instructions access exactly the same data as ezusb devices. 
However I have made the ezusb instructions more recognisable.

If this is still too confusing then I will have to add another variable 
for all ezusb devices. I would rather not as it means one more little 
thing to remember. I will add a note on the matrix for these cards below.


> On the other hand, this device is reported by Clemens:
>  Steinberg        http://www.steinberg.net/
>     USB-2-MIDI       http://www.steinberg.net/products/ae/hardware/usb2midi/
> It is another EZ-USB based device, and needs the ezusbmidi firmware to work. 
> You can safely copy the Midisport page for it.
> 
> I would like to insist again about including "EZ-USB" in the chipset column 
> for  these devices: 
> 	Midiman Midisport NxN
> 	Midiman USB Keystations: 
> http://www.midiman.net/products/midiman/keystations.php
> 	Steinberg USB-MIDI-2 adaptor:
> http://www.steinberg.net/products/ae/hardware/usb2midi/
> 
> For the "chipset" column you can put here EZ-USB (or "Cypress AN2131XX") 
> http://www.cypress.com/products/datasheet.cfm?partnum=AN2131SC
> 
> This chipset is widely used in USB peripherals, not only MIDI ones, and it is  
> related to Intel 8051 chip. The firmware loader (fxload) for this chipset is 
> included in linux-hotplug: http://linux-hotplug.sourceforge.net/
> And SDCC (Small Device C Compiler) is a GPL tool that can be used to build 
> firmware drivers: http://sdcc.sourceforge.net/
> 
> Regards,
> Pedro
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Dice - The leading online job board
> for high-tech professionals. Search and apply for tech jobs today!
> http://seeker.dice.com/seeker.epl?rel_code=31
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
