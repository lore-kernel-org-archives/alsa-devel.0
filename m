From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000640]: azx code is nasty
Date: Fri, 12 Nov 2004 12:22:10 +0100
Message-ID: <797ca15d39e0f4b4ee9a138ff8093df0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4ADA263
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:22:10 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=640> 
======================================================================
Reported By:                russell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   640
Category:                   PCI - azx
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
Distribution:               Debian/Ubuntu
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-10-2004 14:30 CET
Last Modified:              11-12-2004 12:22 CET
======================================================================
Summary:                    azx code is nasty
Description: 
Some of the code in the azx driver is very difficult to read, depending on
how you set up tabs etc in your IDE. This is a[n almost] purely cosmetic
change to codec_enum.c

I have commented out some of the snd_printdd()s inside the smaller helper
functions too (to make my poor l'il log look nicer). I have also changed
one obviously inefficient function (get_bit_value()) into a macro. All
seems to compile and work about as well as 1.0.7rc2 does (for me, not
particularly well - hence my work on it)
======================================================================

----------------------------------------------------------------------
 tiwai - 11-12-04 12:22 
----------------------------------------------------------------------
Please put the opening trace '{' to the same line of if/for/while as
written in Documentation/CodingStyle.
Also, it'd be nicer to have a space between if/for/while and the opening
parenthesis '('.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-04 14:30 russell        New Issue                                    
11-10-04 14:30 russell        File Added: codec_enum.c                     
11-10-04 14:30 russell        Distribution              => Debian/Ubuntu   
11-10-04 14:30 russell        Kernel Version            => 2.6.8.1         
11-12-04 12:22 tiwai          Note Added: 0002393                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
