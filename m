From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001031]: Sound Blaster Live! 7.1 24-bit (ID: 10061102) muted
Date: Sat, 28 May 2005 12:19:18 +0200
Message-ID: <0d50daea1f360f2fef41e32c9f504911@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF32D205
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:19:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1031> 
======================================================================
Reported By:                Oleg Ivanenko
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1031
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.29
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-01-2005 16:25 CEST
Last Modified:              05-28-2005 12:19 CEST
======================================================================
Summary:                    Sound Blaster Live! 7.1 24-bit (ID: 10061102) muted
Description: 
Firstly, sorry for my ugly english.

I've subj soundcard, kernel 2.4.29 and alsa 1.0.8

corresponding alsa-driver ca0106 compiled and installed perfectly (imho).
no any errors. lsmod view all modules
alsa-lib and alsa-utils compiled and installed too whithout errors
/proc/asound/ looks seems a very good

alsamixer is working (mute/unmute, changing level), but I don't hear
anything with aplay, mplayer or mpg321 :(
jack start fails too

I've onboard sound card intel8x0 on the same computer -- it's work fine
when alone module loaded, whithout ca0106.

Any required logs, lspci etc will be sent. Just say what you need.

PS. i've similar problem as described in report "0000906: OSS mixer does
not work" too
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-01-05 22:59 
----------------------------------------------------------------------
The volume by default is set to 0, so no sound.
Run at the command line "alsamixer" and adjust the "Analog Front" volume
control.
You should then get sound from the Green jack on the card.

Use of the speaker-test application can help.
e.g.
speaker-test -c2 -Dplug:front

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:19 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-05 16:25 Oleg Ivanenko  New Issue                                    
04-01-05 16:25 Oleg Ivanenko  Kernel Version            => 2.4.29          
04-01-05 22:59 jcdutton       Note Added: 0004296                          
04-03-05 13:30 jcdutton       Status                   assigned => feedback
05-28-05 12:19 jcdutton       Status                   feedback => closed  
05-28-05 12:19 jcdutton       Note Added: 0004765                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
