From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000960]: IBM T42p - 82801DB (ICH4) Not working properly
Date: Fri, 30 Dec 2005 21:44:37 +0100
Message-ID: <6290d3fdf6fd039b77116e7206e719d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 244DF184
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 21:44:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=960> 
======================================================================
Reported By:                marcusvfx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   960
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware-Current
Kernel Version:             2.6.11
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-03-2005 21:15 CET
Last Modified:              12-30-2005 21:44 CET
======================================================================
Summary:                    IBM T42p - 82801DB (ICH4) Not working properly
Description: 
As in reference to the kernel discussion about the 8x0 driver, the above
does not work when playing through the port replicator jack.  To get sound
to work through the speakers, the "headphone jack sense" must be turned
off.  If that is the case, the internal speakers on the T42p do work and
so will the headphones, but the port replicator output jack will not.  In
fact, there is no fix that I have uncovered under the 2.6.11 kernel to get
the port replicator output jack to work.

The alsa-cvs (as of 3 March) driver was compiled into the 2.6.11 kernel
but it did not resolve the issue above.

This was not the case in previous kernels and it was introduced somewhere
after the 2.6.10-2.6.11 releases.  With 2.6.10 and earlier kernels, the
headphone jack on the laptop, internal speakers, and port replicator
output jack will work with the 'headphone jack sense' set to on.
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 10:39 
----------------------------------------------------------------------
Does ALSA 1.0.9a fix this problem?

----------------------------------------------------------------------
 rlrevell - 12-30-05 21:44 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 21:15 marcusvfx      New Issue                                    
03-03-05 21:15 marcusvfx      Distribution              => Slackware-Current
03-03-05 21:15 marcusvfx      Kernel Version            => 2.6.11          
06-06-05 10:39 perex          Note Added: 0004896                          
06-06-05 10:39 perex          Category                 0_compilation problem_!!!
=> PCI - intel8x0
06-06-05 11:01 perex          Assigned To              perex =>            
06-06-05 11:01 perex          Status                   assigned => new     
12-30-05 21:44 rlrevell       Status                   new => closed       
12-30-05 21:44 rlrevell       Note Added: 0007264                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
