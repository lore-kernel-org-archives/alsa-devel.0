From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001763]: How to provide patch for the soundcard matrix ?
Date: Fri, 27 Jan 2006 13:34:44 +0100
Message-ID: <dc3ac8f7ccad03c90891d27a910ecb52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18F921AD
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 13:34:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1763> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1763
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-20-2006 09:10 CET
Last Modified:              01-27-2006 13:34 CET
======================================================================
Summary:                    How to provide patch for the soundcard matrix ?
Description: 
How to provide patch for the soundcard matrix ?

http://www.alsa-project.org/alsa-doc/index.php?vendor=All#matrix

(e.g. Is there any description of the xml file submitted in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=938 ? )

1) Is mpu401 uart regarded as [MIDIio] ?

2) Is coaxial SPDIF in/out regarded as [RCAio] ?

3) Is optical SPDIF out classified as [TOSo] ?

4) Add "modem not support" to Note


======================================================================

----------------------------------------------------------------------
 Raymond - 01-27-06 13:26 
----------------------------------------------------------------------
patch to update of Aureal sound cards in ALSA sound card matrix

The whole list can be found in

http://portal.suse.de/sdb/en/2000/05/randall_aureal.html

----------------------------------------------------------------------
 lmike - 01-27-06 13:34 
----------------------------------------------------------------------
About the list http://portal.suse.de/sdb/en/2000/05/randall_aureal.html -
it doesn't contain Genius Soundmaker 64 - it was based on 8820 chip.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-06 09:10 Raymond        New Issue                                    
01-22-06 17:34 pochini        Note Added: 0007749                          
01-23-06 05:19 Raymond        Note Added: 0007759                          
01-23-06 09:44 Raymond        Note Added: 0007760                          
01-24-06 08:58 Raymond        File Added: soundcardmatrix_au88x0.patch          
         
01-27-06 13:26 Raymond        Note Added: 0007799                          
01-27-06 13:34 lmike          Note Added: 0007800                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
