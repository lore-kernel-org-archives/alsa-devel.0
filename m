From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000527]: snd_pcm_set_rate_near used always
Date: Sun, 20 Mar 2005 15:47:06 +0100
Message-ID: <7769b3f40fb7113918bc9aa82c6e348d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B242B19A
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 15:47:06 +0100 (MET)
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
Status:                     new
======================================================================
Date Submitted:             09-23-2004 21:43 CEST
Last Modified:              03-20-2005 15:47 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 21:43 AKennedy       New Issue                                    
09-29-04 05:37 AKennedy       Issue Monitored: AKennedy                    
09-29-04 05:37 AKennedy       Issue End Monitor: AKennedy                    
03-20-05 15:47 jdthood        Note Added: 0004094                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
