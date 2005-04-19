From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001060]: snd-azx rear speakers volume is too low
Date: Tue, 19 Apr 2005 17:41:09 +0200
Message-ID: <5cb9ab7e68a318cea1bc2b410d37cf49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CFC9218C
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:41:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1060> 
======================================================================
Reported By:                maranik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1060
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-17-2005 23:56 CEST
Last Modified:              04-19-2005 17:41 CEST
======================================================================
Summary:                    snd-azx rear speakers volume is too low
Description: 
I have a Azalia sound chip, sound works with snd-azx module, but i can only
listen to front speakers. Rear speakers are like inesistent. 
Sound is too low. 
I set 6ch in alsamixer.

TIA.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 17:41 
----------------------------------------------------------------------
First, try 1.0.9rc2.  If you have still problem, attach the contents of
/etc/asound.state and /proc/asound/card0/codec#* files for debugging.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 23:56 maranik        New Issue                                    
04-17-05 23:56 maranik        Distribution              => Ubuntu Linux    
04-17-05 23:56 maranik        Kernel Version            => 2.6.11.7        
04-19-05 17:41 tiwai          Note Added: 0004525                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
