From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Can anyone help?
Date: Mon, 13 Feb 2006 00:04:00 +0000
Message-ID: <1139789040.10187.18.camel@localhost.localdomain>
References: <1139526455.9296.5.camel@localhost.localdomain>
	 <1139527169.30058.130.camel@mindpipe>
	 <1139528032.9296.8.camel@localhost.localdomain>
	 <1139528366.30058.133.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7A1E91C9
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 01:04:16 +0100 (MET)
In-Reply-To: <1139528366.30058.133.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 18:39 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 23:33 +0000, Adrian McMenamin wrote:
> > 
> > There are no setup files, but the wiki says that aplay -D hw:0,0 ought
> > to get round that anyway. have I misunderstood that? 
> 
> Do you mean you have nothing under /usr/share/alsa?  You should try
> installing alsa-lib and see what happens. The ALSA wikis are full of bad
> information.
> 
> Lee
> 

I have done this now - build and installed the library again: configured
thus:

CC=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
LDFLAGS=-L/tftpboot/192.168.61.55/lib ./configure --host=sh4-linux
--with-debug=yes --prefix=/tftpboot/192.168.61.55/usr

Unfortunately the install fails towards the end (this is being linked
against uclibc rather than glibc) - (see below - though )

But the basic problem remains the same:

/lib # aplay -L
aplay: pcm_list:280: snd_config_updte: Invalid argument
/lib # aplay -L
aplay: pcm_list:280: snd_config_update: Invalid argument
/lib # aplay -D hw:0,0
aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
Aborted


Though I have a populated /usr/share/alsa directory on the target
machine now... have I missed something?

Thanks for all the help.

Adrian



Install output...


/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
-shared  .libs/sbase.o  -Wl,--rpath -Wl,/tftpboot/192.168.61.55/usr/lib
-L/tftpboot/192.168.61.55/lib -L/tftpboot/192.168.61.55/usr/lib -lasound
-Wl,-soname -Wl,smixer-sbase.so -o .libs/smixer-sbase.so
/home/adrian/buildroot/build_sh4/staging_dir/lib/gcc/sh4-linux-uclibc/3.4.2/../../../../sh4-linux-uclibc/bin/ld: cannot find /lib/libc.so.0
collect2: ld returned 1 exit status
libtool: install: error: relink `smixer-sbase.la' with the above command
before installing it
 /bin/sh ../../../libtool --mode=install /usr/bin/install -c
smixer-ac97.la /tftpboot/192.168.61.55/usr/lib/alsa-lib/smixer/smixer-ac97.la
libtool: install: warning: relinking `smixer-ac97.la'
(cd /home/adrian/alsa-lib-1.0.10/modules/mixer/simple; /bin/sh ../../../libtool --mode=relink /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc -g -O2 -W -Wall -g -O2 -L/tftpboot/192.168.61.55/lib -o smixer-ac97.la -rpath /tftpboot/192.168.61.55/usr/lib/alsa-lib/smixer -module -avoid-version ac97.lo sbasedl.lo ../../../src/libasound.la )
/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
-shared  .libs/ac97.o .libs/sbasedl.o  -Wl,--rpath
-Wl,/tftpboot/192.168.61.55/usr/lib -L/tftpboot/192.168.61.55/lib
-L/tftpboot/192.168.61.55/usr/lib -lasound  -Wl,-soname
-Wl,smixer-ac97.so -o .libs/smixer-ac97.so
/home/adrian/buildroot/build_sh4/staging_dir/lib/gcc/sh4-linux-uclibc/3.4.2/../../../../sh4-linux-uclibc/bin/ld: cannot find /lib/libc.so.0
collect2: ld returned 1 exit status
libtool: install: error: relink `smixer-ac97.la' with the above command
before installing it
 /bin/sh ../../../libtool --mode=install /usr/bin/install -c
smixer-hda.la /tftpboot/192.168.61.55/usr/lib/alsa-lib/smixer/smixer-hda.la
libtool: install: warning: relinking `smixer-hda.la'
(cd /home/adrian/alsa-lib-1.0.10/modules/mixer/simple; /bin/sh ../../../libtool --mode=relink /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc -g -O2 -W -Wall -g -O2 -L/tftpboot/192.168.61.55/lib -o smixer-hda.la -rpath /tftpboot/192.168.61.55/usr/lib/alsa-lib/smixer -module -avoid-version hda.lo sbasedl.lo ../../../src/libasound.la )
/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
-shared  .libs/hda.o .libs/sbasedl.o  -Wl,--rpath
-Wl,/tftpboot/192.168.61.55/usr/lib -L/tftpboot/192.168.61.55/lib
-L/tftpboot/192.168.61.55/usr/lib -lasound  -Wl,-soname
-Wl,smixer-hda.so -o .libs/smixer-hda.so
/home/adrian/buildroot/build_sh4/staging_dir/lib/gcc/sh4-linux-uclibc/3.4.2/../../../../sh4-linux-uclibc/bin/ld: cannot find /lib/libc.so.0
collect2: ld returned 1 exit status
libtool: install: error: relink `smixer-hda.la' with the above command
before installing it
make[4]: *** [install-pkglibLTLIBRARIES] Error 1
make[4]: Leaving directory
`/home/adrian/alsa-lib-1.0.10/modules/mixer/simple'
make[3]: *** [install-am] Error 2
make[3]: Leaving directory
`/home/adrian/alsa-lib-1.0.10/modules/mixer/simple'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory `/home/adrian/alsa-lib-1.0.10/modules/mixer'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/home/adrian/alsa-lib-1.0.10/modules'
make: *** [install-recursive] Error 1


NB the /lib directory on the target box is like this...

/lib # ls -l
drwxr-xr-x    2 root     root         4096 Jan 2:34 firmware
-rwsr-xr-x    1 root     root        17204 Jan 28 23:11
ld-uClibc-0.9.28.so
lrwxrwxrwx    1 root     root           19 Jan 28 23:11 ld-uClibc.so.0
-> ld-uClibc-0.9.28.so
-rw-r--r--    1 root     root        76028 Jan 28 23:11 libbusybox.so
lrwxrwxrwx    1 root     root           9 Jan 28 23:11 libbusybox.so.1
-> libbusybox.so.1.1.1
-rw-r--r--    1 root     root        76028 Jan 28 23:11
libbusybox.so.1.1
-rw-r--r--    1 root     root        76028 Jan 28 23:11
libbusybox.so.1.1.1
lrwxrwxrwx    1 root     root           19 Jan 28 23:11 libc.so.0 ->
libuClibc-0.9.28.so
-rw-r--r--    1 root     root         8888 Jan 28 23:11
libcrypt-0.9.28.so
lrwxrwxrwx    1 root     root           18 Jan 28 23:11 libcrypt.so.0 ->
libcrypt-0.9.28.so
-rw-r--r--    1 root     root         9036 Jan 28 23:11 libdl-0.9.28.so
lrwxrwxrwx    1 root     root           15 Jan 28 23:11 libdl.so.0 ->
libdl-0.9.28.so
lrwxrwxrwx    1 root     root           13 Jan 28 23:11 libgcc_s.so ->
libgcc_s.so.1
-rw-r--r--    1 root     root        62104 Jan 28 23:11 libgcc_s.so.1
-rw-r--r--    1 root     root        54136 Jan 28 23:11 libm-0.9.28.so
lrwxrwxrwx    1 root     root           14 Jan 28 23:11 libm.so.0 ->
libm-0.9.28.so
lrwxrwxrwx    1 root     root           15 Jan 28 23:11 libncurses.so ->
libncurses.so.5
lrwxrwxrwx    1 root     root           17 Jan 28 23:11 libncurses.so.5
-> libncurses.so.5.5
-rw-r--r--    1 root     root       271140 Jan 28 23:11
libncurses.so.5.5
-rw-r--r--    1 root     root         4784 Jan 28 23:11 libnsl-0.9.28.so
lrwxrwxrwx    1 root     root           16 Jan 28 23:11 libnsl.so.0 ->
libnsl-0.9.28.so
-rw-r--r--    1 root     root        73951 Jan 28 23:11
libpthread-0.9.28.so
lrwxrwxrwx    1 root     root           20 Jan 28 23:11 libpthread.so.0
-> libpthread-0.9.28.so
-rw-r--r--    1 root     root         4788 Jan 28 23:11
libresolv-0.9.28.so
lrwxrwxrwx    1 root     root           19 Jan 28 23:11 libresolv.so.0
-> libresolv-0.9.28.so
-rw-r--r--    1 root     root         4732 Jan 28 23:11 lirt-0.9.28.so
lrwxrwxrwx    1 root     root           15 Jan 28 23:11 librt.so.0 ->
librt-0.9.28.so
-rw-r--r--    1 root     ro        13076 Jan 28 23:11
libthread_db-0.9.28.so
lrwxrwxrwx    1 root     root         22 Jan 28 23:11 libthread_db.so.1
-> libthread_db-0.9.28.so
-rw-r--r--    1 root     root       289544 Jan 28 23:11
libuClibc-0.9.28.so
-rw-r--r--    1 root     root         4860 Jan 28 23:11
libutil-0.9.28.so
lrwxrwxrwx    1 root     root           17 Jan 28 23:11 libutil.so.0 ->
libutil-0.9.28.so
lrwxrwxrwx    1 root     root           13 Jan 28 23:11 libz.so ->
libz.so.1.2.3
lrwxrwxrwx    1 root     root           13 Jan 28 23:11 libz.so.1 ->
libz.so.1.2.3
-rw-r--r--    1 root     root        59276 Jan 28 23:11 libz.so.1.2.3
drwxr-xr-x    4 root     root         4096 Feb  7 21:37 modules





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
