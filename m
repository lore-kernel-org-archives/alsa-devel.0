From: noreply@alsa-project.org
Subject: [ALSA - lib 0000389]: random buffer snd_output_t issues
Date: Thu, 15 Jul 2004 20:09:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715180925.1F6861900B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 72208200
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 20:09:25 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 33C22122E5
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 20:09:25 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000389
======================================================================
Reported By:                Benjamin Otte
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     389
Category:                   general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-15-2004 20:09 CEST
Last Modified:              07-15-2004 20:09 CEST
======================================================================
Summary:                    random buffer snd_output_t issues
Description: 
There are several issues with using a snd_output_t acquired from
snd_output_buffer_open(). These cause random segfaults because of
writing/reading invalid memory.
The attached patch fixes those issues.

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-15-04 20:09 Benjamin Otte  New Bug                                      
07-15-04 20:09 Benjamin Otte  File Added: test-overwrite.c                    
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
