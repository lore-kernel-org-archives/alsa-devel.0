From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000990]: Failure to build "make: *** src/pcm/ext: No such file or directory."
Date: Wed, 16 Mar 2005 12:40:00 +0100
Message-ID: <55ec11dbf679136f7b293aa11bb62975@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EA2A3226
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 12:40:00 +0100 (MET)
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
Last Modified:              03-16-2005 12:40 CET
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
 tiwai - 03-16-05 12:33 
----------------------------------------------------------------------
It was fixed in CVS, so I have no idea why this happend on rc1.

And, yes, alsa-plugins tarball is missing.  We'll need to create one, or
merge it into alsa-tools tree.

----------------------------------------------------------------------
 jdthood - 03-16-05 12:40 
----------------------------------------------------------------------
>  It was fixed in CVS, so I have no idea why this happend on rc1.

The failure was Debian-specific, induced by the disappearance of
src/pcm/ext/ which our build script expected to be present.

So I guess this report can be closed, unless you want to regard it
as a request that the plugins tarball be created.

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
03-16-05 12:33 tiwai          Note Added: 0003942                          
03-16-05 12:40 jdthood        Note Added: 0003943                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
