From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002337]: Compilation problem ...
	previous advice here didn't work for me ...
Date: Sun, 6 Aug 2006 15:24:08 +0200
Message-ID: <cefda628dc5787710afbfc2a6f135568@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65F9F18F
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 15:24:08 +0200 (MEST)
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
Status:                     feedback
======================================================================
Date Submitted:             08-05-2006 09:46 CEST
Last Modified:              08-06-2006 15:24 CEST
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
 Mikey84 - 08-06-06 07:14 
----------------------------------------------------------------------
Still it didn't work ... I used the '--prefix' and '--libdir' commands with
the both alsa-lib and alsa-utils, but still ... So, if this is the
problem, should I do something else? What commands I exactly have to use?

----------------------------------------------------------------------
 Raymond - 08-06-06 15:24 
----------------------------------------------------------------------
alsa-driver

http://hg-mirror.alsa-project.org/alsa-kernel?f=258da3fe5bb1;file=Documentation/ALSA-Configuration.txt;style=gitweb

alsa-lib

http://hg-mirror.alsa-project.org/alsa-lib?f=8f8cb7b13673;file=INSTALL;style=gitweb

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-06 09:46 Mikey84        New Issue                                    
08-05-06 10:10 Raymond        Note Added: 0011423                          
08-05-06 14:04 Mikey84        Note Added: 0011430                          
08-05-06 14:33 jcdutton       Note Added: 0011433                          
08-05-06 14:33 jcdutton       Status                   new => feedback     
08-05-06 14:44 Mikey84        Note Added: 0011434                          
08-05-06 15:24 Raymond        Note Added: 0011437                          
08-06-06 07:14 Mikey84        Note Added: 0011464                          
08-06-06 15:24 Raymond        Note Added: 0011471                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
