From: noreply@alsa-project.org
Subject: [ALSA - lib 0000180]: cant play multiple streams to rear on emu10k1
Date: Fri, 16 Jul 2004 12:55:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105509.27A6C26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E0B0244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:55:09 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000180
======================================================================
Reported By:                pwk
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     180
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             04-03-2004 06:47 CEST
Last Modified:              07-16-2004 12:55 CEST
======================================================================
Summary:                    cant play multiple streams to rear on emu10k1
Description: 
Since my first try to bug report cant be found by me anywhere, I post
again...sorry if its a duplicate and I am to stupid to see my first
report.

The problem is, that I cant play multiple streams to "rear" with my
emu10k1 chipset. I got a fix for this issue long ago on the #alsa irc
channel, but I noticed it never made it into alsa lib...so I guess you
dont know about the problem, it was described as:

"When playing the rear channel, it was locking the Wave Surround mixer
slider, so that when the next was played, the lock could not happen."

the fix was (and still is in alsa-lib-1.0.3b)

Oct 08 00:06:17 <jcdutton>      edit /usr/share/alsa/cards/EMU10K1.conf
Oct 08 00:07:02 <jcdutton>      backup the file, then, lines 33 - 38.
Delete them.
======================================================================

----------------------------------------------------------------------
 perex - 04-03-2004 13:55 CEST 
----------------------------------------------------------------------
Duplicated.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-03-04 06:47 pwk            New Bug                                      
04-03-04 13:55 perex          duplicate_id             0 => 178            
04-03-04 13:55 perex          Assigned To               => perex           
04-03-04 13:55 perex          Resolution               open => duplicate   
04-03-04 13:55 perex          Status                   new => resolved     
04-03-04 13:55 perex          Bugnote Added: 0000734                       
07-16-04 12:55 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
