From: Frank van de Pol <fvdpol@home.nl>
Subject: Opensource MIDISport firmware: microscheduling possible?
Date: Mon, 28 Apr 2003 21:52:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030428195247.GB31830@obelix.fvdpol.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail8-sh.home.nl (mail8.home.nl [213.51.128.28])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA27974
	for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2003 22:36:56 +0200
Received: from obelix ([213.51.160.100]) by mail8-sh.home.nl
          (InterMail vM.5.01.05.17 201-253-122-126-117-20021021) with ESMTP
          id <20030428203138.EZBH1791.mail8-sh.home.nl@obelix>
          for <alsa-devel@alsa-project.org>;
          Mon, 28 Apr 2003 22:31:38 +0200
Received: from frank by obelix with local (Exim 3.36 #1 (Debian))
	id 19AEgG-0008R3-00
	for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2003 21:52:52 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Here's a small story for the midi/hardware freaks;

I'm running my Midiman Midisport 4x4 USB Interface using Clemens's firmware
loader (Thanks Clemens!), and am quite happy with it.

The Midiman devices are using a Cypress EZUSB 2131 microcontroller for which an
opensource firmware exists (by Lars Doelle,
http://member.nifty.ne.jp/Breeze/softwares/unix/usbmidi-e.html). Unfortunate
the open source firmware does only support 2 ports of my interface :-( 
Out of curiosity I opened the box to look inside for clues why only 2 of my
ports are supported. Knowing that the EZUSB 2131 does only have 2 uarts I
had good faith to find some external hardware to provide the additional 2
ports; in this case it was implemented using an Exar ST16C552
(http://www.exar.com/products/st16c552_a.pdf), probably connected to the 2131
using a 8 bit bus. For those interested I have scans of the pcb. 


You'll probably ask yourself why all this fuss. After finding out that the
EZUSB chip is in quite a powerfull programmable cpu, with 3 onboard high
precision timers onboard, I got intriqued by the potential to implement
microscheduling/timestamping for the midi data (ie. helper for the
sequencer) inside the little box. 

Commercial high-end midi interfaces with similar functionality exist, though
their protocol is not disclosed - know as Emagic AMT (active midi
transmission) or Steinberg LTB (linear timebase).

Perhaps this gives some inspiration, in the mean time I'll pour me another beer.

Cheers,
Frank.


btw: info for the cypress microcontroller available at:
http://www.cypress.com/cfuploads/img/products/AN2131SC.pdf

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
