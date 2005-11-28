From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in full duplex, works with OSS, griffin imic
Date: Mon, 28 Nov 2005 10:32:50 +0100
Message-ID: <9460d1a213c3b5a576e702471c835299@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73A4B1A2
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2005 10:32:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=521> 
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              11-28-2005 10:32 CET
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with
OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000758 Full duplex is not working in OSS emula...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-28-05 10:24 
----------------------------------------------------------------------
What are Jack's command line parameter and its error messages?

----------------------------------------------------------------------
 croiset - 11-28-05 10:32 
----------------------------------------------------------------------
I didn't test with jack but directly with an oss recorder. This in relation
ship with the bug 758 where you have the detailed description of the test.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Issue                                    
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
10-08-04 18:32 ryanpg         Issue Monitored: ryanpg                      
10-08-04 18:40 ryanpg         Note Added: 0002055                          
09-14-05 15:49 jdthood        Note Added: 0006160                          
09-14-05 16:16 jdthood        Relationship added       related to 0000758  
11-28-05 09:54 croiset        Note Added: 0006854                          
11-28-05 10:24 Clemens LadischNote Added: 0006855                          
11-28-05 10:32 croiset        Note Added: 0006856                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
