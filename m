From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000907]: The sound is choppy and sometimes played at wrong speed
Date: Mon, 28 Mar 2005 14:09:44 +0200
Message-ID: <1b91c0c8cb8db6003143d524b531b622@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B5618265
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 14:09:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=907> 
======================================================================
Reported By:                sHINOBI
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   907
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.766_FC3
======================================================================
Date Submitted:             02-13-2005 11:36 CET
Last Modified:              03-28-2005 14:09 CEST
======================================================================
Summary:                    The sound is choppy and sometimes played at wrong
speed
Description: 
The soundcard is working, although the sound is choppy when playing sound
at 44100 Hz. 48000 Hz audio like the one at DVD's is played correctly.
======================================================================

----------------------------------------------------------------------
 Cimmo - 03-27-05 16:08 
----------------------------------------------------------------------
I've the same board from MSI: with xmms all is ok selecting default device,
but I tried to hear sound also from the rear reading this
http://alsa.opensrc.org/index.php?page=FAQ028 
and selecting pcm.ch40dup in xmms device alsa configuration the sound
become choppy and faster, is there a solution?

See my .asoundrc in attachment.

Thanx for your support!

----------------------------------------------------------------------
 Alinoe - 03-28-05 14:09 
----------------------------------------------------------------------
xmms doesn't work for me too (choppy and fast ;))
only alsaplayer can play correctly a sound ;o)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-05 11:36 sHINOBI        New Issue                                    
02-13-05 11:36 sHINOBI        Distribution              => Fedora Core 3   
02-13-05 11:36 sHINOBI        Kernel Version            => 2.6.10-1.766_FC3
02-13-05 11:38 sHINOBI        Note Added: 0003583                          
03-02-05 13:22 Juha           Note Added: 0003770                          
03-19-05 18:24 jcdutton       Note Added: 0004064                          
03-22-05 22:14 tiwai          Note Added: 0004138                          
03-22-05 22:56 sHINOBI        Note Added: 0004144                          
03-23-05 12:56 tiwai          Note Added: 0004155                          
03-23-05 19:40 sHINOBI        Note Added: 0004185                          
03-27-05 01:13 sHINOBI        Note Added: 0004219                          
03-27-05 16:08 Cimmo          Note Added: 0004222                          
03-27-05 16:09 Cimmo          File Added: .asoundrc                        
03-28-05 01:31 Alinoe         Issue Monitored: Alinoe                      
03-28-05 14:09 Alinoe         Note Added: 0004240                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
