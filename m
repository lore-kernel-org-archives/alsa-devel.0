From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001654]: Support for Midiman (M-audio) Biport 2x4s
Date: Fri, 16 Dec 2005 09:12:24 +0100
Message-ID: <788792c147504be46d104ef946a9cdef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0407C1B1
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2005 09:12:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1654> 
======================================================================
Reported By:                pumpkin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1654
Category:                   GENERIC - serialmidi
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware 10.2
Kernel Version:             
======================================================================
Date Submitted:             12-15-2005 23:21 CET
Last Modified:              12-16-2005 09:12 CET
======================================================================
Summary:                    Support for Midiman (M-audio) Biport 2x4s
Description: 
I have a Midiman Biport 2x4s (a midi-interface that connects to the
serial-port) that I cant get to work in Linux. I have seen that there is
support for many other midi-interfaces by Midiman (M-audio) in ALSA but I
havent seen support for my model. I have searched the internet and asked
around for drivers and stuff to get it to work but with no luck so far.
Is there support for my model that I havent found yet? and if not, will
there be any support for my model soon?
unfortunately I am pretty new to linux so I cant make my own driver so I
am happy for all the help I can get.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 12-16-05 09:12 
----------------------------------------------------------------------
Most serial MIDI interfaces use a Sound Canvas compatible protocol.
Does it work with the following commands?

setserial /dev/ttyS0 uart none
modprobe snd-serial-u16550 port=0x3f8 irq=4 outs=4 ins=2 adaptor=0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-05 23:21 pumpkin        New Issue                                    
12-15-05 23:21 pumpkin        Distribution              => slackware 10.2  
12-15-05 23:22 pumpkin        Issue Monitored: pumpkin                     
12-16-05 09:12 Clemens LadischNote Added: 0007057                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
