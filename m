From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000756]: ASRock k7vt4a+ with CMedia CMI9761 no mixer!
Date: Fri, 7 Jan 2005 19:53:53 +0100
Message-ID: <257d86caa6327e7c1b329fc47ca818f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 87048275
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 19:53:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=756> 
======================================================================
Reported By:                wschrep
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   756
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian/knoppmyth
Kernel Version:             2.6.10
======================================================================
Date Submitted:             12-29-2004 01:15 CET
Last Modified:              01-07-2005 19:53 CET
======================================================================
Summary:                    ASRock k7vt4a+ with CMedia CMI9761 no mixer!
Description: 
Well on the website it states I have this chip:
CMedia CMI9761 6 channel AC'97 audio codec

When I do an lsmod I get this: 
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)

So I use the via82xx alsa sound driver module

I get sound but when I use the mixer settings only mute works I cannot
change the levels of the audio output neither master or pcm changes
anything.

I did have to use the 1.0.4 drivers instead of 1.0.5 release because of
compilation bug see other bugreport. The libs and utils from version 1.0.4
and 1.0.5 compile without problems but with neither can I get the controls
to work.


======================================================================

----------------------------------------------------------------------
 rdvrey - 01-03-05 00:40 
----------------------------------------------------------------------
I have the same hardware using
Gentoo 2.4.26-gentoo-r9 kernel
1.07-r4 alsa driver
No error messages anywhere all modules load without any problem 
But no sound at all
Is this the same issue?
if so will 1.08 handle this as well?
Would help the devel team if I test new drivers?

regards,

Robert

----------------------------------------------------------------------
 tiwai - 01-07-05 19:53 
----------------------------------------------------------------------
Try 1.0.8rc2.  It already incldues the softvol plugin.
Choose "default" PCM, so that softvol is applied automatically. (i.e.
don't use "hw:0" or so.)

Unfortunately, OSS kernel emulation can't use softvol feature.  Don't ask
me to fix this...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 01:15 wschrep        New Issue                                    
12-29-04 01:15 wschrep        Distribution              => debian/knoppmyth
12-29-04 01:15 wschrep        Kernel Version            => 2.6.10          
12-29-04 01:18 rlrevell       Note Added: 0002989                          
12-29-04 01:24 wschrep        Note Added: 0002990                          
12-29-04 01:38 rlrevell       Note Added: 0002991                          
01-03-05 00:40 rdvrey         Note Added: 0003050                          
01-03-05 01:57 rdvrey         Issue Monitored: rdvrey                      
01-07-05 19:53 tiwai          Note Added: 0003119                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
