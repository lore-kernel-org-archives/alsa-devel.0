From: GitHub issues - opened <github@alsa-project.org>
Subject: 1.18: alsa-lib build fails with LTO
Date: Sat, 30 Mar 2019 14:48:52 +0100 (CET)
Message-ID: <20190330134852.507EFF89673@alsa1.perex.cz>
References: <1553953728889269114-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B3DD8F8075C
 for <alsa-devel@alsa-project.org>; Sat, 30 Mar 2019 14:48:49 +0100 (CET)
In-Reply-To: <1553953728889269114-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-lib issue #6 was opened from kloczek:

<pre>make[2]: Entering directory &apos;/home/tkloczko/rpmbuild/BUILD/alsa-lib-1.1.8/src&apos;
/bin/sh ../libtool  --tag=CC   --mode=link gcc  -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -flto -version-info 2:0:0 -Wl,--version-script=Versions  -Wl,--no-undefined -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -flto -fuse-linker-plugin -o libasound.la -rpath /usr/lib64 conf.lo confmisc.lo input.lo output.lo async.lo error.lo dlmisc.lo socket.lo shmarea.lo userfile.lo names.lo control/libcontrol.la mixer/libmixer.la pcm/libpcm.la timer/libtimer.la rawmidi/libr
 awmidi.la hwdep/libhwdep.la seq/libseq.la ucm/libucm.la topology/libtopology.la  -lm -ldl -lpthread -lrt 
libtool: link: gcc -shared  -fPIC -DPIC  .libs/conf.o .libs/confmisc.o .libs/input.o .libs/output.o .libs/async.o .libs/error.o .libs/dlmisc.o .libs/socket.o .libs/shmarea.o .libs/userfile.o .libs/names.o  -Wl,--whole-archive control/.libs/libcontrol.a mixer/.libs/libmixer.a pcm/.libs/libpcm.a timer/.libs/libtimer.a rawmidi/.libs/librawmidi.a hwdep/.libs/libhwdep.a seq/.libs/libseq.a ucm/.libs/libucm.a topology/.libs/libtopology.a -Wl,--no-whole-archive -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -O2 -g -fstack-protector-strong -grecord-gcc-switches -m64 -mtune=generic -flto -Wl,--version-script=Versions -Wl,--no-undefined -Wl,-z -Wl,relro -Wl,--as-needed -Wl,-z -Wl,now -flto -fuse-linker-plugin    -lm -ldl -lpthread -lrt -Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.
 0.0
/tmp/ccROQp1D.s: Assembler messages:
/tmp/ccROQp1D.s: Error: invalid attempt to declare external version name as default in symbol `snd_dlopen@@ALSA_1.1.6&apos;
lto-wrapper: fatal error: gcc returned 1 exit status
compilation terminated.
/usr/bin/ld: error: lto-wrapper failed
</pre>

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/6
Repository URL: https://github.com/alsa-project/alsa-lib
