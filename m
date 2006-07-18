From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000578]: No soundcard detected on
	Chaintech 9CJS
Date: Tue, 18 Jul 2006 11:58:52 +0200
Message-ID: <fca679665c878cbe30a26696ba63ba2f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85E86219
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 11:58:52 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=578> 
======================================================================
Reported By:                tarsi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   578
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               mandrake linux 10.1
Kernel Version:             2.6.8.1-10mdksmp
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-11-2004 12:58 CEST
Last Modified:              07-18-2006 11:58 CEST
======================================================================
Summary:                     No soundcard detected on Chaintech 9CJS
Description: 
 cat /proc/asound/cards don't stop and gives many lines "--no souncards--"

/etc/init.d/alsaconf found ice1724 card, but exiting gives:
.... 

/usr/sbin/alsactl: save_state:1066: No soundcards found...

======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 18:15 
----------------------------------------------------------------------
The noise problem might have been fixed recently.  Try 1.0.9rc2.

The latest ice1724 driver already has an entry for Chaintech 9CJS.  So,
please make sure that the driver does _NOT_ work with the latest ALSA.

If the model=k8x800 works, it's simple to fix.  Please show the output of
lspci -nv.

----------------------------------------------------------------------
 tiwai - 06-15-05 15:30 
----------------------------------------------------------------------
Ping.  Any answer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 12:58 tarsi          New Issue                                    
10-11-04 12:58 tarsi          File Added: command-outputs.tar.bz2               
    
10-11-04 12:58 tarsi          Distribution              => mandrake linux 10.1
10-11-04 12:58 tarsi          Kernel Version            => 2.6.8.1-10mdksmp
10-11-04 12:58 tarsi          Issue Monitored: tarsi                       
10-11-04 15:59 tiwai          Note Added: 0002081                          
04-09-05 16:09 jdthood        Note Added: 0004407                          
04-14-05 12:53 tarsi          Note Added: 0004491                          
04-14-05 22:00 jdthood        Note Added: 0004496                          
04-14-05 22:00 jdthood        Severity                 block => major      
04-14-05 22:00 jdthood        Status                   new => acknowledged 
04-14-05 22:00 jdthood        Additional Information Updated                    
04-19-05 18:15 tiwai          Note Added: 0004533                          
06-15-05 15:30 tiwai          Note Added: 0005034                          
07-18-06 11:58 Adrian Bunk    Status                   acknowledged => resolved
07-18-06 11:58 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
