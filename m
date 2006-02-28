From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000800]: Sound is Corrupted or terribe quality.
Date: Wed, 1 Mar 2006 00:59:34 +0100
Message-ID: <28a996a38d9be961b656fc5a7ac0e932@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 951941C1
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:59:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=800> 
======================================================================
Reported By:                abonilla
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   800
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2005 03:20 CET
Last Modified:              03-01-2006 00:59 CET
======================================================================
Summary:                    Sound is Corrupted or terribe quality.
Description: 
Sound goes out just like if the jack was not propperly plugged. bad Sound
Quality.
======================================================================

----------------------------------------------------------------------
 pforai - 07-06-05 20:17 
----------------------------------------------------------------------
how can i set this option?

----------------------------------------------------------------------
 rlrevell - 12-30-05 22:11 
----------------------------------------------------------------------
Any improvement with later ALSA release?

You set the position fix option when the module is loaded (modprobe
snd-hda-intel position_fix=1).  You can also add it to a config file to
have this happen automatically but unfortunately this area of Linux is a
complete mess with every distro using a different file and syntax and
changing them all the time.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 03:20 abonilla       New Issue                                    
01-10-05 03:20 abonilla       Distribution              => Debian          
01-10-05 03:20 abonilla       Kernel Version            => 2.6.9           
01-10-05 14:56 tiwai          Note Added: 0003134                          
03-16-05 13:27 jdthood        Note Added: 0003956                          
03-18-05 18:23 tiwai          Note Added: 0004003                          
03-18-05 23:35 allefant       Issue Monitored: allefant                    
03-18-05 23:36 allefant       Issue End Monitor: allefant                    
03-19-05 12:42 jdthood        Note Added: 0004036                          
05-24-05 13:37 jdthood        Note Added: 0004725                          
05-24-05 13:37 jdthood        Note Edited: 0004725                         
05-24-05 14:12 tiwai          Note Added: 0004728                          
05-24-05 14:15 jdthood        Note Edited: 0004725                         
05-31-05 16:27 pforai         Note Added: 0004836                          
05-31-05 16:28 pforai         Note Edited: 0004836                         
06-08-05 16:11 tiwai          Note Added: 0004947                          
07-06-05 20:17 pforai         Note Added: 0005393                          
12-30-05 22:11 rlrevell       Note Added: 0007269                          
03-01-06 00:59 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
