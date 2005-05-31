From: Eliot Blennerhassett <linux@audioscience.com>
Subject: AudioScience standalone alsa driver
Date: Tue, 31 May 2005 21:30:39 +1200
Message-ID: <200505312130.39277.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from avmta4-rme.xtra.co.nz (avmta4-rme.xtra.co.nz [210.86.15.159])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5C31185
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 11:30:48 +0200 (MEST)
Received: from pop1-rme.xtra.co.nz ([210.86.15.240])
          by avmta4-rme.xtra.co.nz with ESMTP
          id <20050531093040.ZLGM2892.avmta4-rme.xtra.co.nz@pop1-rme.xtra.co.nz>
          for <alsa-devel@alsa-project.org>;
          Tue, 31 May 2005 21:30:40 +1200
Received: from blennerhassett.gen.nz ([222.153.177.88])
          by pop1-rme.xtra.co.nz with ESMTP
          id <20050531093040.ZTLA7985.pop1-rme.xtra.co.nz@blennerhassett.gen.nz>
          for <alsa-devel@alsa-project.org>;
          Tue, 31 May 2005 21:30:40 +1200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Greetings.

I have started working on making a standalone version of the alsa driver for 
audioscience cards.

(By which I mean the whole driver source is in the alsa tree, and doesn't rely 
on separately built HPI driver).

As a start, I have just thrown together the current asihpi.c (alsa driver 
module) with all the files for the HPI driver and made a couple of tweaks so 
that there is only one module init.

Here is the code for the adventurous:
http://www.audioscience.com/internet/download/beta/asihpi-standalone0.02.tar.bz2
Unpack it in the pci subdirectory of driver source (warning: overwrites 
Makefile there).  Everything else is created in asihpi subdirectory.

I'm quite well aware that the code needs a lot of bashing into shape to get it 
acceptable to alsa let alone the kernel... 

Goals for the near future are
* Get the PCI detection and probing working like a normal driver
* Enable bus master audio transfer for cards that support it
* Avoid spinlock around every HPI message transaction

all constructive comments welcome. ;-)

-- 
Eliot Blennerhassett
AudioScience Inc.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
