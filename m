From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000345]: Echo with SB Audigy and microphone input
Date: Tue,  7 Sep 2004 09:29:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907072900.25DB8D00D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 70599265
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 09:29:00 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000345
======================================================================
Reported By:                quinn
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     345
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-26-2004 11:57 CEST
Last Modified:              09-07-2004 09:28 CEST
======================================================================
Summary:                    Echo with SB Audigy and microphone input
Description: 
When in "loopback" recording mode, where the recorded audio from the
microphone is played back (Easiest example would be the Recorder plugin
for XMMS), even when every other capture channel is at zero volume and the
sound is output through headphones, microphone input still echos
======================================================================

----------------------------------------------------------------------
 pzad - 07-12-2004 13:37 CEST 
----------------------------------------------------------------------
I tested this. You get echo, but this is ok.
You probably have "Mic volume" not set to 0 and echo comes from record
loopback (this is where delay comes from). When you set "Mic volume" to 0
you will hear delayed mic signal, but without echo.

----------------------------------------------------------------------
 pzad - 08-06-2004 15:03 CEST 
----------------------------------------------------------------------
Helped this ???

----------------------------------------------------------------------
 quinn - 08-06-2004 15:15 CEST 
----------------------------------------------------------------------
I'm sorry, I missed the first reply.

No, that didn't help. I have microphone output completely muted as well.
(And am using headphones, so no analog feedback is present.)

----------------------------------------------------------------------
 pzad - 08-30-2004 12:14 CEST 
----------------------------------------------------------------------
I missed your reply :-)

I will try this again.

Test if you have Mic Volume to 0.

If echo is still there, try to set AnalogMix volume to 0. 
Helped this ???

----------------------------------------------------------------------
 quinn - 08-31-2004 23:25 CEST 
----------------------------------------------------------------------
Yes, I am completely and utterly sure that microphone output is set to
zero. Zeroing out either Analog Mix playback or recording does not help
either.

----------------------------------------------------------------------
 pzad - 09-07-2004 09:28 CEST 
----------------------------------------------------------------------
I tested again this. I think, your echo comes from headphones.
Try to only record from mic (set same volume for mic as you used for
loopback mode). Then try to play some music through headphone at some good
volume level (same as you used for mic loopback). Then check what you
recorded - if you hear music, then this comes from your headphone.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 11:57 quinn          New Bug                                      
07-12-04 13:37 pzad           Bugnote Added: 0001410                       
08-06-04 15:03 pzad           Bugnote Added: 0001541                       
08-06-04 15:03 pzad           Status                   assigned => feedback
08-06-04 15:15 quinn          Bugnote Added: 0001542                       
08-30-04 12:14 pzad           Bugnote Added: 0001668                       
08-31-04 23:25 quinn          Bugnote Added: 0001675                       
09-07-04 09:28 pzad           Bugnote Added: 0001702                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
