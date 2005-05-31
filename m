From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000787]: Headphone == Master if plugged
Date: Tue, 31 May 2005 18:01:59 +0200
Message-ID: <60f8875c1dfcfe53bcccabe3bd0e642d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BBA6D1B6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:01:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=787> 
======================================================================
Reported By:                Nafallo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   787
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu Linux 5.10 (hoary)
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-06-2005 02:04 CET
Last Modified:              05-31-2005 18:01 CEST
======================================================================
Summary:                    Headphone == Master if plugged
Description: 
When I'm using headphones the master volume meter changes to headphones
volume meter, making me unable to use gnome-hotkeys to turn the volume
up/down (i.e. they change master that's inactivated by headphones).
======================================================================

----------------------------------------------------------------------
 tiwai - 01-12-05 15:11 
----------------------------------------------------------------------
Or better to try the second patch.  It changes the behavior of hp_only
quir.  So, with this patch, pass ac97_quirk=hp_only.

----------------------------------------------------------------------
 tiwai - 01-19-05 16:52 
----------------------------------------------------------------------
The patch was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-06-05 02:04 Nafallo        New Issue                                    
01-06-05 02:04 Nafallo        Distribution              => Ubuntu Linux 5.10
(hoary)
01-06-05 02:04 Nafallo        Kernel Version            => 2.6.9           
01-06-05 02:13 Nafallo        Issue Monitored: Nafallo                     
01-07-05 18:21 tiwai          Note Added: 0003109                          
01-07-05 21:07 Nafallo        Note Added: 0003121                          
01-11-05 16:21 tiwai          Note Added: 0003154                          
01-11-05 16:21 tiwai          File Added: ac97-bind-hp.diff                    
01-12-05 15:11 tiwai          Note Added: 0003169                          
01-12-05 15:11 tiwai          File Added: ac97-bind-hp2.diff                    
01-19-05 16:52 tiwai          Status                   new => resolved     
01-19-05 16:52 tiwai          Resolution               open => fixed       
01-19-05 16:52 tiwai          Assigned To               => tiwai           
01-19-05 16:52 tiwai          Note Added: 0003294                          
01-19-05 16:52 tiwai          Assigned To              tiwai =>            
05-31-05 18:01 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
