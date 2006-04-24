From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002059]: Can't set external input switch for recording.
Date: Mon, 24 Apr 2006 21:00:34 +0200
Message-ID: <33346012685f8af28ed2276fdd2287e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A0EE18A
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 21:00:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2059> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2059
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-23-2006 00:56 CEST
Last Modified:              04-24-2006 21:00 CEST
======================================================================
Summary:                    Can't set external input switch for recording.
Description: 
I used the patch from bug #1890 and I got an Unknown switch to activate to
record from external line in instead of internal mic.
Now with new 1.0.11 drivers, that supports Vaio FE11x Sigmatel audio chip
I can't get it. No way to record from something different from internal
mic.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001890 Only the PCM channel in alsa mixer, unm...
======================================================================

----------------------------------------------------------------------
 tiwai - 04-24-06 16:40 
----------------------------------------------------------------------
Does the attached patch fix?
I still don't know which element corresponds what I/O.

   Line -> line/mic in jack ??
   Mic  -> built-in mic ??

----------------------------------------------------------------------
 fdoffizi01 - 04-24-06 21:00 
----------------------------------------------------------------------
Yes, it solves my problem. Good work, hope to see it soon in next release!
:)
As you know is there some particular difficulties in having the ability to
have a instant output switch (as to hear the mic just sent to output) as
it was with other drivers or it's only a work to do?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-06 00:56 fdoffizi01     New Issue                                    
04-23-06 01:03 rlrevell       Relationship added       related to 0001890  
04-24-06 16:40 tiwai          Note Added: 0009467                          
04-24-06 16:40 tiwai          File Added: stac7661-vaio-line-in-fix.diff        
           
04-24-06 21:00 fdoffizi01     Note Added: 0009477                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
