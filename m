From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000433]: Clicking noise on some sample rates with Chaintech AV-710 (ICE1724)
Date: Wed, 28 Dec 2005 22:38:51 +0100
Message-ID: <ff673317bd91a6e12b442a76727836b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B957190
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 22:38:51 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=433> 
======================================================================
Reported By:                cabbagerat
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   433
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Unstable
Kernel Version:             2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-09-2004 11:36 CEST
Last Modified:              12-28-2005 22:38 CET
======================================================================
Summary:                    Clicking noise on some sample rates with Chaintech
AV-710 (ICE1724)
Description: 
Playing sound at any sample rate other than 48000Hz produces a loud
clicking sound along with the expected sound. This started with the ALSA
included with kernel 2.6.7 (worked perfectly in 2.6.6).
Clicking sound is loudest at 44.1kHz, not present at 48Khz and soft but
noticeable at 96kHz.
I have tried playing with alsaplayer, aplay, mpg123 and a variety of
gstreamer based apps - all display this behavior. Both native alsa and OSS
emulation display the same problem.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 04:36 
----------------------------------------------------------------------
What's the status of this bug?  Any improvement in 2.6.10 or 2.6.11?
Does alsa-driver from tarball work better?

----------------------------------------------------------------------
 robhancock - 12-28-05 21:57 
----------------------------------------------------------------------
I think this can likely be closed. I saw this in the past but this has not
been a problem for many kernel versions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-09-04 11:36 cabbagerat     New Issue                                    
08-09-04 11:36 cabbagerat     Distribution              => Debian Unstable 
08-09-04 11:36 cabbagerat     Kernel Version            => 2.6.7           
08-09-04 11:37 cabbagerat     Issue Monitored: cabbagerat                    
08-21-04 02:40 av710user      Note Added: 0001603                          
08-22-04 10:04 cabbagerat     Note Added: 0001608                          
08-25-04 03:00 av710user      Note Added: 0001616                          
08-25-04 05:56 av710user      Note Added: 0001618                          
09-01-04 23:23 cabbagerat     Note Added: 0001681                          
12-03-04 23:00 escher9694     Issue Monitored: escher9694                    
04-09-05 04:36 jdthood        Note Added: 0004385                          
12-28-05 21:57 robhancock     Note Added: 0007182                          
12-28-05 22:38 rlrevell       Status                   new => resolved     
12-28-05 22:38 rlrevell       Resolution               open => fixed       
12-28-05 22:38 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
