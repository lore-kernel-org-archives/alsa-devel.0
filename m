From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000527]: snd_pcm_set_rate_near used always
Date: Fri, 8 Jul 2005 10:38:29 +0200
Message-ID: <f75e0dd769d891e52c9e5fc42340ddb8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29238C1
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:38:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=527> 
======================================================================
Reported By:                AKennedy
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   527
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-23-2004 21:43 CEST
Last Modified:              07-08-2005 10:38 CEST
======================================================================
Summary:                    snd_pcm_set_rate_near used always
Description: 
When selecting to record using a speific device, say hw1,0, this craps out.
. . using plughw1,0 or default works, however.  Should this have an if
statement to control if the device selected is hw/can you _near if the
device is NOT default or plughw?
======================================================================

----------------------------------------------------------------------
 jdthood - 03-20-05 15:47 
----------------------------------------------------------------------
> When selecting to record using a speific device, say hw1,0, this
> craps out. . . using plughw1,0 or default works, however. Should
> this have an if statement to control if the device selected is
> hw/can you _near if the device is NOT default or plughw?

Can you please try to explain more clearly what you mean?

----------------------------------------------------------------------
 tiwai - 03-23-05 12:51 
----------------------------------------------------------------------
You'll see a warning message if the given rate can't be used (at least with
the latest version).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 21:43 AKennedy       New Issue                                    
09-29-04 05:37 AKennedy       Issue Monitored: AKennedy                    
09-29-04 05:37 AKennedy       Issue End Monitor: AKennedy                    
03-20-05 15:47 jdthood        Note Added: 0004094                          
03-23-05 12:51 tiwai          Note Added: 0004154                          
03-31-05 20:22 jdthood        Status                   new => resolved     
03-31-05 20:22 jdthood        Resolution               open => fixed       
07-08-05 10:38 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
