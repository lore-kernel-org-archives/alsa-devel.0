From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001404]: (Apparently) no microphone support
Date: Mon, 2 Jan 2006 20:45:25 +0100
Message-ID: <02d714f45f4e202ffcc6776d8172af25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25F5413E
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:45:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1404> 
======================================================================
Reported By:                Twey
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1404
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.13-homegrown
======================================================================
Date Submitted:             09-08-2005 18:40 CEST
Last Modified:              01-02-2006 20:45 CET
======================================================================
Summary:                    (Apparently) no microphone support
Description: 
My SB Live! 24-Bit has no microphone-related channels.  Using any mixer
(tried: alsamixer, kmix, gnome-volume-control), it seems not to support
microphones.
Audacity shows very small (pixel-size) distortions in the recording graph
at times.  I presume this means that the input is being received, but is
too miniscule to make a difference.  I can't do anything about this; there
are no appropriate sliders or "mic boost" in any mixer application.
======================================================================

----------------------------------------------------------------------
 Twey - 12-08-05 10:59 
----------------------------------------------------------------------
With the stable .10 release, the original issue persists.



----------------------------------------------------------------------
 rlrevell - 01-02-06 20:45 
----------------------------------------------------------------------
Any improvement with the 1.0.11-rc2 release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-05 18:40 Twey           New Issue                                    
09-08-05 18:40 Twey           Distribution              => Fedora Core 4   
09-08-05 18:40 Twey           Kernel Version            => 2.6.13-homegrown
09-08-05 18:43 Twey           Issue Monitored: Twey                        
09-08-05 18:46 rlrevell       Note Added: 0006074                          
09-08-05 18:55 Twey           Note Added: 0006075                          
09-08-05 19:11 Twey           Note Added: 0006079                          
09-10-05 10:41 jcdutton       Note Added: 0006110                          
09-10-05 10:41 jcdutton       Status                   assigned => feedback
09-10-05 10:46 Twey           Note Added: 0006112                          
12-07-05 20:58 Twey           Note Added: 0006947                          
12-08-05 10:59 Twey           Note Edited: 0006947                         
01-02-06 20:45 rlrevell       Note Added: 0007389                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
