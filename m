From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000551]: Audigy ES
Date: Fri, 12 Nov 2004 12:26:59 +0100
Message-ID: <49994e60218a801ab88080ff5d18b871@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B06C280
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:26:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=551> 
======================================================================
Reported By:                Jakub Z
Assigned To:                perex
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   551
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-29-2004 22:44 CEST
Last Modified:              11-12-2004 12:26 CET
======================================================================
Summary:                    Audigy ES
Description: 
Hi. I have bought an Audigy ES. It is an OEM card with the Audigy chip
(unlike the Audigy LS, which is btw twice as expensive). I was afraid that
the card would not work with ALSA. I checked the sound matrix on the alsa
website and it wasn't listed there at all. However, it seems to work
(well, at least playback works perfectly, recording works also, however
the volume is much lower compared to a SB Live!. What doesn't work at all
are my headphones but I'll have to check it, maybe it's my setup).

What steps need to be taken so that the card is added as supported to the
sound matrix? Also, if you'd like any info regarding that card, just let
me know.
======================================================================

----------------------------------------------------------------------
 Jakub Z - 09-29-04 22:57 
----------------------------------------------------------------------
Well I have an issue with it that I didn't have with a SB Live!. When I do
a 'alsactl restore' while playing an mp3, I get:

alsactl: set_control:966: Cannot write control '2:0:0:EMU10K1 PCM Send
Routing:0' : Operation not permitted

I have to stop the playback and do a 'alsactl restore', then it works.

----------------------------------------------------------------------
 perex - 10-13-04 08:47 
----------------------------------------------------------------------
Added to matrix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-29-04 22:44 Jakub Z        New Issue                                    
09-29-04 22:57 Jakub Z        Note Added: 0001976                          
09-29-04 22:59 Jakub Z        Issue Monitored: Jakub Z                     
10-13-04 08:47 perex          Status                   new => resolved     
10-13-04 08:47 perex          Resolution               open => fixed       
10-13-04 08:47 perex          Assigned To               => perex           
10-13-04 08:47 perex          Note Added: 0002113                          
11-12-04 12:26 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
