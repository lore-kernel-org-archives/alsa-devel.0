From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000873]: Great delay when loading snd_ali5451 which does not occur with the trident OSS driver
Date: Wed, 13 Apr 2005 21:57:45 +0200
Message-ID: <d39d2c07d6c386959d367e3aaaed7326@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF69623B
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 21:57:45 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
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
Status:                     acknowledged
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.10, 2.6.9
======================================================================
Date Submitted:             02-01-2005 01:57 CET
Last Modified:              04-13-2005 21:57 CEST
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
 tiwai - 02-02-05 10:56 
----------------------------------------------------------------------
ALSA checks REG_GAIN control at the probe of codec (ac97_reset_wait in
ac97_codec.c).  Maybe this register can't get read well on your chip?
But this still doesn't explain the whole 10sec delay...

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

----------------------------------------------------------------------
 tbm - 02-09-05 14:03 
----------------------------------------------------------------------
It seems the codec is not ready when reading register 7eh.

What happens is that codec_read() calls snd_ali_codec_peek(); this obtains
the
port, checks whether the codec and the stimer is ready, then it calls
snd_ali_5451_poke() and then it checks if the stimer and codec is ready. 
Here, the snd_ali_codec_ready() function calls snd_ali_5451_peek() several
ten-thousand times, and takes about 2 seconds.  7eh is read 4 times, i.e.
> 8 secods plus a bit gives 10 secods...


codec_read (1107951511) reg=7eh.
entering snd_ali_codec_peek(), (1107951511)
  obtaining port, (1107951511)
  ... done, (1107951511)
  calling snd_ali_codec_ready(), (1107951511)
    entering snd_ali_5451_peek(), (1107951511)
  ... done, (1107951511)
  calling snd_ali_stimer_ready(), (1107951511)
    entering snd_ali_5451_peek(), (1107951511)
last message repeated 2 times
  ... done, (1107951511)
  calling snd_ali_5451_poke(), (1107951511)
    entering snd_ali_5451_poke(), (1107951511)
    ... exiting, (1107951511)
  ... done, (1107951511)
  calling snd_ali_stimer_ready(), (1107951511)
    entering snd_ali_5451_peek(), (1107951511)
last message repeated 2 times
  calling snd_ali_codec_ready(), (1107951511)
    entering snd_ali_5451_peek(), (1107951511)
last message repeated 2029 times
    entering snd_ali_5451_peek(), (1107951512)
last message repeated 31382 times
    entering snd_ali_5451_peek(), (1107951513)
last message repeated 36084 times
    entering snd_ali_5451_peek(), (1107951514)
last message repeated 13506 times
    entering snd_ali_5451_poke(), (1107951514)
    ... exiting, (1107951514)
codec_write (1107951514): reg=74h data=4001h.

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
02-09-05 14:03 tbm            Note Added: 0003553                          
04-13-05 21:57 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
