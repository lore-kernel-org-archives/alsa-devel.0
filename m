From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000332]: Unable to enable 'Mic as Center/LFE'
Date: Mon, 2 Jan 2006 20:31:14 +0100
Message-ID: <42a5caf91138c2f25ac092191eda8195@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B98C9BB
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:31:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=332> 
======================================================================
Reported By:                Johan Gorter
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   332
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-11-2004 09:12 CEST
Last Modified:              01-02-2006 20:31 CET
======================================================================
Summary:                    Unable to enable 'Mic as Center/LFE'
Description: 
In the alsa versions I have used thus far (1.0.3 and 1.0.5) I am unable to
enable the 'Mic as Center/LFE' option of my onboard AC '97. Alsamixer
cannot change its value from 0 and record / mute is also disabled. I
tracked the problem by using alsactl to store the settings. This results
in a file where this option (nr 47 on my system) is an Integer with the
comment that the value may be from 0 to 0. On other systems I found out
that this is supposed to be a Boolean which can be switched on and off.
======================================================================

----------------------------------------------------------------------
 jdthood - 06-08-05 20:40 
----------------------------------------------------------------------
I asked the submitter of Debian bug report #307087 to test alsa-utils
version 1.0.9a.  He says:

The bug seems to be half fixed: in [All] mode of alsamixer it is still
[not] present (no control to select Mic for recording), while in [Capture]
mode the control is present.  Also the recording volume is very low, even
at 100%, but this might be because of the sound card (though I don't now
how to check that).

----------------------------------------------------------------------
 jdthood - 06-30-05 13:52 
----------------------------------------------------------------------
I am waiting for the submitter of the Debian bug report to confirm that the
control really does not appear in the "capture" view.  I find that a bit
hard to believe.

If there are no further additions to this report in a couple of weeks then
please feel free to close it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-04 09:12 Johan Gorter   New Issue                                    
01-22-05 03:26 rhal           Issue Monitored: rhal                        
03-20-05 15:45 jdthood        Note Added: 0004093                          
03-31-05 20:23 jdthood        Note Added: 0004284                          
05-02-05 11:10 jdthood        Note Added: 0004584                          
06-08-05 20:40 jdthood        Note Added: 0004972                          
06-30-05 13:52 jdthood        Note Added: 0005325                          
06-30-05 13:52 jdthood        Status                   new => feedback     
01-02-06 20:31 rlrevell       Status                   feedback => closed  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
