From: noreply@alsa-project.org
Subject: [ALSA - driver 0000218]: The PCM mixer control appears permanently muted.
Date: Fri, 16 Jul 2004 12:42:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104215.3A8F426009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 78265255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:42:15 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000218
======================================================================
Reported By:                inaudible
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     218
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Redhat 9 plus newer packages from Fedora core 1
Kernel Version:             Vanilla 2.6.5
======================================================================
Date Submitted:             04-17-2004 09:40 CEST
Last Modified:              07-16-2004 12:42 CEST
======================================================================
Summary:                    The PCM mixer control appears permanently muted.
Description: 
I can not play PCM data, but I can play cdroms. 
The 'CD' and 'Master' volume controls work normally.  
The ALSA tools appear to adjust the PCM volume, but do not show a mute
option.
The OSS tools report PCM 0 volume, no matter how they are set.

Alsamixer reports my hardware as an AD1885.  
My AD1885 documentation shows the PCM output gain controlled by register
18h.
I adjusted the gains with mixer tools, and monitored register 18h of
/proc/asound/card0/codec97#0/ac97#0-0+regs.  
The two 5-bit gain fields, behaved as documented;
all zeros at 100% and all ones at 0%.  The mute bit (D15) however,
remained set no matter what I did. 

In summary it appears that my hardware is honoring the mute bit in
register 18h, but the ALSA tools do not recognize its existence.  This
leaves me with permanently muted PCM output. 
======================================================================

----------------------------------------------------------------------
 perex - 04-19-2004 16:40 CEST 
----------------------------------------------------------------------
What is output from 'amixer contents'?

----------------------------------------------------------------------
 inaudible - 04-19-2004 18:34 CEST 
----------------------------------------------------------------------
Output from 'amixer contents' uploaded as amixer_contents.txt.

----------------------------------------------------------------------
 perex - 04-19-2004 20:09 CEST 
----------------------------------------------------------------------
Please, try ad18xx-fix.patch.txt...

----------------------------------------------------------------------
 inaudible - 04-19-2004 23:40 CEST 
----------------------------------------------------------------------
The patch fixed it, thanks.

----------------------------------------------------------------------
 perex - 04-20-2004 11:10 CEST 
----------------------------------------------------------------------
Fixed in CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-17-04 09:40 inaudible      New Bug                                      
04-17-04 09:40 inaudible      File Added: pcmdoc.txt                       
04-17-04 09:40 inaudible      Distribution              => Redhat 9 plus newer packages from Fedora core 1
04-17-04 09:40 inaudible      Kernel Version            => Vanilla 2.6.5   
04-19-04 15:37 perex          Assigned To               => perex           
04-19-04 15:37 perex          Status                   new => assigned     
04-19-04 16:40 perex          Bugnote Added: 0000858                       
04-19-04 18:31 inaudible      File Added: amixer_contents.txt                    
04-19-04 18:34 inaudible      Bugnote Added: 0000861                       
04-19-04 20:08 perex          File Added: ad18xx-fix.patch.txt                    
04-19-04 20:09 perex          Bugnote Added: 0000862                       
04-19-04 23:40 inaudible      Bugnote Added: 0000866                       
04-20-04 11:10 perex          Resolution               open => fixed       
04-20-04 11:10 perex          Status                   assigned => resolved
04-20-04 11:10 perex          Bugnote Added: 0000870                       
07-16-04 12:42 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
