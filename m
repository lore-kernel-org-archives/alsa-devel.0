From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP -- linux CardBus issue : further information
Date: Wed, 29 May 2002 12:23:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17D0bp-0000Og-00@satellite>
Reply-To: thomas@undata.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite (ALyon-101-1-1-130.abo.wanadoo.fr [193.251.82.130])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA25940
	for <alsa-devel@alsa-project.org>; Wed, 29 May 2002 12:23:00 +0200
Received: from toma by satellite with local (Exim 3.35 #1 (Debian))
	id 17D0bp-0000Og-00
	for <alsa-devel@alsa-project.org>; Wed, 29 May 2002 12:23:13 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Paul,

Here are some new elements that may help you :
- You said that under windows the bios settings were used to configure the 
card, thus asked Ico and I to boot using pci=biosirq, which I did, to find 
that the card was given the same IRQ as before (10)  (I was supposed to have 
an IO problem, not an IRQ one) . Then I checked under windows, and the card 
is given 9 as its IRQ, so there may be a problem using the bios settings on 
my machine under linux.
- There is something weird in the pci buses hierarchy on my machine.
lspci -M gives:
00: Primary host bus
        1e.0 Bridge to 02-02
        01.0 Bridge to 01-01
01: Entered via 00:01.0
02: Entered via 00:1e.0
        04.1 Bridge to 07-0a <crossing bug>
        04.0 Bridge to 03-06 <crossing bug>
03: Secondary host bus (?)

Thomas


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
