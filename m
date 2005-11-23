From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001593]: au88x0 wt synth
Date: Wed, 23 Nov 2005 20:54:42 +0100
Message-ID: <0e359045bec02b305e1edb0e7762f84e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7E7A016E
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:54:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1593> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1593
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             11-23-2005 17:16 CET
Last Modified:              11-23-2005 20:54 CET
======================================================================
Summary:                    au88x0 wt synth
Description: 
After applied the patch as described in 

http://article.gmane.org/gmane.linux.alsa.devel/27095

Sound (like a monster roaring) is heard when using aplay through device 3
of au8830 with the mono files from alsa-utils-1.0.10/speaker-test/samples

The sound repeat 7 times and stop.

Refer to the strace, 

Do the DMA transfer occur when using hw:0,3 ?



======================================================================

----------------------------------------------------------------------
 mjander - 11-23-05 20:54 
----------------------------------------------------------------------
The WT Engine (device 3) did never work. I'm working on a major driver
rework in order to make the WT work correctly, basically unifying the ADB
and WT DMA handling routines. I can't tell when I will finish, but I'm
advancing steadily.

Best Regards,
Manuel

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-05 17:16 Raymond        New Issue                                    
11-23-05 17:16 Raymond        Distribution              => Fedora Core 1   
11-23-05 17:16 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
11-23-05 20:54 mjander        Note Added: 0006832                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
