From: noreply@alsa-project.org
Subject: [ALSA - driver 0000140]: ALSA does not time out old audio output
Date: Fri, 16 Jul 2004 13:04:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110443.667EC26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D6DA5255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:04:43 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000140
======================================================================
Reported By:                titan
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     140
Category:                   OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.3-r2
======================================================================
Date Submitted:             03-16-2004 17:43 CET
Last Modified:              07-16-2004 13:04 CEST
======================================================================
Summary:                    ALSA does not time out old audio output
Description: 
When running both XMMS (i.e. playing internet streaming radio) and GAIM (or
any program that will produce sound on the same channel, i.e. PCM), the
sounds from the second program will be buffered indefinately and played as
soon as XMMS stops monopolizing the channel.
======================================================================

----------------------------------------------------------------------
 perex - 03-16-2004 19:43 CET 
----------------------------------------------------------------------
This is POSIX feature. If you want to disable it, use

options snd-pcm-oss nonblock_open=1

in your /etc/modules.conf.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-16-04 17:43 titan          New Bug                                      
03-16-04 17:43 titan          Distribution              => Gentoo          
03-16-04 17:43 titan          Kernel Version            => 2.6.3-r2        
03-16-04 19:43 perex          Bugnote Added: 0000629                       
03-16-04 19:43 perex          Assigned To               => perex           
03-16-04 19:43 perex          Resolution               open => fixed       
03-16-04 19:43 perex          Status                   new => resolved     
07-16-04 13:04 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
