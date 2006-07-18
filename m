From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002116]: no sound in kernel 2.6.16-1-686
Date: Tue, 18 Jul 2006 14:30:18 +0200
Message-ID: <2862d1afba5706a87fba16b6bd3b8c75@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C60B4ED
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:30:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2116> 
======================================================================
Reported By:                mramirez
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - utils
Issue ID:                   2116
Category:                   speakertest
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             05-12-2006 01:07 CEST
Last Modified:              07-18-2006 14:30 CEST
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
 tiwai - 05-12-06 16:07 
----------------------------------------------------------------------
Try 2.6.17rc4.

----------------------------------------------------------------------
 mramirez - 05-12-06 18:34 
----------------------------------------------------------------------
i try this but the sound don't work

----------------------------------------------------------------------
 tiwai - 05-12-06 18:37 
----------------------------------------------------------------------
Then how about to begin with more detailed descriptions of your hardware
and problems?

----------------------------------------------------------------------
 mramirez - 05-12-06 20:30 
----------------------------------------------------------------------
Laptop model:DELL INSPIRON 6400
Procesor: Intel dual core t2200
Chipset: Intel&#174;  945GM
Sound card: HDA Intel, SigmatelStac9200 <- this information is from
alsamixer

i updated my kernel with #apt-get install linux-headers-2.6.16-1-686 and
restart my computer in this kernel version,  and the sound not work.

but, if i boot on 2.6.15 version, the sound work.

that another information you need?

----------------------------------------------------------------------
 tiwai - 05-12-06 20:34 
----------------------------------------------------------------------
"sound not work" is too ambiguous.  Please elaborate what you tested.

The fix for STAC92xx codecs are not included in 2.6.16.x kernels but only
2.6.17rc kernel.  I've heard reports that Dell laptop works with 2.6.17
kernels.

Or, try ALSA 1.0.11 driver.  This should work as well as 2.6.17rc kernel,
too.

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

----------------------------------------------------------------------
 rlrevell - 05-16-06 23:48 
----------------------------------------------------------------------
Were you able to get this working?

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
05-16-06 23:48 rlrevell       Note Added: 0009842                          
07-18-06 14:30 jcdutton       Status                   new => assigned     
07-18-06 14:30 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
