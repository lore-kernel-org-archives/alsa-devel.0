From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000573]: no SPDIF output with vt82xx/ICEnsemble VT1616i
Date: Sat,  9 Oct 2004 00:59:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008225904.B99404800E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1BF43242
	for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2004 00:59:05 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id CC1322C9D8
	for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2004 00:59:04 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000573
======================================================================
Reported By:                vladimir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     573
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3 test 2
Kernel Version:             2.6.8-1.541, as shipped with FC3t2
======================================================================
Date Submitted:             10-09-2004 00:59 CEST
Last Modified:              10-09-2004 00:59 CEST
======================================================================
Summary:                    no SPDIF output with vt82xx/ICEnsemble VT1616i
Description: 
With alsa 1.0.6 (in kernel), 1.0.7rc1, or CVS, I'm unable to reliably get
SPDIF output to work -- it might work once out of a dozen or so times. 
The attached patch improves things -- ignoring the cached values in
ac97_read_cache gives me working spdif playbac.  The values I see printed
with the printk added in ac97_read_cache by the patch are:

AC97_read_cache: register 0x002a has real value 0x01f1 cached 0x05f1 
AC97_read_cache: register 0x002a has real value 0x05f1 cached 0x01f1 

which indicates a change in the read-only SPCV bit.  Perhaps registers
with read-only status bits shouldn't be cached?  I'm not sure if that's
the fix, or if there's a deeper issue here.

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 00:59 vladimir       New Bug                                      
10-09-04 00:59 vladimir       File Added: ac97_codec-no-readcache.patch                    
10-09-04 00:59 vladimir       Distribution              => Fedora Core 3 test 2
10-09-04 00:59 vladimir       Kernel Version            => 2.6.8-1.541, as shipped with FC3t2
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
