From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000174]: CVS build problem
Date: Wed, 16 Mar 2005 22:18:37 +0100
Message-ID: <4ffd183a3e9025e7a2e8788c73b7b803@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5957A231
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 22:18:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=174> 
======================================================================
Reported By:                bgolenko
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   174
Category:                   general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-31-2004 17:36 CEST
Last Modified:              03-16-2005 22:18 CET
======================================================================
Summary:                    CVS build problem
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
make[2]: Leaving directory `/home/bartek/tomove/alsa-cvs/alsa-lib/src'
======================================================================

----------------------------------------------------------------------
 perex - 04-15-04 20:30 
----------------------------------------------------------------------
It looks like gcc/binutils problem. You may try to compile library with
--with-versioned=no option.

----------------------------------------------------------------------
 jdthood - 03-16-05 22:18 
----------------------------------------------------------------------
This can probably be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 17:36 bgolenko       New Issue                                    
04-15-04 20:30 perex          Note Added: 0000822                          
03-16-05 22:18 jdthood        Note Added: 0003965                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
