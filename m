From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000892]: (snd_pcm_route_load_ttable) Invalid type for X - when using REAL numbers
Date: Tue, 8 Feb 2005 15:09:52 +0100
Message-ID: <f9a862f414d4179ca800a998b4a0afeb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6C242249
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2005 15:09:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=892> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   892
Category:                   general
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-08-2005 15:06 CET
Last Modified:              02-08-2005 15:09 CET
======================================================================
Summary:                    (snd_pcm_route_load_ttable) Invalid type for X -
when using REAL numbers
Description: 
According to the route plugin description at
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html 

ttable {                schannels numbers)
                CCHANNEL {
                        SCHANNEL REAL   # route value (0.0 - 1.0)
                }

the ttable values can be REAL.
Although when defining such a simple pcm as:

pcm.ch51dup {
    type route
    ttable {
        0 {
            0 1
            4 1
            2 0.5
            3 0.5
        }
        1 {
            1 1
            5 1
            2 0.5
            3 0.5
        }
    }
    slave.pcm {
        type hw
        card 0
        device 0
    }
    slave.channels 6
}

and trying to use the pcm, I get an error:
(snd_pcm_route_load_ttable) Invalid type for 2.
(snd_pcm_route_load_ttable) Invalid type for 3.

This i tried to define the table values in different manners e.g.
ttable.0.3 0.5  (even used the exact sample from
http://alsa.opensrc.org/index.php?page=FAQ028) but the result is the
same.

======================================================================

----------------------------------------------------------------------
 slammer - 02-08-05 15:09 
----------------------------------------------------------------------
Off course when I'm using INT number the pcm works fine!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 15:06 slammer        New Issue                                    
02-08-05 15:06 slammer        Issue Monitored: slammer                     
02-08-05 15:09 slammer        Note Added: 0003533                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
