From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000442]: alsactl no loading pcm volume properly.
Date: Sun, 15 Aug 2004 06:35:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040815043523.2C52E1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8125920B
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2004 06:35:23 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000442
======================================================================
Reported By:                lupien_c
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     442
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 2
Kernel Version:             2.6.7 + acpi + swsusp2
======================================================================
Date Submitted:             08-15-2004 06:35 CEST
Last Modified:              08-15-2004 06:35 CEST
======================================================================
Summary:                    alsactl no loading pcm volume properly.
Description: 
When using alsactl restore after loading the snd_maestro3 sound driver, the
pcm volume is restore only on the right channel. Checking the
settings(with alsactl store or alsamixer) shows the correct value but the
left channel is quiet. 

The same effect is seen when restoring after setting the pcm channel
volume to 0. With a small non-zero volume, the left channel starts quiet
but after a few secdonds comes on.

Changing the pcm channel volume with alsamixer, always works properly and
recovers proper stereo.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 06:35 lupien_c       New Bug                                      
08-15-04 06:35 lupien_c       Distribution              => fedora core 2   
08-15-04 06:35 lupien_c       Kernel Version            => 2.6.7 + acpi + swsusp2
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
