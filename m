From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000345]: Echo with SB Audigy and microphone input
Date: Mon, 20 Dec 2004 14:43:33 +0100
Message-ID: <22ae5b51d43207a1ae27084f53be773c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 149802E7
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 14:43:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=345> 
======================================================================
Reported By:                quinn
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   345
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-26-2004 11:57 CEST
Last Modified:              12-20-2004 14:43 CET
======================================================================
Summary:                    Echo with SB Audigy and microphone input
Description: 
When in "loopback" recording mode, where the recorded audio from the
microphone is played back (Easiest example would be the Recorder plugin
for XMMS), even when every other capture channel is at zero volume and the
sound is output through headphones, microphone input still echos
======================================================================

----------------------------------------------------------------------
 pzad - 09-07-04 09:28 
----------------------------------------------------------------------
I tested again this. I think, your echo comes from headphones.
Try to only record from mic (set same volume for mic as you used for
loopback mode). Then try to play some music through headphone at some good
volume level (same as you used for mic loopback). Then check what you
recorded - if you hear music, then this comes from your headphone.

----------------------------------------------------------------------
 pzad - 11-18-04 17:48 
----------------------------------------------------------------------
Not response for long time. I still think, that this echo comes from
headphones.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 11:57 quinn          New Issue                                    
07-12-04 13:37 pzad           Note Added: 0001410                          
08-06-04 15:03 pzad           Note Added: 0001541                          
08-06-04 15:03 pzad           Status                   assigned => feedback
08-06-04 15:15 quinn          Note Added: 0001542                          
08-30-04 12:14 pzad           Note Added: 0001668                          
08-31-04 23:25 quinn          Note Added: 0001675                          
09-07-04 09:28 pzad           Note Added: 0001702                          
11-18-04 17:48 pzad           Status                   feedback => resolved
11-18-04 17:48 pzad           Resolution               open => not an issue
11-18-04 17:48 pzad           Note Added: 0002451                          
12-20-04 14:43 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
