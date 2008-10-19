From: James Courtier-Dutton <James@superbug.co.uk>
Subject: 20K1 PCI bars, and mode switching info.
Date: Sun, 19 Oct 2008 17:07:08 +0100
Message-ID: <48FB5B2C.3030008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id B2AFB2448E
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 18:07:29 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.67)
	id 1KraoB-0004jM-7R
	for alsa-devel@alsa-project.org; Sun, 19 Oct 2008 16:07:11 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This info should help the current snd-sbxfi driver to actually work with
the "Vista compatible" cards that it currently does not work with.
I believe the true UAA to 20K1 mode switch code is missing from the
current alsa snd-sbxfi driver.


PCI BARs

UAA mode, or Vista Compatibility mode.
	BAR0:	16K for UAA
		
  14h	BAR1:	2M for 20k1 (low 32 bit)
  18h		2M for 20k1 (high 32 bit)
  1Ch	BAR2:	Between 2 and 256M for 20k1 (low 32 bit)
  20h		Between 2 and 256M for 20k1 (high 32 bit)
  24h	BAR3:	32 bit I/O for 20K1

20K1 Mode
	BAR0:	32 bit I/O for 20K1
		
  14h	BAR1:	2M for 20k1 (low 32 bit)
  18h		2M for 20k1 (high 32 bit)
  1Ch	BAR2:	Between 2 and 256M for 20k1 (low 32 bit)
  20h		Between 2 and 256M for 20k1 (high 32 bit)
  24h		

"UAA/20K1 mode" and "config space selection" work independently of each
other.

1) Configuration space selection:

This allows the driver to talk to both the UAA and 20K1 configuration
space whichever mode (UAA or 20K1) the card is in.
Location: PCI Register 0xA0 for "20K1 Configuration Space Flag" register.

Value: 0x12345678 to select 20K1 without BAR0 exposed;
Value: 0x87654321 to select 20K1 with BAR0 exposed;
       (should disable immediately after using.)
Value: 0x00000000 to select UAA.

2) UAA/20K1 MODE CHANGE (controls who the bus master is):
The "Mode Change" register is located in the UAA configuration space at
location offset 0x3FFC. This location stores 4 values in a ring.
To switch from 20K1 mode to UAA mode write each DW value: CTLA, CTLZ,
CTLL, CTLA.
To switch from UAA mode to 20K1 mode write each DW value: CTLX, CTL-,
CTLF, CTLi
To read the current mode, the 4 value ring may be in any position, so
one might read for example:
CTLL, CTLA, CTLA, CTLZ

At power on, the card is in UAA mode.
In UAA mode, the UAA chip is the bus master.
In 20K1 mode, the 20K1 chip is the bus master.
Under either UAA mode or 20K1 mode, the driver can read and write the
configuration space of both UAA chip and 20K1 chip.
