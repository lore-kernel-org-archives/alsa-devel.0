From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: hdsploader, firmware and 1.0.8?
Date: 24 Jan 2005 22:44:44 -0800
Message-ID: <1106635483.14021.45.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, "Michael E. Smith" <melkhorn@gmx.de>
List-Id: alsa-devel@alsa-project.org

Hi alsa gurus... I just got a message from one of my Planet CCRMA users,
the ability of his two machines to load the hdsp firmware has
dissapeared after updating to the latest alsa packages I released (1.0.8
final). 

I'm still waiting for more data, but I'm including the relevant parts of
what he wrote to the list, in the hope that someone will already have
experience with this problem and how to fix it. I know hotplug should be
trying to download the firmware, but shouldn't hdsploader work anyway?

A couple of other users have reported success with echoaudio cards
(which also require firmware loading, I think) so this is unexpected. 

Thanks for any help.
-- Fernando

-----Forwarded Message-----

From: Michael E. Smith
To: planetccrma@ccrma.Stanford.EDU
Subject: [PlanetCCRMA] Help! HDSP firmware suddenly fails to load...
Date: 25 Jan 2005 03:47:17 +0100

I've just upgraded my two CCRMA boxes to the latest from the CCRMA
repositories and now my Digiface firmware won't load:

        hdsploader - firmware loader for RME Hammerfall DSP cards
        Looking for HDSP + Multiface or Digiface cards :
        Card 0 : RME Hammerfall DSP at 0x3e800000, irq 11
        Upload firmware for card hw:0
        Hwdep ioctl error on card hw:0 : Invalid argument.
        
This is the first time since switching to Fedora Core 2 and CCRMA that
I've had a problem with the HDSP.

Both machines refuse to load the firmware similarly, but not quite the
same. To wit, the laptop (cardbus/digiface) consistantly produces the
above error, while the desktop (pci/digiface) does it once and then
doesn't see a card at all.

It does, however, show up (on both machines) on an lspci listing. Also,
snd-hdsp shows up in lsmod.

dmesg snippet:

        ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:647: 
        	Hammerfall-DSP: no Digiface or Multiface connected!
        ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.8/alsa-kernel/pci/rme9652/hdsp.c:5086:
        	 card initialization pending : waiting for firmware
        
It would appear as though the firmware is attempting to be loaded
automatically at some point during user login (I can see from the lights
on the digiface), resulting in the error even before I attempt to load
it using hdsploader. 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
