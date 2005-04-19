From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001060]: snd-azx rear speakers volume is too low
Date: Tue, 19 Apr 2005 20:56:59 +0200
Message-ID: <f5192a68d70bd7e91dd15b371d808817@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 87C4A1C7
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 20:56:59 +0200 (MEST)
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
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-17-2005 23:56 CEST
Last Modified:              04-19-2005 20:56 CEST
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

----------------------------------------------------------------------
 maranik - 04-19-05 20:56 
----------------------------------------------------------------------
I installed 1.0.9rc2 and i loaded snd-hda-intel. The problem persists, and
the sound quality is worse than before.
I hope you can help me. 

TIA

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 23:56 maranik        New Issue                                    
04-17-05 23:56 maranik        Distribution              => Ubuntu Linux    
04-17-05 23:56 maranik        Kernel Version            => 2.6.11.7        
04-19-05 17:41 tiwai          Note Added: 0004525                          
04-19-05 17:41 tiwai          Category                 PCI - azx => PCI -
hda-intel
04-19-05 20:53 maranik        File Added: asound.state                     
04-19-05 20:53 maranik        File Added: codec#2                          
04-19-05 20:56 maranik        Note Added: 0004539                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
