From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001007]: no audio in - unable to record
Date: Wed, 23 Mar 2005 10:09:56 +0100
Message-ID: <37b92b8656107e0380c95e540bd840d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B0B1C201
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 10:09:57 +0100 (MET)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1007> 
======================================================================
Reported By:                msillence
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1007
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-22-2005 21:44 CET
Last Modified:              03-23-2005 10:09 CET
======================================================================
Summary:                    no audio in - unable to record
Description: 
I can only get a weak hiss from the card even with the recording level up
full
======================================================================

----------------------------------------------------------------------
 jcdutton - 03-23-05 00:45 
----------------------------------------------------------------------
The driver does not support sound capture and won't any time soon due to
lack of documentation.

----------------------------------------------------------------------
 msillence - 03-23-05 10:09 
----------------------------------------------------------------------
Hi,

Fair enough no fixes without docs, could you change the support status
though as I bought this card as it was shown as supported. Could save a
few other people the same pain.
Also for future reference I suspect that the problem lies with being able
to switch the input as the same connector is used for digital in and
analogue in...

-- 
Thanks,
M

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 21:44 msillence      New Issue                                    
03-22-05 21:44 msillence      Kernel Version            => 2.6.11.5        
03-23-05 00:45 jcdutton       Status                   assigned => closed  
03-23-05 00:45 jcdutton       Note Added: 0004146                          
03-23-05 10:09 msillence      Status                   closed => feedback  
03-23-05 10:09 msillence      Resolution               open => reopened    
03-23-05 10:09 msillence      Note Added: 0004153                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
