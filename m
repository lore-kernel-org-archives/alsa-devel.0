From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002116]: no sound in kernel 2.6.16-1-686
Date: Fri, 12 May 2006 22:43:41 +0200
Message-ID: <e01865457202f56dac64caef39623610@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8783176
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 22:43:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2116> 
======================================================================
Reported By:                mramirez
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2116
Category:                   speakertest
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-12-2006 01:07 CEST
Last Modified:              05-12-2006 22:43 CEST
======================================================================
Summary:                    no sound in kernel 2.6.16-1-686
Description: 
I have updated my kernel from 2.6.15-1-486 to 2.6.16-1-686, and now the
sound not work. 

I run alsaconf, but not solve the problem. 

if i boot on kernel 2.6.15-1-486 the sound work. (only in this version)

somebody help me?



======================================================================

----------------------------------------------------------------------
 mramirez - 05-12-06 21:35 
----------------------------------------------------------------------
-i execute alsamixer and set the master volume to 100%,
-i try to play music in mplayer and totem, and both the sound not work.
-i try to play a avi file in totem, but the sound not word.
-i don't have sound on both, phones and laptopspeaker.

my alsmamixer driver version is v1.0.11



----------------------------------------------------------------------
 rlrevell - 05-12-06 22:43 
----------------------------------------------------------------------
Try raising the PCM and Front volume and make sure all controls are
unmuted.

Don't use kmix, it's terribly buggy.  Test with alsamixer.

If it still does not work post the output of "amixer"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-06 01:07 mramirez       New Issue                                    
05-12-06 16:07 tiwai          Note Added: 0009777                          
05-12-06 18:34 mramirez       Note Added: 0009785                          
05-12-06 18:37 tiwai          Note Added: 0009787                          
05-12-06 20:30 mramirez       Note Added: 0009790                          
05-12-06 20:34 tiwai          Note Added: 0009791                          
05-12-06 21:29 mramirez       Note Added: 0009792                          
05-12-06 21:35 mramirez       Note Edited: 0009792                         
05-12-06 22:43 rlrevell       Note Added: 0009793                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
