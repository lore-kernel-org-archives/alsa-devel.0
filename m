From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH] alsa-tools
Date: Mon, 16 May 2005 16:39:36 +0200
Message-ID: <20050516143936.GA12324@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 22153211
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2005 16:39:37 +0200 (MEST)
Received: from mulder.hem.za.org (unknown [84.217.31.114])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7C1EB71DC3
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2005 16:39:37 +0200 (MEST)
Received: from skinner.hem.za.org ([fec0::202:44ff:fe1d:d021])
	by mulder.hem.za.org with esmtp (Exim 4.50)
	id 1DXgkr-0002YG-FF
	for alsa-devel@alsa-project.org; Mon, 16 May 2005 16:39:37 +0200
Received: from mikael by skinner.hem.za.org with local (Exim 4.50)
	id 1DXgkr-0003YD-4Q
	for alsa-devel@alsa-project.org; Mon, 16 May 2005 16:39:37 +0200
Content-Disposition: inline
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

ld10k1_configure.patch
ld10k1_makefile.patch
Removes ALSA_CFLAGS and ALSA_LIBS in configure.in, they are added to
CFLAGS and LDADD in src/Makefile.am already. Adds "-Wall" to CFLAGS only
if CFLAGS is undefined.

qlo10k1_configure.patch
qlo10k1_makefile.patch
Adds LD10K1_CFLAGS and LD10K1_LDFLAGS in src/Makefile.am, and moves
QT_CXXFLAGS to the makefile.

qlo10k1_acinclude.patch
Fixes pattern in gw_CHECK_QT not to match files that the linker won't
use, for example libqt.so.3 . Needed if both libqt and libqt-mt shared
libraries are installed, but only the libqt-mt development library.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
