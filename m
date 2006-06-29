From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002218]: Everything ok but no sound.
Date: Thu, 29 Jun 2006 18:15:40 +0200
Message-ID: <1e7e04ebc10fb975d27d6812ac72d51c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C613729E
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 18:15:40 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2218> 
======================================================================
Reported By:                Layn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2218
Category:                   PCI - hda-intel
Reproducibility:            unable to duplicate
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.16
======================================================================
Date Submitted:             06-18-2006 16:55 CEST
Last Modified:              06-29-2006 18:15 CEST
======================================================================
Summary:                    Everything ok but no sound.
Description: 
I have installed the lasted driver for my soundcard from hg, also i have
try with ubuntu dapper beta live-cd and finally i have the stable 1.0.11
driver, lib and utils from alsa repository.
Everything look fine, with alsamixer the pcm volume is in 100%, but there
isnt sound, i have probe with mpg123, mplayer and aplay, and never play
anything. No error, nothing...
======================================================================

----------------------------------------------------------------------
 Layn - 06-21-06 09:15 
----------------------------------------------------------------------
Hello Jose,
I have read the threat 2035, i think that could be the same too, my laptop
is ahtec too, like yours.

Tiwai, thanks for your reply.
When i used the hg modules, i could see in dmesg, the models, so the
models is really passed.
What other test can i do?

Thanks

----------------------------------------------------------------------
 tiwai - 06-29-06 18:15 
----------------------------------------------------------------------
Well, ALC861 is what I'm not really maintaining (I never had this codec and
tested by myself).  Hopefully some of realtek patches fixed (or will fix)
the problem...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 16:55 Layn           New Issue                                    
06-18-06 16:55 Layn           Distribution              => Debian          
06-18-06 16:55 Layn           Kernel Version            => 2.6.16          
06-20-06 19:54 tiwai          Note Added: 0010351                          
06-20-06 22:50 jlpedrosa      Note Added: 0010355                          
06-21-06 09:15 Layn           Note Added: 0010385                          
06-21-06 09:26 Layn           Note Added: 0010387                          
06-21-06 09:26 Layn           Note Deleted: 0010387                        
06-29-06 18:15 tiwai          Note Added: 0010684                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
