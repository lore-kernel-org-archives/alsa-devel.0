From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000861]: Inserting module returns no errors, but /proc/asound/cards is still empty
Date: Mon, 14 Feb 2005 19:41:35 +0100
Message-ID: <c130f498006f101d73a4c82687801943@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E772248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:41:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=861> 
======================================================================
Reported By:                olsonle
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   861
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-30-2005 00:44 CET
Last Modified:              02-14-2005 19:41 CET
======================================================================
Summary:                    Inserting module returns no errors, but
/proc/asound/cards is still empty
Description: 
Inserting snd-cs4236 module appears to be successful.  In fact, lsmod shows
that the modules have indeed been loaded.  However, /proc/asound/cards
still reads "--- no soundcards ---".  Checking dmesg, as well as
/var/log/kernel/current, shows the following error messages:

[kernel] kobject_register failed for snd_page_alloc (-17)
[kernel] kobject_register failed for snd (-17)
[kernel] kobject_register failed for snd_timer (-17)
[kernel] kobject_register failed for snd_pcm (-17)
[kernel] kobject_register failed for snd_rawmidi (-17)
[kernel] kobject_register failed for snd_cs4236 (-17)

Running amixer of course fails as well, with a "no such device" error.

Kernel .config file is attached.
======================================================================

----------------------------------------------------------------------
 olsonle - 02-14-05 19:40 
----------------------------------------------------------------------
Updating to a later kernel build (2.6.10-gentoo-r6) seems to make the
problem go away.  Works for me.

----------------------------------------------------------------------
 tiwai - 02-14-05 19:41 
----------------------------------------------------------------------
Moved to FIXED.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-05 00:44 olsonle        New Issue                                    
01-30-05 00:44 olsonle        File Added: .config                          
01-30-05 00:44 olsonle        Distribution              => Gentoo          
01-30-05 00:44 olsonle        Kernel Version            => 2.6.10          
02-14-05 19:40 olsonle        Note Added: 0003603                          
02-14-05 19:41 tiwai          Status                   new => resolved     
02-14-05 19:41 tiwai          Resolution               open => fixed       
02-14-05 19:41 tiwai          Assigned To               => tiwai           
02-14-05 19:41 tiwai          Note Added: 0003604                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
