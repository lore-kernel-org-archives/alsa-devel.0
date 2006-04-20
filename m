From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Thu, 20 Apr 2006 15:29:01 +0200
Message-ID: <5a51f74413cbbce399ed9aa590f9d9e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C904176
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 15:29:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-20-2006 15:29 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

----------------------------------------------------------------------
 Raymond - 04-11-06 09:41 
----------------------------------------------------------------------
cat test.raw > /dev/dsp

vortex: pcm_hwparams Playback channels = 1 format =1 rate = 8000


cat test.raw > /dev/audio

vortex: pcm_hwparams Playback channels = 1 format =20 rate = 8000

It seem that by default

/dev/dsp support U8
/dev/audio support mu-law

if the hardware of sound card support



----------------------------------------------------------------------
 tiwai - 04-20-06 15:29 
----------------------------------------------------------------------
Yes, _usually_ they are so, but the default status is not strictly
defined.

I see no real bugs, so let's close this one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
04-03-06 07:16 Raymond        Note Added: 0009085                          
04-03-06 07:36 Raymond        Note Added: 0009086                          
04-07-06 19:32 tiwai          Note Added: 0009152                          
04-08-06 07:47 Raymond        Note Added: 0009171                          
04-10-06 16:52 tiwai          Note Added: 0009199                          
04-11-06 07:46 Raymond        Note Added: 0009229                          
04-11-06 07:55 Raymond        Note Edited: 0009229                         
04-11-06 09:41 Raymond        Note Edited: 0009229                         
04-20-06 15:29 tiwai          Status                   new => resolved     
04-20-06 15:29 tiwai          Resolution               open => not an issue
04-20-06 15:29 tiwai          Assigned To               => tiwai           
04-20-06 15:29 tiwai          Note Added: 0009384                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
