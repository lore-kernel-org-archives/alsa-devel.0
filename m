From: noreply@alsa-project.org
Subject: [ALSA - lib 0000178]: Can't play multiple streams to "rear" on SB Live (emu10k1)
Date: Fri, 16 Jul 2004 12:53:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105309.2958026009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 74A2C200
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:53:09 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000178
======================================================================
Reported By:                pwk
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     178
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             04-02-2004 17:47 CEST
Last Modified:              07-16-2004 12:53 CEST
======================================================================
Summary:                    Can't play multiple streams to "rear" on SB Live (emu10k1)
Description: 
Well,

apparently I can't play sounds from two programmes to "rear" on my emu10k1
chipset based SoundBlaster Live! On irc I was given a fix for this in
Oktober, and I was astounded that this fix was not included in alsa-lib
1.0.2 or 1.0.3 etc. realizing that you apparently did not know about the
problem, so I report it here.

The Problem was described to me on irc as:
"Oct 08 00:14:02 <jcdutton>      When playing the rear channel, it was
locking the Wave Surround mixer slider, so that when the next was played,
the lock could not happen."

the fix that works fine here is:

Oct 08 00:06:17 <jcdutton>      edit /usr/share/alsa/cards/EMU10K1.conf
Oct 08 00:07:02 <jcdutton>      backup the file, then, lines 33 - 38.
Delete them.

======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:39 CEST 
----------------------------------------------------------------------
works for me with 1.0.4.

----------------------------------------------------------------------
 pwk - 05-13-2004 13:51 CEST 
----------------------------------------------------------------------
Sorry for the delay. I only just managed to find time to upgrade to 1.0.4,
and must say I get the same result. If I am playing music via xmms to
"rear", and then start up xine, that also outputs to rear, then xine will
not play any sounds...about 2 seconds after I hit "stop" in xmms, xine
will start playing sound.
After aplying said fix, it works as expected again - meaning xmms plays
its music while xine is playing the film sounds.

edited on: 05-13-04 13:51

----------------------------------------------------------------------
 tiwai - 05-13-2004 14:08 CEST 
----------------------------------------------------------------------
ok, confirmed.
sorry i've overseen you're using sb live.  i tested only audigy.

fixed on cvs now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-02-04 17:47 pwk            New Bug                                      
04-03-04 13:54 perex          Description Updated                          
04-03-04 13:54 perex          View Status              @0@ => public       
04-19-04 21:24 perex          Assigned To               => perex           
04-19-04 21:24 perex          Status                   new => assigned     
04-23-04 17:39 tiwai          Bugnote Added: 0000911                       
05-13-04 13:50 pwk            Bugnote Added: 0001103                       
05-13-04 13:51 pwk            Bugnote Edited: 0001103                      
05-13-04 14:08 tiwai          Bugnote Added: 0001104                       
05-13-04 14:08 tiwai          Assigned To              perex => tiwai      
05-13-04 14:08 tiwai          Resolution               open => fixed       
05-13-04 14:08 tiwai          Status                   assigned => resolved
07-16-04 12:53 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
