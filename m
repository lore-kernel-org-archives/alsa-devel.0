From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000873]: Great delay when loading snd_ali5451 which does not occur with the trident OSS driver
Date: Sun, 6 Feb 2005 18:38:41 +0100
Message-ID: <043d45bc9cd6891f479a9b4b8a30eb94@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BC48423E
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2005 18:38:41 +0100 (MET)
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
Last Modified:              02-06-2005 18:38 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 01:57 tbm            New Issue                                    
02-01-05 01:57 tbm            File Added: ali                              
02-01-05 01:57 tbm            Distribution              => Debian GNU/Linux
02-01-05 01:57 tbm            Kernel Version            => 2.6.10, 2.6.9   
02-02-05 10:56 tiwai          Note Added: 0003480                          
02-06-05 18:38 tbm            Note Added: 0003527                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
