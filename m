From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000627]: alsactl store doesn't work
Date: Thu, 16 Dec 2004 18:14:08 +0100
Message-ID: <fe5f1dadf842a89869b773031d4ed869@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9D3C5245
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:14:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=627> 
======================================================================
Reported By:                deglog
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   627
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             11-03-2004 17:05 CET
Last Modified:              12-16-2004 18:14 CET
======================================================================
Summary:                    alsactl store doesn't work
Description: 
"alsactl store" outputs "Terminated" after about 30 seconds.

The file asound.state is full of garbage.

Apart from that sounds work OK, although I do see

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

in .xsession_errors.
======================================================================

----------------------------------------------------------------------
 deglog - 11-09-04 21:47 
----------------------------------------------------------------------
Yes that fixed it. Thanks.

----------------------------------------------------------------------
 tiwai - 11-10-04 12:09 
----------------------------------------------------------------------
The broken pipe message is from artsd.  It's a known bug of arts.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 17:05 deglog         New Issue                                    
11-09-04 15:49 tiwai          Note Added: 0002324                          
11-09-04 21:47 deglog         Note Added: 0002353                          
11-10-04 12:09 tiwai          Status                   new => resolved     
11-10-04 12:09 tiwai          Resolution               open => won't fix   
11-10-04 12:09 tiwai          Assigned To               => tiwai           
11-10-04 12:09 tiwai          Note Added: 0002364                          
12-16-04 18:14 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
