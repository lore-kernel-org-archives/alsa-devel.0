From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000176]: Master volume does not alters center, LFE and surround channels on Creative Audigy
Date: Fri, 27 Aug 2004 20:23:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827182338.B89442C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 065351F7
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:23:39 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000176
======================================================================
Reported By:                adarovsky
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     176
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian testing/unstable
Kernel Version:             Vanilla 2.6.2
======================================================================
Date Submitted:             04-01-2004 07:27 CEST
Last Modified:              08-27-2004 20:23 CEST
======================================================================
Summary:                    Master volume does not alters center, LFE and surround channels on Creative Audigy
Description: 
Changing master volume affects only
front channels. All other channels stay unaffected.

======================================================================

----------------------------------------------------------------------
 pzad - 04-02-2004 11:30 CEST 
----------------------------------------------------------------------
upgrade to 2.6.3 or more
or to alsa 1.0.4rc1
in 2.6.2 is alsa 0.9.7 <- this is too old
current alsa version 1.0.4rc2

----------------------------------------------------------------------
 sdfg - 04-05-2004 04:37 CEST 
----------------------------------------------------------------------
I'm experiencing the same problem with the rear channels on my SoundBlaster
Live! Value using 2.6.4 release candidate 2 with a patchset based on -mm. 
The rear channel is only controlled by the Wave Surround mixer and outputs
even with the Master and PCM mixers muted.  A consequence of this is that
a volume level of 1 in the Wave Surround mixer is still too loud for me to
use my headphones with the rear output, so it's particularly irksome to
me.  I'll be trying the vanilla 2.6.5 at some point soon to see if there's
any improvement.

----------------------------------------------------------------------
 tiwai - 04-16-2004 16:06 CEST 
----------------------------------------------------------------------
sb live and audigy have different mixer controls.

another problem of emu10k1 is that the sensitivity of volume
values are different between mixer elements.  we'll provide
the dB volume control in future, so that this problem will be
solved.

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:23 CEST 
----------------------------------------------------------------------
resolved

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-01-04 07:27 adarovsky      New Bug                                      
04-01-04 07:27 adarovsky      Distribution              => Debian testing/unstable
04-01-04 07:27 adarovsky      Kernel Version            => Vanilla 2.6.2   
04-02-04 11:30 pzad           Bugnote Added: 0000732                       
04-05-04 04:37 sdfg           Bugnote Added: 0000751                       
04-16-04 16:05 tiwai          Description Updated                          
04-16-04 16:05 tiwai          Category                 CORE - control => PCI - emu10k1
04-16-04 16:06 tiwai          Bugnote Added: 0000840                       
04-19-04 16:50 perex          Status                   new => confirmed    
04-19-04 21:23 perex          duplicate_id             0 => 154            
04-19-04 21:23 perex          Assigned To               => perex           
04-19-04 21:23 perex          Resolution               open => duplicate   
04-19-04 21:23 perex          Status                   confirmed => resolved
07-29-04 21:50 blaster999     Bug Monitored: blaster999                    
08-27-04 20:23 jcdutton       Bugnote Added: 0001657                       
08-27-04 20:23 jcdutton       Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
