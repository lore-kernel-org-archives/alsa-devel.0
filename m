From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000990]: Failure to build "make: *** src/pcm/ext: No such file or directory."
Date: Mon, 14 Mar 2005 07:44:44 +0100
Message-ID: <a0dbabe90facb2002fc705d566a08c22@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A00661C9
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2005 07:44:44 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              03-14-2005 07:44 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 07:44 jdthood        New Issue                                    
03-14-05 07:44 jdthood        File Added: alsa-lib_20050313jdth1.buildlog       
            
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
