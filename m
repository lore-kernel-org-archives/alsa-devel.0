From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002337]: Compilation problem ...
	previous advice here didn't work for me ...
Date: Sat, 5 Aug 2006 14:04:08 +0200
Message-ID: <b4977baa38b19f2cfa14e89e1780e5db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4384516E
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 14:04:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2337> 
======================================================================
Reported By:                Mikey84
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2337
Category:                   alsactl
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-05-2006 09:46 CEST
Last Modified:              08-05-2006 14:04 CEST
======================================================================
Summary:                    Compilation problem ... previous advice here didn't
work for me ...
Description: 
I have also a compilation problem. Almost similar as cimmo had, and I tried
to do the same tricks as he was told to do, but they didn't work ... I
have alsa-driver and alsa-lib correctly installed, but this alsa-utils
doesn't compile ...

'Make' gives me this kind of error message:

_______________________________________________________________________________

Making all in amixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
gcc  -g -O2   -o amixer  amixer.o -lm -lasound -lm -ldl -lpthread
amixer.o: In function `control_access':
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:157:
undefined reference to `snd_ctl_elem_info_is_tlv_readable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:158:
undefined reference to `snd_ctl_elem_info_is_tlv_writable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:159:
undefined reference to `snd_ctl_elem_info_is_tlv_commandable'
amixer.o: In function `show_control':
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:539:
undefined reference to `snd_ctl_elem_info_is_tlv_readable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:542:
undefined reference to `snd_hctl_elem_tlv_read'
collect2: ld returned 1 exit status
make[1]: *** [amixer] Error 1
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
make: *** [all-recursive] Error 1
[root@a-55-58 alsa-utils-1.0.12rc2]#

_______________________________________________________________________________
                                      
======================================================================

----------------------------------------------------------------------
 Raymond - 08-05-06 10:10 
----------------------------------------------------------------------
alsa-util depends on alsa-lib, must be same version

----------------------------------------------------------------------
 Mikey84 - 08-05-06 14:04 
----------------------------------------------------------------------
I have all the same versions (1.0.12rc2), but still it doesn't work ...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-06 09:46 Mikey84        New Issue                                    
08-05-06 10:10 Raymond        Note Added: 0011423                          
08-05-06 14:04 Mikey84        Note Added: 0011430                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
