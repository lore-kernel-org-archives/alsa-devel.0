From: noreply@alsa-project.org
Subject: [ALSA - driver 0000385]: Rate conversion plugin generates noise on frequency reduction
Date: Thu, 15 Jul 2004 14:07:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715120755.0C16215007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 66DEC1EF
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 14:07:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000385
======================================================================
Reported By:                fmoraes
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     385
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-13-2004 19:46 CEST
Last Modified:              07-15-2004 14:07 CEST
======================================================================
Summary:                    Rate conversion plugin generates noise on frequency reduction
Description: 
When reducing the frequency, the pcm_rate plugin causes noise on the output
data. This has been tested with both the snd-cs46xx and snd-emu10k1x
drivers and the following .asoundrc can be used to recreate the output in
a file:

pcm.CS46xx {
	type hw
	card 0
}

pcm.filetest {
	type file
	slave {
		pcm "CS46xx"
	}
	file "/home/fmoraes/test-out.raw"
	format "raw"
}

pcm.test {
	type rate
	slave {
		pcm "filetest"
		format "S16_LE"
		rate 8000
	}
}

Playing a 48Khz file will cause noticeable noise on the output (noise is
more noticeable the lower the target frequency is).
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:46 fmoraes        New Bug                                      
07-15-04 14:07 perex          Assigned To               => perex           
07-15-04 14:07 perex          Status                   new => assigned     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
