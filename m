From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001534]: Mixer channel problems
Date: Tue, 6 Dec 2005 09:40:01 +0100
Message-ID: <c7dcf1754f52594b69eaffd6bbb5bb8a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55C8718B
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 09:40:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1534> 
======================================================================
Reported By:                mrblur
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1534
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-08-2005 08:41 CET
Last Modified:              12-06-2005 09:40 CET
======================================================================
Summary:                    Mixer channel problems
Description: 
I'm using Acer AS5002WLMi with SiS 7012 soundcard. It works quite good,
but... unfortunately if I would like to change sound volume I have to do
it on headphones channel, master channel stereo/mona are not working.
======================================================================

----------------------------------------------------------------------
 mrblur - 11-29-05 09:22 
----------------------------------------------------------------------
Still nothing... Additionally when added this option there was no sound at
all... (?)

----------------------------------------------------------------------
 mrblur - 12-06-05 09:40 
----------------------------------------------------------------------
Ok.. sorry... ac97_quirk=2 and now it's working :-)
BIG THANKS :-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 08:41 mrblur         New Issue                                    
11-08-05 08:41 mrblur         Kernel Version            => 2.6.14          
11-08-05 17:48 tiwai          Note Added: 0006628                          
11-28-05 13:48 mrblur         Note Added: 0006859                          
11-28-05 18:51 tiwai          Note Added: 0006863                          
11-29-05 09:22 mrblur         Note Added: 0006871                          
12-06-05 09:40 mrblur         Note Added: 0006921                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
