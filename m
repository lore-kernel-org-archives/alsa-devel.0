From: Martin Langer <martin-langer@gmx.de>
Subject: debian and awk
Date: Mon, 15 Sep 2003 21:13:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030915191359.GA524@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

gcc -E -C -D__KERNEL__ -DMODULE=1
-I/usr/local/src/alsa-cvs/alsa-driver/include
-I/lib/modules/2.4.19-rc1/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD  -D__isapnp_now__ -DKBUILD_BASENAME=als100   als100.c |
/usr/local/src/alsa-cvs/alsa-driver/utils/convert_isapnp_ids > als100.isapnp
/bin/sh: /usr/local/src/alsa-cvs/alsa-driver/utils/convert_isapnp_ids:
/bin/awk: bad interpreter: No such file or directory

debian is different: 
/usr/bin/awk is needed instead of /bin/awk 


martin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
