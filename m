From: Giuliano Pochini <pochini@shiny.it>
Subject: Problem compiling for linux 2.6
Date: Thu, 29 Jan 2004 00:14:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040129001416.08a55e76.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


It fails at line #113 of /Makefile :

        @for d in $(SUBDIRS); do if ! $(MAKE) -C $$d prepare; then exit 1; fi; done

I have no idea why $(SUBDIRS) is an empty string:


[Giu@Jay alsa-driver-1.0.2]$ ./cvscompile --with-cards=powermac --with-isapnp=no --with-sequencer=no --with-oss=no --with-kernel=/opt/KernelSrc/l26 --with-debug=full
[...]
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
/bin/sh: -c: line 1: syntax error near unexpected token `;'
/bin/sh: -c: line 1: `for d in   ; do  make -C $d prepare;  done'
make[1]: *** [prepare] Error 2
make[1]: Leaving directory `/home/Giu/soft/alsa-driver-1.0.2/acore'
make: *** [dep] Error 1
[Giu@Jay alsa-driver-1.0.2]$ uname -a
Linux Jay 2.6.2-rc1-ben1 #2 SMP Wed Jan 28 22:19:17 CET 2004 ppc unknown

I'm using ALSA-1.0.2 after it was reuploaded. With linux 2.4 is compile just
fine as usual. I'm using 2.6 for the first time... maybe I forgot to
install/update something. :)


--
Giuliano.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
