From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000756]: ASRock k7vt4a+ with CMedia CMI9761 no mixer!
Date: Wed, 19 Jan 2005 16:53:06 +0100
Message-ID: <ac4c59d5d113e72368db06a4842a807a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 653DD20E
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 16:53:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=756> 
======================================================================
Reported By:                wschrep
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   756
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               debian/knoppmyth
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-29-2004 01:15 CET
Last Modified:              01-19-2005 16:53 CET
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
 tiwai - 01-07-05 19:53 
----------------------------------------------------------------------
Try 1.0.8rc2.  It already incldues the softvol plugin.
Choose "default" PCM, so that softvol is applied automatically. (i.e.
don't use "hw:0" or so.)

Unfortunately, OSS kernel emulation can't use softvol feature.  Don't ask
me to fix this...

----------------------------------------------------------------------
 tiwai - 01-19-05 16:53 
----------------------------------------------------------------------
1.0.8 has softvol.

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
01-19-05 16:53 tiwai          Status                   new => resolved     
01-19-05 16:53 tiwai          Resolution               open => fixed       
01-19-05 16:53 tiwai          Assigned To               => tiwai           
01-19-05 16:53 tiwai          Note Added: 0003295                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
