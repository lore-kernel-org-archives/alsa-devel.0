From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001392]: Configuration file ICE1724.conf is oncorrect for surround40 (among others)
Date: Fri, 2 Sep 2005 18:41:13 +0200
Message-ID: <b74257129fe4ebade36d6d8b614afcc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3374169
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 18:41:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1392> 
======================================================================
Reported By:                herby
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1392
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-02-2005 09:02 CEST
Last Modified:              09-02-2005 18:41 CEST
======================================================================
Summary:                    Configuration file ICE1724.conf is oncorrect for
surround40 (among others)
Description: 
The file ICE1724.conf (installed normally in /usr/share/alsa/cards has an
incorrect definition for surround40.  The ICE1724 driver was changed a few
versions ago to split the two codecs used (on the M-Audio revolution 7.1
one is 2 channels, the other is 6 channels).  The definition for the
'rear' channels was added and specified "device 2" (see paragraph
ICE1724.pcm.rear.0).  Unfortunately the definition for
"ICE1724.pcm.surround40.0" does NOT refer to the second device.  Honestly
I'd like to modify the definition, but I am not versed in the minutia of
'asoundrc' type files.  I'm sure that it is possible to do this.  In
addition, the definitions for surround41, surround50, surround51, and
surround71 all probably need some modification.  I don't know if ALL
ICE1724 cards need this, but the M-Audio Revolution 7.1 cards needs this.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 16:35 
----------------------------------------------------------------------
Except for that the wrong channel number 4 is set in surround40 definition,
it's not bad at all.  Instead, this is because of a bug happening with the
combination of plug and route plugins.  If you pass S32 samples to
surround40/51/71, it should work fine.

----------------------------------------------------------------------
 tiwai - 09-02-05 18:41 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-02-05 09:02 herby          New Issue                                    
09-02-05 09:03 herby          Issue Monitored: herby                       
09-02-05 09:04 herby          Note Added: 0006004                          
09-02-05 16:35 tiwai          Note Added: 0006011                          
09-02-05 18:41 tiwai          Status                   new => resolved     
09-02-05 18:41 tiwai          Resolution               open => fixed       
09-02-05 18:41 tiwai          Assigned To               => tiwai           
09-02-05 18:41 tiwai          Note Added: 0006012                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
