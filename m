From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001055]: noise occurs when implementing 24bit recording
Date: Tue, 19 Apr 2005 18:12:18 +0200
Message-ID: <ae9b64860a96c9ede6b3135504b10c2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A77D201
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 18:12:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1055> 
======================================================================
Reported By:                hostaudio1
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1055
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-15-2005 05:54 CEST
Last Modified:              04-19-2005 18:12 CEST
======================================================================
Summary:                    noise occurs when implementing 24bit recording
Description: 
arecord -c 2 -f S24_LE -r 96000 w1.wav
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 18:12 
----------------------------------------------------------------------
S24_LE is a format to pack 24-bit into the *lower* 3 bytes of 4 bytes
alignment.  I guess you want to use S24_3LE, which packs the data in 3
bytes?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-05 05:54 hostaudio1     New Issue                                    
04-19-05 18:12 tiwai          Note Added: 0004532                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
