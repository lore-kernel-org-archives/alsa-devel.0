From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000990]: Failure to build "make: *** src/pcm/ext: No such file or directory."
Date: Tue, 15 Mar 2005 23:12:52 +0100
Message-ID: <1ac59e847a8991842f0c17bb69f64124@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 91458217
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2005 23:12:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=990> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   990
Category:                   general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-14-2005 07:44 CET
Last Modified:              03-15-2005 23:12 CET
======================================================================
Summary:                    Failure to build "make: *** src/pcm/ext: No such
file or directory."
Description: 
Build of alsa-lib 1.0.9rc1 ends like this:

Making all in utils
make[2]: Entering directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1/utils'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1/utils'
make[2]: Entering directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1'
cd . && /bin/sh ./config.status Makefile
config.status: creating Makefile
make[2]: Leaving directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1'
make[2]: Entering directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1'
make[1]: Leaving directory
`/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1'
/usr/bin/make -C src/pcm/ext jack CFLAGS="-g -Wall -O2"
make: *** src/pcm/ext: No such file or directory.  Stop.
make: *** [build-arch-stamp] Error 2
build command failed in
/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-lib-1.0.9rc1
Aborting.
W: build directory not purged!

The src/pcm/ext subdirectory does not exist.

I attach the full build log.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-15-05 23:03 
----------------------------------------------------------------------
rlrevell@mindpipe:~/cvs/alsa$ find -name pcm_jack.c
./alsa-plugins/pcm/jack/pcm_jack.c

----------------------------------------------------------------------
 jdthood - 03-15-05 23:12 
----------------------------------------------------------------------
> ./alsa-plugins/pcm/jack/pcm_jack.c

Does this mean that alsa-plugins will be shipped in a separate tarball?

No such tarball is visible on alsa's homepage.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 07:44 jdthood        New Issue                                    
03-14-05 07:44 jdthood        File Added: alsa-lib_20050313jdth1.buildlog       
            
03-14-05 07:46 jdthood        File Added: 01_alpha_versioned_symbols.dpatch     
              
03-14-05 07:47 jdthood        File Added: 02_aclocal_libs_fix.dpatch            
       
03-15-05 22:41 jdthood        Note Added: 0003919                          
03-15-05 22:55 rlrevell       Note Added: 0003921                          
03-15-05 23:01 jdthood        Note Added: 0003922                          
03-15-05 23:03 rlrevell       Note Added: 0003923                          
03-15-05 23:12 jdthood        Note Added: 0003924                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
