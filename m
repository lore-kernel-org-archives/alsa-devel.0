From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000551]: Audigy ES
Date: Wed, 13 Oct 2004 08:47:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013064725.DBDBB1B00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4CEE92ED
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 08:47:26 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000551
======================================================================
Reported By:                Jakub Z
Assigned To:                perex
======================================================================
Project:                    ALSA - WWW server
Bug ID:                     551
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             09-29-2004 22:44 CEST
Last Modified:              10-13-2004 08:47 CEST
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
 Jakub Z - 09-29-2004 22:57 CEST 
----------------------------------------------------------------------
Well I have an issue with it that I didn't have with a SB Live!. When I do
a 'alsactl restore' while playing an mp3, I get:

alsactl: set_control:966: Cannot write control '2:0:0:EMU10K1 PCM Send
Routing:0' : Operation not permitted

I have to stop the playback and do a 'alsactl restore', then it works.

----------------------------------------------------------------------
 perex - 10-13-2004 08:47 CEST 
----------------------------------------------------------------------
Added to matrix.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-29-04 22:44 Jakub Z        New Bug                                      
09-29-04 22:57 Jakub Z        Bugnote Added: 0001976                       
09-29-04 22:59 Jakub Z        Bug Monitored: Jakub Z                       
10-13-04 08:47 perex          Bugnote Added: 0002113                       
10-13-04 08:47 perex          Assigned To               => perex           
10-13-04 08:47 perex          Resolution               open => fixed       
10-13-04 08:47 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
