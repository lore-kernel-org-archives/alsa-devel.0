From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000767]: crash during ./cvscompile of alsa-utils package
Date: Mon, 14 Feb 2005 16:22:28 +0100
Message-ID: <9d93aa6d17920f29c8afb5acf756751e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 042B21EC
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 16:22:28 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=767> 
======================================================================
Reported By:                wbrown338
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   767
Category:                   aconnect
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             12-31-2004 16:01 CET
Last Modified:              02-14-2005 16:22 CET
======================================================================
Summary:                    crash during ./cvscompile of alsa-utils package
Description: 
gcc -shared  .libs/conf.o .libs/confmisc.o .libs/input.o .libs/output.o
.libs/async.o .libs/error.o .libs/dlmisc.o .libs/socket.o .libs/shmarea.o
.libs/userfile.o -Wl,--whole-archive control/.libs/libcontrol.a
mixer/.libs/libmixer.a ordinary_mixer/.libs/libordinarymixer.a
pcm/.libs/libpcm.a ordinary_pcm/.libs/libordinarypcm.a
rawmidi/.libs/librawmidi.a timer/.libs/libtimer.a hwdep/.libs/libhwdep.a
seq/.libs/libseq.a instr/.libs/libinstr.a compat/.libs/libcompat.a
alisp/.libs/libalisp.a -Wl,--no-whole-archive  -lm -ldl -lpthread 
-Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name
snd_pcm_hw_params_get_buffer_size_max@ALSA_0.9
/usr/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/usr/src/alsa/alsa-lib/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-lib/src'
make: *** [all-recursive] Error 1

======================================================================

----------------------------------------------------------------------
 jdthood - 02-13-05 11:00 
----------------------------------------------------------------------
This report can probably be closed.

----------------------------------------------------------------------
 tiwai - 02-14-05 16:22 
----------------------------------------------------------------------
Yeah, let's close this.  Please reopen if any new information is available.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 16:01 wbrown338      New Issue                                    
01-03-05 12:06 tiwai          Project                  ALSA - utils => ALSA -
lib
01-03-05 12:12 tiwai          Note Added: 0003055                          
02-13-05 11:00 jdthood        Note Added: 0003581                          
02-14-05 16:22 tiwai          Status                   new => resolved     
02-14-05 16:22 tiwai          Resolution               open => unable to
duplicate
02-14-05 16:22 tiwai          Assigned To               => tiwai           
02-14-05 16:22 tiwai          Note Added: 0003597                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
