From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000156]: MIDI fails with "cmd: 0xff failed at 0x300 (status = 0xff, data = 0xff)"
Date: Fri, 8 Jul 2005 10:38:21 +0200
Message-ID: <c4351efca3f59fea7bc5b3a8926a94fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 34E4F186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:21 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=156> 
======================================================================
Reported By:                gwittenburg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   156
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian testing/unstable
Kernel Version:             2.6.4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2004 06:07 CET
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    MIDI fails with "cmd: 0xff failed at 0x300 (status =
0xff, data = 0xff)"
Description: 
MIDI playback with aplaymidi doesn't produce any output with all channels
turned on in alsamixer. While aplaymidi is running a quiet, high-pitched
sound is comming from some part in the laptop. The following two lines
appear in dmesg:

cmd: 0xff failed at 0x300 (status = 0xff, data = 0xff)
cmd: 0x3f failed at 0x300 (status = 0xff, data = 0xff)

The same happens if the snd-intel8x0 module was inserted with
mpu_port=0x330. (btw, usually I would have expected one of these two to
fail...) snd_rawmidi is loaded with midi_map=0.
======================================================================

----------------------------------------------------------------------
 gwittenburg - 04-02-05 15:26 
----------------------------------------------------------------------
The problem has been solved: I neither can reproduce "cmd: 0xff failed at
0x300 (status = 0xff, data = 0xff)" nor the high-pitched sound anymore,
because the MIDI ports are now detected correctly as not being available,
i.e. "aplaymidi -l" returns no available ports. Hence I'm not able to play
MIDI on the sound chip directly, which is correct. This is an improvement
when compared to "aplaymidi -l" wrongly reporting "64:0 Rawmidi 0 - Intel
82801CA-ICH3 M Intel 82801CA-ICH3 MPU-401" with kernel 2.6.4. Now I'm
running 2.6.10 with Debian patches.

----------------------------------------------------------------------
 jdthood - 04-02-05 18:18 
----------------------------------------------------------------------
Thanks for the update.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 06:07 gwittenburg    New Issue                                    
03-24-04 06:07 gwittenburg    Distribution              => Debian
testing/unstable
03-24-04 06:07 gwittenburg    Kernel Version            => 2.6.4           
03-24-04 06:11 gwittenburg    Issue Monitored: gwittenburg                    
03-24-04 10:02 perex          Note Added: 0000696                          
03-24-04 13:10 gwittenburg    Note Added: 0000700                          
03-24-04 15:04 perex          Note Added: 0000701                          
03-25-04 02:32 gwittenburg    Note Added: 0000704                          
03-28-05 04:10 jdthood        Note Added: 0004231                          
04-02-05 15:26 gwittenburg    Note Added: 0004298                          
04-02-05 18:18 jdthood        Note Added: 0004299                          
04-02-05 18:18 jdthood        Status                   new => resolved     
04-02-05 18:18 jdthood        Resolution               open => fixed       
04-02-05 18:18 jdthood        View Status              @0@ => public       
04-02-05 18:18 jdthood        Description Updated                          
04-02-05 18:18 jdthood        Additional Information Updated                    
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
