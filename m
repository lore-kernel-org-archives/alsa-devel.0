From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Mon, 9 Jan 2006 01:43:19 +0100
Message-ID: <1b98becd5fdb85db9771caf5c14d547c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0AE6613C
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 01:43:19 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              01-09-2006 01:43 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================

----------------------------------------------------------------------
 legluondunet - 01-09-06 01:34 
----------------------------------------------------------------------
Hello,

I had the same problem: suddenly and with no reason, my system record
sound with only one channel :-(.
After severals hours of searches on internet and in the deeper place of my
system, I found a solution.

I have a Ubuntu live disc. I boot on it and test the record: 2 channels
were record (ok).
So I begin to replace the alsa config of my system with the Ubuntu one's.
After several tests, I found that when I change my
/usr/share/alsa/alsa.conf with the ubuntu nes, I could again record with 2
channels :-).
I don't know the differences between this 2 files so I join them.

I hope this help :-)

----------------------------------------------------------------------
 legluondunet - 01-09-06 01:43 
----------------------------------------------------------------------
I join the two files:
alsa.conf.record1channel
and
alsa.conf.ubuntu --> the file I copy from a ubuntu distrib, I could record
normaly with it.

My config:

Debian testing/unstable
P4 3ghz
soundcard:
 0 [ICH5           ]: ICH4 - Intel ICH5
                      Intel ICH5 with ALC650F at 0xee101000, irq 20
kernel 2.6.14

nota: before finding this solution I did this:
test several other kernels, test several recording applications, test
others alsa modules...lost my hair...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
01-09-06 01:35 legluondunet   File Added: alsa.conf.record1channel              
     
01-09-06 01:37 legluondunet   File Added: alsa.conf.ubuntu                    
01-09-06 01:43 legluondunet   Note Added: 0007530                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
