From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000398]: aplay produces no sound on short wav files through dmix
Date: Mon, 28 Mar 2005 04:02:39 +0200
Message-ID: <65c9388690037255deb93481cb168a37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C01C5253
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 04:02:39 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=398> 
======================================================================
Reported By:                raveng
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   398
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             07-19-2004 16:21 CEST
Last Modified:              03-28-2005 04:02 CEST
======================================================================
Summary:                    aplay produces no sound on short wav files through
dmix
Description: 
Wav files shorter than about 0.157 seconds produce no sound under aplay and
dmix. No error message is given, and it looks like it should be working.
If I add silence to the file to make the duration longer, it plays fine.
Also, if I direct aplay to use the hardware directly, it plays the
original file just fine.  Tested on both ens1371 and i810 audio.

Other media players (xmms, mplayer, and artsplay) all play the same file
correctly with dmix. It is only the ALSA-provided aplay that seems to have
difficulty.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-21-05 09:20 
----------------------------------------------------------------------
My patch from six weeks ago ("start pcm when draining in prepared state")
might have fixed this.  Please try the CVS version.

----------------------------------------------------------------------
 jdthood - 03-28-05 04:02 
----------------------------------------------------------------------
Please try 1.0.9rc2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-04 16:21 raveng         New Issue                                    
07-28-04 02:08 lesieur        Note Added: 0001478                          
12-07-04 03:24 leahcim        Issue Monitored: leahcim                     
12-07-04 03:58 leahcim        Note Added: 0002745                          
03-20-05 15:49 jdthood        Note Added: 0004095                          
03-21-05 03:16 leahcim        Note Added: 0004111                          
03-21-05 09:20 Clemens LadischNote Added: 0004116                          
03-28-05 04:02 jdthood        Note Added: 0004229                          
03-28-05 04:02 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
