From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000521]: Jack + Alsa not working in full duplex, works with OSS, griffin imic
Date: Fri,  8 Oct 2004 18:40:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008164053.43DB94800E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4640286
	for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2004 18:40:53 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000521
======================================================================
Reported By:                LokiDavison
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     521
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.22-28mm.2mdk
======================================================================
Date Submitted:             09-21-2004 21:06 CEST
Last Modified:              10-08-2004 18:40 CEST
======================================================================
Summary:                    Jack + Alsa not working in full duplex, works with OSS, griffin imic
Description: 
Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver. The alsa driver works full duplex when used with alsa
apps. 100% reproducable. This is using a griffin imic with the
snd-usb-audio module tested on 2.6 and 2.4 kernels. All jack versions
including 0.99. I'm often on LAD irc if you want more info.
======================================================================

----------------------------------------------------------------------
 ryanpg - 10-08-2004 18:40 CEST 
----------------------------------------------------------------------
I also find this bug when using my EMI 2|6 soundcard.

Jack works with the OSS audio driver in full duplex but only works simplex
with alsa driver.

2.6 and 2.4 kernels. All jack versions including 0.99.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 21:06 LokiDavison    New Bug                                      
09-21-04 21:06 LokiDavison    Distribution              => Mandrake        
09-21-04 21:06 LokiDavison    Kernel Version            => 2.4.22-28mm.2mdk
10-08-04 18:32 ryanpg         Bug Monitored: ryanpg                        
10-08-04 18:40 ryanpg         Bugnote Added: 0002055                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
