From: Andrei Boros <andrei@srr.ro>
Subject: Re: alsa-utils cvscompile
Date: Wed, 24 Sep 2003 14:25:53 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F717F41.8A481DF8@srr.ro>
References: <3F6EBD21.385BE9EA@srr.ro> <s5hd6drr2m4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> > source='alsactl.c' object='alsactl.o' libtool=no \
> > depfile='.deps/alsactl.Po' tmpdepfile='.deps/alsactl.TPo' \
> > depmode=none /bin/sh ../depcomp \
> > gcc -DHAVE_CONFIG_H -I. -I. -I../include     -O2 -Wall -pipe -g -c `test
> > -f alsactl.c || echo './'`alsactl.c
> > gcc  -O2 -Wall -pipe -g   -o alsactl  alsactl.o  -lasound -lm -ldl
> > -lpthread
> > gcc: alsactl.o: No such file or directory
> 
> do you have really alsactl.c?
> or, any system error such as no diskt space, etc?
> 
> anyway i don't see any errors in the alsa-utils side.

gate:~/install/alsa-cvs/alsa-utils/alsactl# pwd
/root/install/alsa-cvs/alsa-utils/alsactl
gate:~/install/alsa-cvs/alsa-utils/alsactl# ls -l
total 72
drwxr-xr-x   2 root     root         4096 Aug  6 13:45 CVS
-rw-r--r--   1 root     root         9983 Sep 22 12:11 Makefile
-rw-r--r--   1 root     root           89 Nov  6  2001 Makefile.am
-rw-r--r--   1 root     root        10258 Sep 22 12:11 Makefile.in
-rw-r--r--   1 root     root         2061 Sep  6  2002 alsactl.1
-rw-r--r--   1 root     root        34727 Jun 20 21:13 alsactl.c
gate:~/install/alsa-cvs/alsa-utils/alsactl#

and 197M free space.

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
