From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001763]: How to provide patch for the soundcard matrix ?
Date: Sun, 22 Jan 2006 17:34:55 +0100
Message-ID: <24a79c46a317044ae4aa589cef88acbe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A096415E
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 17:34:55 +0100 (MET)
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
Last Modified:              01-22-2006 17:34 CET
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
 pochini - 01-22-06 17:34 
----------------------------------------------------------------------
Docs is here: http://www.alsa-project.org/alsa-doc/cards/README

The source file of soundcard entry is in /cards directory. For example the
source of:

http://alsa-project.org/alsa-doc/index.php?vendor=vendor-Echo_Corporation

is

http://alsa-project.org/alsa-doc/cards/vendor-Echo_Corporation

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-06 09:10 Raymond        New Issue                                    
01-22-06 17:34 pochini        Note Added: 0007749                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
