From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000584]: LADSPA plugins which require multiple channels are not connected to properly -> SEGV
Date: Sun, 20 Mar 2005 13:02:38 +0100
Message-ID: <b0efa0f67cd4e1c24683116439340fad@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 43C9623B
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:02:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=584> 
======================================================================
Reported By:                divVerent
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   584
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-15-2004 22:58 CEST
Last Modified:              03-20-2005 13:02 CET
======================================================================
Summary:                    LADSPA plugins which require multiple channels are
not connected to properly -> SEGV
Description: 
Instead of connecting all channels to the LADSPA plugin and invoking it
once, libasound connects them one-by-one and invokes the LADSPA plugin
multiple times. In other words, libasound only handles mono plugins and
"stretches" them into stereo plugins by processing the audio data channel
by channel.

This will however make real stereo/multichannel plugins crash because they
do what "ladspa.h" says:

/* quoting ladspa.h
The plugin may assume that all its input and output ports have been
connected to the relevant data location (see the `connect_port()' function
below) before it is asked to run.
*/
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 13:02 
----------------------------------------------------------------------
Submitter: How do you think that this should be fixed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 22:58 divVerent      New Issue                                    
10-15-04 23:21 divVerent      Issue Monitored: divVerent                    
03-20-05 13:02 jdthood        Note Added: 0004076                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
