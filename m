From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001146]: Cannot compile alsa-utils
Date: Tue, 7 Jun 2005 08:21:42 +0200
Message-ID: <836387f439eda08c20ed2a795f84d82f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64D0214E
	for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2005 08:21:42 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1146> 
======================================================================
Reported By:                Cimmo
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   1146
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-30-2005 15:06 CEST
Last Modified:              06-07-2005 08:21 CEST
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
 perex - 05-30-05 15:11 
----------------------------------------------------------------------
Install correctly alsa-lib 1.0.9 as first.

----------------------------------------------------------------------
 Cimmo - 05-30-05 15:36 
----------------------------------------------------------------------
I've installed all CVS packages and followed these instructions
http://alsa.opensrc.org/index.php?page=AlsaCVS

so I think alsa-lib is now installed, but still compilation error...

----------------------------------------------------------------------
 tiwai - 05-31-05 12:52 
----------------------------------------------------------------------
Make sure that you have no /lib/libasound.so.*.  IIRC, FC3 installs
alsa-lib into /lib instead of /usr/lib.

----------------------------------------------------------------------
 Cimmo - 05-31-05 13:03 
----------------------------------------------------------------------
In fact I have old lib in /lib and new one in /usr/lib, so I have to delete
old one?

----------------------------------------------------------------------
 tiwai - 05-31-05 13:04 
----------------------------------------------------------------------
Yes.  Or run configure with the proper option.

----------------------------------------------------------------------
 Cimmo - 05-31-05 13:27 
----------------------------------------------------------------------
Ok using --libdir=/lib64 it compiled well.
Sorry for this bug-report.

best regards

----------------------------------------------------------------------
 tiwai - 06-01-05 16:52 
----------------------------------------------------------------------
OK, closing now.

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
05-31-05 13:27 Cimmo          Note Added: 0004830                          
06-01-05 16:52 tiwai          Status                   feedback => resolved
06-01-05 16:52 tiwai          Resolution               reopened => not an issue
06-01-05 16:52 tiwai          Note Added: 0004861                          
06-07-05 08:21 perex          Project                  ALSA - driver => ALSA -
utils
06-07-05 08:21 perex          Category                 0_compilation problem_!!!
=> alsactl
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
