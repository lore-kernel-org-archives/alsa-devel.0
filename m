From: Martin Langer <martin-langer@gmx.de>
Subject: cmipci problem
Date: Fri, 3 Jan 2003 13:06:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030103120627.GA12651@tuba.home>
Reply-To: martin-langer@gmx.de
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

cmipci.c doesn't compile .... using CVS from today.
Hmm, "global_list" is a little bit strange there I think ....

bye,
martin



In file included from cmipci.c:1:
../alsa-kernel/pci/cmipci.c: In function snd_cmipci_create':
../alsa-kernel/pci/cmipci.c:2957: warning: assignment from incompatible
pointer type
../alsa-kernel/pci/cmipci.c:2957: warning: comparison of distinct pointer
types lacks a cast
../alsa-kernel/pci/cmipci.c:2957: structure has no member named global_list'
make[2]: *** [cmipci.o] Error 1
make[2]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver/pci'
make[1]: *** [compile] Error 1
make[1]: Leaving directory /usr/local/src/alsa-cvs/alsa-driver'
make: *** [build] Error 2


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
