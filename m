From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001008]: only one application can play at once
Date: Sat, 28 May 2005 12:24:55 +0200
Message-ID: <bc8b8a156747dd4498563664095498c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D075D214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:24:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1008> 
======================================================================
Reported By:                msillence
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1008
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.11.5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-22-2005 22:15 CET
Last Modified:              05-28-2005 12:24 CEST
======================================================================
Summary:                    only one application can play at once
Description: 
when two applications try and play or write to the dsp at the same time the
second  gets a device in use message.
======================================================================

----------------------------------------------------------------------
 msillence - 04-03-05 19:36 
----------------------------------------------------------------------
Curious the via driver supports multiple programs accessing the sound card
at once without dmix.
I'm afraid that due to the lack of recording support I intend to sell/give
away the card and try another. (I filed this bug at the same time as the
recording problem)
Thanks for the suggestion though.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:24 
----------------------------------------------------------------------
The ca0106 driver now supports capture.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 22:15 msillence      New Issue                                    
03-22-05 22:15 msillence      Kernel Version            => 2.6.11.5        
04-03-05 13:32 jcdutton       Note Added: 0004308                          
04-03-05 13:32 jcdutton       Status                   assigned => feedback
04-03-05 19:36 msillence      Note Added: 0004313                          
05-28-05 12:24 jcdutton       Status                   feedback => closed  
05-28-05 12:24 jcdutton       Note Added: 0004767                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
