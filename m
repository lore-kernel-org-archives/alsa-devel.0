From: Russ Pridemore <russ.pridemore@comcast.net>
Subject: Chaintech AV710
Date: Sat, 04 Dec 2004 14:26:29 -0500
Message-ID: <1102188389.9490.17.camel@localhost>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.  I have a Chaintech AV710 (Envy24HT) card in an Athlon64 system
running Gentoo Linux.  I am attempting to configure it to output sound
to my stereo through its S/PDIF optical jack.  Stereo sound appears to
be working (with xmms) if I connect line-out to my stereo, but hooking
up digital, speaker-test -c6 produces nothing.  Neither does xmms.
Running speaker-test -c6 through line-out worked, but only stereo, of
course.  How do I get surround-sound working, specifically ac3
passthrough for mplayer, etc.?

The only thing I see in the system log is this:
 ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 169
 ice1724: Invalid EEPROM version 1

Interrupt 169 is the sound card:
$ cat /proc/asound/cards
0 [AUDIO2000      ]: ICE1724 - AMP Ltd AUDIO2000
                     AMP Ltd AUDIO2000 at 0x9000, irq 169


Thanks,
Russ



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
