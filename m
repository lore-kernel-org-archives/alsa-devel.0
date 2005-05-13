From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001101]: [VIA 8237 with ALC850] gstreamer alsasink with default device does not work but with "device=hw:0" it does
Date: Fri, 13 May 2005 15:38:12 +0200
Message-ID: <6c4af0a433e4db1d8d7db0595b0eb0d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5D6CE2CA
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 15:38:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1101> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1101
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-11-2005 22:15 CEST
Last Modified:              05-13-2005 15:38 CEST
======================================================================
Summary:                    [VIA 8237 with ALC850] gstreamer alsasink with
default device does not work but with "device=hw:0" it does
Description: 
The submitter of https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305189
and an interlocutor have discovered that
gstreaming to "alsasink" does not work but the same to "alsasink
device=hw:0" does work.

Please see http://bugs.debian.org/305189 for the discussion which includes
lots more detail.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-13-05 14:17 
----------------------------------------------------------------------
Does it happen witn ALSA 1.0.9rc3, too?

----------------------------------------------------------------------
 jdthood - 05-13-05 15:38 
----------------------------------------------------------------------
>  Does it happen witn ALSA 1.0.9rc3, too?

The submitter tested with libasound2 1.0.9rc3 but this did not help.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 22:15 jdthood        New Issue                                    
05-13-05 14:17 tiwai          Note Added: 0004645                          
05-13-05 15:38 jdthood        Note Added: 0004650                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
