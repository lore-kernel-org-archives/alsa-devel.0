From: noreply@alsa-project.org
Subject: [ALSA - lib 0000389]: random buffer snd_output_t issues
Date: Tue, 20 Jul 2004 17:36:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040720153633.535F323003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AACE21E0
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2004 17:36:33 +0200 (MEST)
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


The following bug has been ASSIGNED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000389
======================================================================
Reported By:                Benjamin Otte
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - lib
Bug ID:                     389
Category:                   general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             07-15-2004 20:09 CEST
Last Modified:              07-20-2004 17:36 CEST
======================================================================
Summary:                    random buffer snd_output_t issues
Description: 
There are several issues with using a snd_output_t acquired from
snd_output_buffer_open(). These cause random segfaults because of
writing/reading invalid memory.
The attached patch fixes those issues.

======================================================================

----------------------------------------------------------------------
 Benjamin Otte - 07-15-2004 20:14 CEST 
----------------------------------------------------------------------
patch to fix the issues.
These include:
- snd_output_buffer_need might not resize the buffer to be big enough, if
huge sizes are required.
- calculating the needed buffer size does not take care of the terminating
null byte vsprintf puts at the end. So in rare cases, the buffer is
exactly one byte too small. Use vsnprintf instead to guard against these
problems.
- snd_output_buffer_print does not correct the size member for the number
of bytes added.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-15-04 20:09 Benjamin Otte  New Bug                                      
07-15-04 20:09 Benjamin Otte  File Added: test-overwrite.c                    
07-15-04 20:14 Benjamin Otte  Bugnote Added: 0001438                       
07-15-04 20:15 Benjamin Otte  File Added: output-buffer.patch                    
07-20-04 17:36 Clemens LadischAssigned To               => Clemens Ladisch 
07-20-04 17:36 Clemens LadischStatus                   new => assigned     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
