From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001196]: my soundcard is not detected and irritating me
Date: Fri, 30 Dec 2005 22:00:48 +0100
Message-ID: <5007a129a7c141038a355a52dd102914@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9967190
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 22:00:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1196> 
======================================================================
Reported By:                sai prasad
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1196
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             kernel-2.6.5-1.358smp
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-16-2005 12:52 CEST
Last Modified:              12-30-2005 22:00 CET
======================================================================
Summary:                    my soundcard is not detected and irritating me
Description: 
I have downloaded alsa-1.0.9rc4a.
I followed the following steps:
1: bunzip2 alsa-1.0.9rc4a.tar.bz2
2: tar xvf alsa-1.0.9rc4a.tar
3: cd alsa-1.0.9rc4a
4: 1.

      The driver: "./configure --with-oss=yes --with-cards=hda-intel",
then "make", and "sudo make install".
   2.

      The library, oss-lib, and utils - simply "./configure" "make" "sudo
make install"
   3.

      Run "sudo alsaconf" and configure the sound card.
   4.

      Reboot.
Some of the above are failed
Still  i have not succeeded
I get vexed
Please help me
======================================================================

----------------------------------------------------------------------
 pzad - 06-16-05 13:05 
----------------------------------------------------------------------
cat /proc/asound/version

----------------------------------------------------------------------
 rlrevell - 12-30-05 22:00 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-05 12:52 sai prasad     New Issue                                    
06-16-05 12:52 sai prasad     Kernel Version            => kernel-2.6.5-1.358smp
06-16-05 12:58 sai prasad     Note Added: 0005051                          
06-16-05 13:05 pzad           Note Added: 0005052                          
06-16-05 14:35 perex          Assigned To              perex =>            
06-16-05 14:36 perex          Status                   assigned => new     
06-18-05 10:14 sai prasad     Note Edited: 0005051                         
12-30-05 22:00 rlrevell       Status                   new => closed       
12-30-05 22:00 rlrevell       Note Added: 0007267                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
