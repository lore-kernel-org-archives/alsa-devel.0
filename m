From: joy ping <joy@pingfm.org>
Subject: wrong or incomplete documentation about alsa-cvs-install
Date: Wed, 22 May 2002 21:36:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0205222128200.1023-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

while i helped someone to compile and install alsa from cvs i noticed that
the INSTALL in alsa-driver is somehow incomplete.

original INSTALL:

For compilation you can use these commands:

        aclocal
        autoconf
        ./configure
        make dep
        make

but it should be:

make ALSAKERNELDIR=../alsa-kernel all-deps (if the alsa-kernel-dir is
really there)
aclocal
autoconf
./configure
make dep
make

regards

_____-
zsolt

________/\---------%%%___________-----------
webcast every sunday 2000 cest at pingfm.org


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
