From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000845]: Getting sound from the headphones but not from the internal speakers
Date: Tue, 31 May 2005 18:04:23 +0200
Message-ID: <16b036e6023431d8e65f978c4a65231f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22A4F1DA
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=845> 
======================================================================
Reported By:                zeffy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   845
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.741_FC3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-23-2005 21:36 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    Getting sound from the headphones but not from the
internal speakers
Description: 
Hey all,

I am experiencing a problem with my laptop running the Intel AC'97 codec.
I get a sound from the headphones but not from the built-in speakers.
I tried the volume settings and playing with alsamixer, aumix and others,
tried to  use the ac97_quirk options, but still no clues.
My laptop is HP Pavillion ZT3447EA running the lastest kernel and FC-3.


Any ideas?

Thanks.
======================================================================

----------------------------------------------------------------------
 zeffy - 01-25-05 20:53 
----------------------------------------------------------------------
I've managed to solve this issue.
I've changed the asound.state and UNMUTED the headphone jack sence.
You can close this problem. 

BTW: why isn't there a feature on this bug tracking system that allows you
to edit your own bug state?

Keep up the good work with ALSA.

Regards,
Zeffy.

----------------------------------------------------------------------
 tiwai - 01-31-05 19:07 
----------------------------------------------------------------------
OK, closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-05 21:36 zeffy          New Issue                                    
01-23-05 21:36 zeffy          Distribution              => Fedora Core 3   
01-23-05 21:36 zeffy          Kernel Version            => 2.6.10-1.741_FC3
01-25-05 15:23 tiwai          Note Added: 0003404                          
01-25-05 20:53 zeffy          Note Added: 0003410                          
01-31-05 19:07 tiwai          Status                   new => resolved     
01-31-05 19:07 tiwai          Resolution               open => fixed       
01-31-05 19:07 tiwai          Assigned To               => tiwai           
01-31-05 19:07 tiwai          Note Added: 0003456                          
01-31-05 19:07 tiwai          Assigned To              tiwai =>            
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
