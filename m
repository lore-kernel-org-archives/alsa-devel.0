From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000470]: Inverted master volume control on TerraTec Aureon 7.1 Space
Date: Tue, 9 Nov 2004 16:31:47 +0100
Message-ID: <85199561f19521f932148e8d1932db66@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 021F02A9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:31:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=470> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   470
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux 3.1
Kernel Version:             2.6.9-rc1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-29-2004 00:43 CEST
Last Modified:              11-09-2004 16:31 CET
======================================================================
Summary:                    Inverted master volume control on TerraTec Aureon
7.1 Space
Description: 
It seems that the master volume control on (at least some) TerraTec Aureon
7.1 Space cards are inverted, thus setting the volume to 100 in alsamixer
practically mutes the sound.
The front volume control (and probably the rest) operates correctly.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-13-04 16:04 
----------------------------------------------------------------------
Already fixed on cvs (1.0.7rc1).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 00:43 ungod          New Issue                                    
08-29-04 00:43 ungod          Distribution              => Debian GNU/Linux 3.1
08-29-04 00:43 ungod          Kernel Version            => 2.6.9-rc1       
09-13-04 16:04 tiwai          Status                   new => resolved     
09-13-04 16:04 tiwai          Resolution               open => fixed       
09-13-04 16:04 tiwai          Assigned To               => tiwai           
09-13-04 16:04 tiwai          Note Added: 0001750                          
11-09-04 16:31 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
