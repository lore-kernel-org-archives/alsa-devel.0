From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000510]: Utilization of AC'97 on Aureon 7.1 Space
Date: Tue, 28 Sep 2004 19:13:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928171300.2419D46008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7B977316
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 19:13:39 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000510
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     510
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             3.1
Resolution:                 fixed
======================================================================
Date Submitted:             09-21-2004 09:41 CEST
Last Modified:              09-28-2004 19:12 CEST
======================================================================
Summary:                    Utilization of AC'97 on Aureon 7.1 Space
Description: 
As of now, the Aureon driver lacks the capability to playback both analog
input channels and the PCM channel, and the input channels have no
seperate volume control, although the AC'97 chip on the board, STAC9744,
apparently has the capability.

I tried some commercial OSS drivers, and they worked properly, so I know
that it is possible.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-21-2004 11:54 CEST 
----------------------------------------------------------------------
Unfortunately, no information from terratec at all about this.

----------------------------------------------------------------------
 ungod - 09-23-2004 20:47 CEST 
----------------------------------------------------------------------
Which is sad.

Anyway, by looking at the GPIO pins after changing the volume of one of
the analog inputs with the commercial drivers, the value which is to be
stored in the AC'97 chip is stored on GPIO[7:0]. Not much help, but it
gives an idear of how the XILINX chip is to be used. You probably define
the register address on the same pins, toggle one of the other pins, and
the puts the data on the pins and toggle another pin again.

I don't know. Purely speculations...

edited on: 09-23-04 20:47

----------------------------------------------------------------------
 ungod - 09-27-2004 00:45 CEST 
----------------------------------------------------------------------
Wow. A whole weekend of testing and working and I have finally managed to
get the AC'97 to work.
Appararently I was not entirely wrong about the utilization of the XILINX
chip.

Related GPIO pins:

GPIO[7:0]  Data bits
GPIO8      Data high toggle bit
GPIO9      Data low toggle bit
GPIO10     Address toggle bit
GPIO11     Commit toggle bit
GPIO16     STAC9744 RESET pin

Initialization is done by setting GPIO[7:0] to zero and toggling the RESET
pin low and then high.

Writing to the chip is done as follows:
Address is latched on GPIO[7:0]
Address toggle bit (GPIO10) is toggled high and low
Low-order data is latched on GPIO[7:0]
Data low toggle bit (GPIO9) is toggled high and low
High-order data is latch on GPIO[7:0]
Data high toggle bit (GPIO8) is toggled high and low
Commit bit (GPIO11) is toggled high and low.

Unfortunately this interface leaves no option for reading from the AC'97
chip (as far as I see, although the GPIO13 is also connected to the XILINX
chip and may have some saying) so we must maintain a local (assumed) copy
of the EEPROM - just as with the WM8770 chip.

Anyway, since the PCM features is not used on the Aureon card, the only
logical mixers to include would be Line/CD/Aux/Mic/Master and the Mic
Boost. Maybe also the 3D settings.

As to hearing both DAC and analogue input channels, this is actually
performed by the WM8770. I noticed that it is capable of mixing the
multiplexed analogue input channel and an AUX channel with the DAC
channel, but the ALSA mixer did not have any option for this, so I added
it, and noticed that the AC'97 chip was actually connected to the AUX1
channel. But since the quality of the bypassed analogue channels was
really bad compared to the AUX, I later removed that and simply hardcoded
the front channel to mix the DAC signal and the AUX1 line.

I've had problems where it seems like the WM8770 stalls or something and
all sound disappear, however this is a thing I've noticed with both the
(unmodified) ALSA drivers and 4Front's commercial OSS drivers, and also
before I ever began playing with the sound card registers, so this may be
a hardware problem only related to my card.

edited on: 09-27-04 00:45

----------------------------------------------------------------------
 ungod - 09-27-2004 00:37 CEST 
----------------------------------------------------------------------
Here is my patch, adding AC'97 support for Aureon cards. It is obvious
quite untested as of now, so it probably still have bugs somewhere.

Summary: Adds AC'97 support to Aureon cards.

This patch adds support of the STAC9744 chip located on Aureon cards,
enabling volume control for analogue input channels.
It also adds the posibility of listening to both the analogue inputs and
the digital audio.

Signed-off-by: Peter Christensen <peter@developers.dk>

----------------------------------------------------------------------
 tiwai - 09-27-2004 16:46 CEST 
----------------------------------------------------------------------
Great, I applied the patch to CVS.

Note that I changed (cleaned up) ice1712 struct, so stac9744 field
is moved into ice->spec field, the board-specific data.
When you work on this driver further, please sync with CVS version.

Thanks.

----------------------------------------------------------------------
 ungod - 09-27-2004 20:18 CEST 
----------------------------------------------------------------------
Oh - my bad. I'll keep that in mind with future patches

----------------------------------------------------------------------
 tiwai - 09-28-2004 19:12 CEST 
----------------------------------------------------------------------
Ok, let's close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 09:41 ungod          New Bug                                      
09-21-04 09:41 ungod          Distribution              => Debian GNU/Linux
09-21-04 09:41 ungod          Kernel Version            => 3.1             
09-21-04 11:54 tiwai          Bugnote Added: 0001796                       
09-23-04 20:45 ungod          Bugnote Added: 0001848                       
09-23-04 20:47 ungod          Bugnote Edited: 0001848                      
09-23-04 20:47 ungod          Bugnote Edited: 0001848                      
09-27-04 00:33 ungod          Bugnote Added: 0001929                       
09-27-04 00:37 ungod          Bugnote Added: 0001930                       
09-27-04 00:37 ungod          File Added: aureon-ac97.diff                    
09-27-04 00:42 ungod          Bugnote Edited: 0001929                      
09-27-04 00:42 ungod          Bugnote Edited: 0001929                      
09-27-04 00:44 ungod          Bugnote Edited: 0001929                      
09-27-04 00:45 ungod          Bugnote Edited: 0001929                      
09-27-04 16:46 tiwai          Bugnote Added: 0001940                       
09-27-04 20:18 ungod          Bugnote Added: 0001942                       
09-28-04 19:12 tiwai          Bugnote Added: 0001954                       
09-28-04 19:12 tiwai          Assigned To               => tiwai           
09-28-04 19:12 tiwai          Resolution               open => fixed       
09-28-04 19:12 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
