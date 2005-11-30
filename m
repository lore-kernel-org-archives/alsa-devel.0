From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: More on compiling alsa-lib with uclibc
Date: Wed, 30 Nov 2005 23:06:53 +0000
Message-ID: <1133392013.9033.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8A48A17A
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2005 00:06:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org, uClibc@uclibc.org
List-Id: alsa-devel@alsa-project.org

I have worked through the source files patching them as I go, but now
have a linker problem (this is a ia32 to sh4 cross compile). I will post
a patch shortly to both lists that fixes all the compile problems - but
not this linker issue...

Can someone offer me guidance as to what is wrong below?


fi
/bin/sh ../libtool
--mode=link /home/adrian/buildroot/build_sh4/staging_dir/sh4-linux-uclibc/bin/gcc  -g -O2   -o aserver  aserver.o ../src/libasound.la
mkdir .libs
/home/adrian/buildroot/build_sh4/staging_dir/sh4-linux-uclibc/bin/gcc -g
-O2 -o aserver aserver.o  ../src/.libs/libasound.a -lm -ldl -lpthread
/home/adrian/buildroot/build_sh4/staging_dir/sh4-linux-uclibc/bin/../lib/gcc/sh4-linux-uclibc/3.4.2/../../../../sh4-linux-uclibc/bin/ld: cannot find -lpthread
collect2: ld returned 1 exit status
make[1]: *** [aserver] Error 1
make[1]: Leaving directory `/home/adrian/alsa-lib-1.0.10/aserver'
make: *** [all-recursive] Error 1




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
