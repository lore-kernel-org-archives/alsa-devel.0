From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000703]: alsa-driver-1.0.7 compile error dealing with 'remap_page_range'
Date: Mon, 6 Dec 2004 20:51:53 +0100
Message-ID: <8ce2a6bb29eb31fd577434ea3902eab3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1772F3A9
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 20:51:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=703> 
======================================================================
Reported By:                Nsane457
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   703
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             linux-2.6.9-nitro4 (also tried mm-sources and
gentoo-dev-sources)
======================================================================
Date Submitted:             12-03-2004 21:00 CET
Last Modified:              12-06-2004 20:51 CET
======================================================================
Summary:                    alsa-driver-1.0.7 compile error dealing with
'remap_page_range'
Description: 
Since I have a crappy OEM Dell SBLive! soundcard I can't use the emu10k1
module.  I need the emu10k1x module which is now supported in alsa but not
in any kernel.  I followed the instructions from
http://gentoo-wiki.com/HOWTO_ALSA_sound_mixer_aka_dmix .  But no matter
what it won't compile. I changed the ALSA_CARDS variable to other cards,
and just one card, and it won't work.
======================================================================

----------------------------------------------------------------------
 Nsane457 - 12-06-04 11:01 
----------------------------------------------------------------------
Keep in mind that this is a Gentoo Linux installation so the OS is setup to
input the compilation variables automatically.  One is not expected to use
the ./configure command because the portage system inputs it
automatically.  But as is evident , although the system of installation
seems correct, there is something buggy in the compile.

----------------------------------------------------------------------
 tiwai - 12-06-04 20:51 
----------------------------------------------------------------------
I guess it's a bug in gentoo's patch to configure script.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-03-04 21:00 Nsane457       New Issue                                    
12-03-04 21:00 Nsane457       File Added: 2299-alsa-driver-1.0.7-r1.log         
          
12-03-04 21:00 Nsane457       Distribution              => Gentoo 2004.3   
12-03-04 21:00 Nsane457       Kernel Version            => linux-2.6.9-nitro4
(also tried mm-sources and gentoo-dev-sources)
12-03-04 21:03 Nsane457       File Added: straceinfo.log                    
12-03-04 21:11 rlrevell       Note Added: 0002713                          
12-04-04 00:53 eradicator     Note Added: 0002714                          
12-04-04 00:53 eradicator     Issue Monitored: eradicator                    
12-06-04 11:01 Nsane457       Note Added: 0002726                          
12-06-04 20:51 tiwai          Note Added: 0002731                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
