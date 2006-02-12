From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001383]: ac3 passthrough lost in 2.6.12 and later
Date: Sun, 12 Feb 2006 17:13:40 +0100
Message-ID: <144071bdf2b77eb4d9aaef6ac7908c65@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A49F1AE
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 17:13:41 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1383> 
======================================================================
Reported By:                Antonio
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1383
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.12-1.1376_FC3
======================================================================
Date Submitted:             08-31-2005 11:52 CEST
Last Modified:              02-12-2006 17:13 CET
======================================================================
Summary:                    ac3 passthrough lost in 2.6.12 and later
Description: 
i have an audigy2 board
when i used an 2.6.11 FC kernel (2.6.11-1.35_FC3) and earlier ones all was
fine.
when i updated to 2.6.12 fc3 kernels (2.6.12-1.1372_FC3 and
2.6.12-1.1376_FC3) ac3 passthrough works no more.
When i boot back to 2.6.11 ac3 is back....

i consider the following patch(2.6.12 kernel changelog) is the reason:

<perex@suse.cz>
        [ALSA] Enables SPDIF output on the Audigy2 Value
        
        EMU10K1/EMU10K2 driver
        Enables SPDIF output on the Audigy2 Value.
        It seems to work for PCM, but not AC3 yet.


======================================================================

----------------------------------------------------------------------
 fmoraes - 02-12-06 17:13 
----------------------------------------------------------------------
This is not an emu10k1x card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 11:52 Antonio        New Issue                                    
08-31-05 11:52 Antonio        Distribution              => Fedora Core 3   
08-31-05 11:52 Antonio        Kernel Version            => 2.6.12-1.1376_FC3
02-12-06 17:13 fmoraes        Note Added: 0008030                          
02-12-06 17:13 fmoraes        Assigned To              fmoraes => jcdutton 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
