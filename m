From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000994]: 5.1 output broken since ~1.0.8 with VIA8237
Date: Wed, 16 Mar 2005 12:53:43 +0100
Message-ID: <92ffbd40dd6bfadf14e1a98cb54f72d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 73D3B1F6
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 12:53:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=994> 
======================================================================
Reported By:                mru
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   994
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-14-2005 23:42 CET
Last Modified:              03-16-2005 12:53 CET
======================================================================
Summary:                    5.1 output broken since
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1#1.0.8 with VIA8237
Description: 
The surround51 device on VIA8237 stopped working some time after alsa-lib
version 1.0.7.  Driver v1.0.8 works properly with older library versions.

With alsa-lib 1.0.8, there is this error: ALSA lib
pcm_hw.c:407:(snd_pcm_hw_channel_info) SNDRV_PCM_IOCTL_CHANNEL_INFO
failed: Inappropriate ioctl for device

With CVS of today (2005-03-14), about 100 ms of random sound is looped.

Using the surround40 device works, with some channels moved around.

>From the output of aplay -v, it appears that the surround51 device is
surround40, with some channel rerouting applied, all else being equal. 
Could there be a bug in the route plugin?

The same problem occurs with surround41 and surround50 as well.

======================================================================

----------------------------------------------------------------------
 mru - 03-15-05 16:10 
----------------------------------------------------------------------
I found the problem.  A -D_FILEOFFSET_BITS=64 had managed to sneak in,
resulting
in differing definitions of off_t, which is used in he argument to
SNDRV_PCM_IOCTL_CHANNEL_INFO, between the library and the driver.

Please close this bug.

----------------------------------------------------------------------
 tiwai - 03-16-05 12:53 
----------------------------------------------------------------------
OK, resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 23:42 mru            New Issue                                    
03-15-05 16:10 mru            Note Added: 0003915                          
03-16-05 12:53 tiwai          Status                   new => resolved     
03-16-05 12:53 tiwai          Resolution               open => not an issue
03-16-05 12:53 tiwai          Assigned To               => tiwai           
03-16-05 12:53 tiwai          Note Added: 0003949                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
