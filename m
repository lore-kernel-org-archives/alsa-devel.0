From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001604]: alsa-utils compilation dies - undefined reference to `snd_mixer_selem_get_capture_dB'
Date: Thu, 8 Dec 2005 10:56:29 +0100
Message-ID: <56879bbe78497f07e80e02e4ac1b4c64@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5BA514F
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 10:56:29 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1604> 
======================================================================
Reported By:                Twey
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1604
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.14-1.1637_FC4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-27-2005 19:39 CET
Last Modified:              12-08-2005 10:56 CET
======================================================================
Summary:                    alsa-utils compilation dies - undefined reference to
`snd_mixer_selem_get_capture_dB'
Description: 
Compilation of alsamixer dies.  Full errors attached.  Note that the output
given here is using gcc32, but gcc4 gives the same errors.
======================================================================

----------------------------------------------------------------------
 Twey - 12-08-05 10:54 
----------------------------------------------------------------------
Apologies - I missed an RPM.  Solved.

----------------------------------------------------------------------
 perex - 12-08-05 10:56 
----------------------------------------------------------------------
not an ALSA bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-05 19:39 Twey           New Issue                                    
11-27-05 19:39 Twey           Distribution              => Fedora Core 4   
11-27-05 19:39 Twey           Kernel Version            => 2.6.14-1.1637_FC4
11-28-05 18:56 tiwai          Note Added: 0006866                          
11-28-05 19:11 Twey           Note Added: 0006867                          
11-28-05 19:13 tiwai          Note Added: 0006868                          
11-28-05 19:39 Twey           Note Added: 0006869                          
12-02-05 14:48 tiwai          Note Added: 0006893                          
12-07-05 20:45 Twey           Note Added: 0006946                          
12-07-05 20:45 Twey           Issue Monitored: Twey                        
12-08-05 10:54 Twey           Note Added: 0006955                          
12-08-05 10:55 Twey           Issue End Monitor: Twey                      
12-08-05 10:56 perex          Status                   assigned => resolved
12-08-05 10:56 perex          Resolution               open => fixed       
12-08-05 10:56 perex          Note Added: 0006956                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
