From: "Gerald C. Simmons" <simmons@darykon.cet.com>
Subject: Problems with ESS1879 in SuSE Linux 7.3
Date: Mon, 11 Mar 2002 22:22:22 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203120622.g2C6MMH01237@dakkon.darykon.cet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have an Hitachi Laptop with an ESS1879 sound system on board. I have installed
SuSE Linux 7.3, but I'm having great difficulty in getting the sound support up
and running. 

My laptop's BIOS has settable parameters for the chipset representing IRQ, DMA's,
and I/O addresses for the Sound Port (0x220) and the MPU-401 port (0x330.) Also,
the ability to disable the FM Synthesizer.

I used YaST2 and the Sound module to set it up. I select ESS 1879, and use the
Advanced Setup options to set all the above parameters. The sound drivers load
O.K., but when I press the Test Button (after turning the volume up,) a short
burst of the music (300-500msec) comes out and starts repeating, and would never
stop unless I press Test again and it muddles it's way to the end of the tune
(sounding Badly.) 

I let the sound module finish installing the sound system, but I don't get any
sound out of any apps. under KDE.

I've tried different IRQ's different DMA channels; I even disabled the FM
Synthesizer. Nothing seems to have an effect.

Can you give me any clues as to what to try to get this to work?

BTW, all this hardware works fine under ANY Microsoft Windows OS.

Thanks in advance for any assistance you can offer!

Gerry Simmons
gerry@darykon.cet.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
