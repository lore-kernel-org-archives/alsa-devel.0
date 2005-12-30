From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000758]: Full duplex is not working in OSS emulation.
Date: Fri, 30 Dec 2005 23:08:30 +0100
Message-ID: <0adc44420819067e445f46f53d80f6c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 68DD2AA
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:08:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=758> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   758
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 7.2
Kernel Version:             2.4.7
======================================================================
Date Submitted:             12-29-2004 10:15 CET
Last Modified:              12-30-2005 23:08 CET
======================================================================
Summary:                    Full duplex is not working in OSS emulation.
Description: 
If I play something with one player, I am unable to record something on the
same device.
The same thing ispossible with the other cards I have.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000521 Jack + Alsa not working in full duplex,...
======================================================================

----------------------------------------------------------------------
 croiset - 01-03-05 16:30 
----------------------------------------------------------------------
I made some more tests and the error after an ioctl.

line_fd = open(_opt->device, O_RDONLY|O_NONBLOCK )
-> ok
fcntl(line_fd,F_SETFD,FD_CLOEXEC)
-> ok
ioctl(line_fd, SNDCTL_DSP_SETFRAGMENT, &frag)
-> ok
ioctl(line_fd, SNDCTL_DSP_SETFMT, &afmt)
-> return -1 errno = 16 (Device or resource busy)
ioctl(line_fd, SNDCTL_DSP_CHANNELS,    &channels)
-> return -1 errno = 16 (Device or resource busy)
ioctl(line_fd, SNDCTL_DSP_SPEED,       &rate)
-> return -1 errno = 16 (Device or resource busy)
read(line_fd, audio_data, size)
-> return -1 errno = 16 (Device or resource busy)

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:08 
----------------------------------------------------------------------
This really seems like an application bug.

Any improvement in later ALSA release or with newer apps?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 10:15 croiset        New Issue                                    
12-29-04 10:15 croiset        Distribution              => Redhat 7.2      
12-29-04 10:15 croiset        Kernel Version            => 2.4.7           
12-29-04 14:17 tiwai          Note Added: 0002998                          
12-29-04 14:54 croiset        Note Added: 0003000                          
12-29-04 17:39 tiwai          Note Added: 0003004                          
12-29-04 17:56 croiset        Note Added: 0003005                          
12-29-04 17:59 croiset        Note Added: 0003006                          
12-29-04 18:05 croiset        Note Edited: 0003006                         
12-29-04 18:18 croiset        Note Edited: 0003006                         
01-03-05 16:30 croiset        Note Added: 0003067                          
09-14-05 16:16 jdthood        Relationship added       related to 0000521  
12-30-05 23:08 rlrevell       Note Added: 0007278                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
