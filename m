From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000779]: SPDIF audio is broken up... stutters
Date: Mon, 31 Jan 2005 18:57:31 +0100
Message-ID: <81d071c497f96f862c66de5f03067217@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9A55A231
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 18:57:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=779> 
======================================================================
Reported By:                jeffgus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   779
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-ac16
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-03-2005 05:50 CET
Last Modified:              01-31-2005 18:57 CET
======================================================================
Summary:                    SPDIF audio is broken up... stutters
Description: 
I was previously able to send ac3 audio via the coaxial output to an
external amp (a Creative 5.1 amp).  At some point after upgrading to FC2
(not sure when) I noticed that when I played DVDs the AC3 wouldn't come
out right.  It's all broken up.  The light on the amp blinks.  The light
comes on when it decodes a segment of audio then goes out with silence.

The AC3 used to work perfectly with 2.4 kernel.  I'm not sure chance
caused the problem (upgrade to 2.6?).

======================================================================

----------------------------------------------------------------------
 jeffgus - 01-30-05 06:53 
----------------------------------------------------------------------
This issue can now be closed.  The problem seemed to go away after I
finally got around to installing alsa 1.0.8 this evening.

----------------------------------------------------------------------
 tiwai - 01-31-05 18:57 
----------------------------------------------------------------------
OK, closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 05:50 jeffgus        New Issue                                    
01-03-05 05:50 jeffgus        Distribution              => Fedora Core 2   
01-03-05 05:50 jeffgus        Kernel Version            => 2.6.9-ac16      
01-07-05 02:22 chutzimir      Note Added: 0003100                          
01-07-05 02:32 chutzimir      Issue Monitored: chutzimir                    
01-07-05 11:10 jeffgus        Note Added: 0003101                          
01-07-05 11:15 jeffgus        Note Edited: 0003101                         
01-30-05 06:53 jeffgus        Note Added: 0003440                          
01-31-05 18:57 tiwai          Status                   new => resolved     
01-31-05 18:57 tiwai          Resolution               open => fixed       
01-31-05 18:57 tiwai          Assigned To               => tiwai           
01-31-05 18:57 tiwai          Note Added: 0003454                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
