From: bill@tellytopia.com
Subject: =?utf-8?q?Maybe_the_build_script_for_Alsa_Libs_does_?=
 =?utf-8?q?not_properly_install_for_64-bit_systems=3F_=28alsa-lib-1=2E0=2E?=
 =?utf-8?b?MjAudGFyLmJ6Mik=?=
Date: Sat, 13 Jun 2009 01:41:23 -0700
Message-ID: <20090613014123.511367190d6e5c5c661eac68a9a86d95.b467934777.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpoutwbe09.prod.mesa1.secureserver.net
	(smtpoutwbe09.prod.mesa1.secureserver.net [208.109.78.21])
	by alsa0.perex.cz (Postfix) with SMTP id 397F424366
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 10:41:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Maybe the build script for Alsa Libs does not properly install for
64-bit systems? (alsa-lib-1.0.20.tar.bz2)

Built alsa-lib and did make install;
built alsa-driver and did make install;
tried to build alsa-utils and found
Compile errors when building on a 64-bit platform in Fedora Core 9.
Notice the old date on /lib64/libasound.so.2.0.0:
[root@localhost alsa]# ls -l /lib64/libasound*
lrwxrwxrwx 1 root root     18 2009-06-12 14:29 /lib64/libasound.so.2 ->
libasound.so.2.0.0
-rwxr-xr-x 1 root root 920640 2008-04-04 01:26 /lib64/libasound.so.2.0.0
[root@localhost alsa]# ls -l /usr/lib/libasound*
-rwxr-xr-x 1 root root     813 2009-06-12 17:02 /usr/lib/libasound.la
lrwxrwxrwx 1 root root      18 2009-06-12 17:02 /usr/lib/libasound.so ->
libasound.so.2.0.0
lrwxrwxrwx 1 root root      18 2009-06-12 17:02 /usr/lib/libasound.so.2
-> libasound.so.2.0.0
-rwxr-xr-x 1 root root 3544926 2009-06-12 17:02
/usr/lib/libasound.so.2.0.0

Here is the system this is built on:
[root@localhost alsa-utils-1.0.20]# uname -a
Linux localhost.localdomain 2.6.25-14.fc9.x86_64 #1 SMP Thu May 1
06:06:21 EDT 2008 x86_64 x86_64 x86_64 GNU/Linux

Here is the error when compiling utils:
---------------------------------------
make[1]: Entering directory `/root/Desktop/alsa/alsa-utils-1.0.20/aplay'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -g -O2 -MT
aplay.o -MD -MP -MF ".deps/aplay.Tpo" -c -o aplay.o aplay.c; \
        then mv -f ".deps/aplay.Tpo" ".deps/aplay.Po"; else rm -f
".deps/aplay.Tpo"; exit 1; fi
gcc  -g -O2   -o aplay  aplay.o  -lrt -lasound -lm -ldl -lpthread
aplay.o: In function `set_params':
/root/Desktop/alsa/alsa-utils-1.0.20/aplay/aplay.c:1038: undefined
reference to `snd_pcm_hw_params_is_monotonic'
aplay.o: In function `do_test_position':
/root/Desktop/alsa/alsa-utils-1.0.20/aplay/aplay.c:1455: undefined
reference to `snd_pcm_avail_delay'
collect2: ld returned 1 exit status
make[1]: *** [aplay] Error 1
make[1]: Leaving directory `/root/Desktop/alsa/alsa-utils-1.0.20/aplay'
make: *** [all-recursive] Error 1
[root@localhost alsa-utils-1.0.20]#

So then link the /lib64 libraries to the /usr/lib equivalents and cross
fingers:
[root@localhost lib64]# ls -l libasound*
lrwxrwxrwx 1 root root     27 2009-06-13 01:25 libasound.2.0.0 ->
/usr/lib/libasound.so.2.0.0
lrwxrwxrwx 1 root root     27 2009-06-13 01:26 libasound.so.2 ->
/usr/lib/libasound.so.2.0.0
-rwxr-xr-x 1 root root 923208 2008-04-04 01:26
libasound.so.2.0.0-original

Then compile utils again. No compile errors.
So the compile gave no errors when the "old" /lib64/libasound.so.2 was
not used, and the /usr/lib/libasound.so.2 was used instead.

Does this mean that the build script for alsa-lib-1.0.20 did not put in
the correct library? Or what?

Thanks for thoughtful responses.
Bill
