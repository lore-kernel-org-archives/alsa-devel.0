From: Andreas Happe <andy@starseeders.net>
Subject: [i8x0] docking station audio-out ceased to work
Date: Wed, 14 Mar 2007 10:34:39 +0100
Message-ID: <1173864879.3425.4.camel@localhost>
Reply-To: andreashappe@snikt.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
i tried to use the bug tracking system but your MX seems to be not
available (thus I couldn't create an account for submitting).
alsa-project.org seems to be down so my research was very limited.

Problem:
The audio out on my Dell Docking station stopped working somewhere
around 2.6.20-rc?. While the normal headphone (and speaker) output on
the notebook are muted as soon as i attach the speakers to the docking
station's audio out there's no signal on the output.

I can test older kernel versions, but would like to make sure that I'm
testing the right think first.

Hardware in question:
Dell Latitude 610 with a Dell docking station.

| intel8x0_measure_ac97_clock: measured 50522 usecs
| intel8x0: clocking to 48000
| ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [LNKB] -> GSI 5 (level,
low) -> IRQ 5
| PCI: Setting latency timer of device 0000:00:1e.3 to 64
| ALSA sound/pci/ac97/ac97_codec.c:2138: MC'97 1 converters and GPIO not
ready (0xff00)
| ALSA device list:
|   #0: Intel ICH6 with STAC9750,51 at irq 11
|   #1: Intel ICH6 Modem at irq 5

Please contact me for further information.

TIA,
andreas happe


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
