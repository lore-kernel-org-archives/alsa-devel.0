From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001604]: alsa-utils compilation dies - undefined reference to `snd_mixer_selem_get_capture_dB'
Date: Wed, 7 Dec 2005 20:45:08 +0100
Message-ID: <3ee547f9eade4ba6c8e3886dd6ed8e85@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A4279159
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 20:45:08 +0100 (MET)
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
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.14-1.1637_FC4
======================================================================
Date Submitted:             11-27-2005 19:39 CET
Last Modified:              12-07-2005 20:45 CET
======================================================================
Summary:                    alsa-utils compilation dies - undefined reference to
`snd_mixer_selem_get_capture_dB'
Description: 
Compilation of alsamixer dies.  Full errors attached.  Note that the output
given here is using gcc32, but gcc4 gives the same errors.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-05 14:48 
----------------------------------------------------------------------
Did you really look at /lib whether _another_ libasound.so.* exists?  This
conflicts with the one you installed.

----------------------------------------------------------------------
 Twey - 12-07-05 20:45 
----------------------------------------------------------------------
One did exist, and I removed it, but the error persists.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
