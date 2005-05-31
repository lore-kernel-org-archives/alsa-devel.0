From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001146]: Cannot compile alsa-utils
Date: Tue, 31 May 2005 13:04:40 +0200
Message-ID: <c4cf3746f07ce97c167ac2a9b5331b90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0302319C
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 13:04:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1146> 
======================================================================
Reported By:                Cimmo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1146
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4 test3
Kernel Version:             2.6.11-1.1363_FC4-x86_64 (contains 2.6.12rc5)
======================================================================
Date Submitted:             05-30-2005 15:06 CEST
Last Modified:              05-31-2005 13:04 CEST
======================================================================
Summary:                    Cannot compile alsa-utils
Description: 
Compiling alsa-utils 1.0.9 with gcc 4.0.0 I've this error:

Making all in alsactl
make[1]: Entering directory
`/home/cimmo/updates/alsa-utils-1.0.9/alsactl'
gcc  -g -O2   -o alsactl  alsactl.o state.o power.o names.o  -lasound -lm
-ldl -lpthread
names.o(.text+0xdce): In function `probe_timers':
/home/cimmo/updates/alsa-utils-1.0.9/alsactl/names.c:425: undefined
reference to `snd_timer_ginfo_sizeof'
names.o(.text+0xdee):/home/cimmo/updates/alsa-utils-1.0.9/alsactl/names.c:425:
undefined reference to `snd_timer_ginfo_sizeof'
names.o(.text+0xe4e):/home/cimmo/updates/alsa-utils-1.0.9/alsactl/names.c:435:
undefined reference to `snd_timer_ginfo_set_tid'
names.o(.text+0xebf):/home/cimmo/updates/alsa-utils-1.0.9/alsactl/names.c:445:
undefined reference to `snd_timer_ginfo_get_name'
collect2: ld returned 1 exit status
make[1]: *** [alsactl] Error 1
make[1]: Leaving directory `/home/cimmo/updates/alsa-utils-1.0.9/alsactl'
make: *** [all-recursive] Error 1
======================================================================

----------------------------------------------------------------------
 Cimmo - 05-31-05 13:03 
----------------------------------------------------------------------
In fact I have old lib in /lib and new one in /usr/lib, so I have to delete
old one?

----------------------------------------------------------------------
 tiwai - 05-31-05 13:04 
----------------------------------------------------------------------
Yes.  Or run configure with the proper option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-05 15:06 Cimmo          New Issue                                    
05-30-05 15:06 Cimmo          Distribution              => Fedora Core 4 test3
05-30-05 15:06 Cimmo          Kernel Version            =>
2.6.11-1.1363_FC4-x86_64 (contains 2.6.12rc5)
05-30-05 15:11 perex          Status                   assigned => resolved
05-30-05 15:11 perex          Resolution               open => fixed       
05-30-05 15:11 perex          Note Added: 0004818                          
05-30-05 15:36 Cimmo          Status                   resolved => feedback
05-30-05 15:36 Cimmo          Resolution               fixed => reopened   
05-30-05 15:36 Cimmo          Note Added: 0004820                          
05-31-05 12:52 tiwai          Note Added: 0004823                          
05-31-05 13:03 Cimmo          Note Added: 0004826                          
05-31-05 13:04 tiwai          Note Added: 0004828                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
