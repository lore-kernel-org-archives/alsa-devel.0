From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000873]: Great delay when loading snd_ali5451 which does not occur with the trident OSS driver
Date: Wed, 9 Feb 2005 11:40:41 +0100
Message-ID: <17eec293737f36080f7c178068a2c44d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C30A725F
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 11:40:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=873> 
======================================================================
Reported By:                tbm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   873
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10, 2.6.9
======================================================================
Date Submitted:             02-01-2005 01:57 CET
Last Modified:              02-09-2005 11:40 CET
======================================================================
Summary:                    Great delay when loading snd_ali5451 which does not
occur with the trident OSS driver
Description: 
When I load the snd_ali5451 module there is a delay of about 10 seconds
until the module is successfully loaded and the device recognized.  This
delay does not occur with the OSS trident driver (which loads immediately)
which shows that this is not a hardware problem.

I have put some get_seconds() statements in the driver to see where the
delay occurs.  It seems to be related to codec_read() and reg=7eh.  See
attachment.


======================================================================

----------------------------------------------------------------------
 tbm - 02-06-05 18:38 
----------------------------------------------------------------------
No, ac97_reset_wait() does not seem to be responsible for the delay.  It is
only called once and leaves the function pretty quickly.  I put in some
printk()s in ac97_reset_wait() but I only get:

mixer building ...
codec_write (1107711298): reg=0h data=0h.
entering ac97_reset_wait() (1107711298)
  in do() loop (1107711298)
codec_read (1107711298) reg=0h.
codec_read (1107711298) reg=7ch.
codec_read (1107711298) reg=7eh.
codec_write (1107711298): reg=1ch data=8a05h.
....

So it's in ac97_reset_wait() for only a short time.

----------------------------------------------------------------------
 tiwai - 02-09-05 11:40 
----------------------------------------------------------------------
Hmm, could you check which function takes too long time?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 01:57 tbm            New Issue                                    
02-01-05 01:57 tbm            File Added: ali                              
02-01-05 01:57 tbm            Distribution              => Debian GNU/Linux
02-01-05 01:57 tbm            Kernel Version            => 2.6.10, 2.6.9   
02-02-05 10:56 tiwai          Note Added: 0003480                          
02-06-05 18:38 tbm            Note Added: 0003527                          
02-09-05 11:40 tiwai          Note Added: 0003540                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
