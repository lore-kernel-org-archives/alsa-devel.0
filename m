From: Andrei Boros <andrei@srr.ro>
Subject: alsa-lib linking problem
Date: Mon, 10 Mar 2003 13:26:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6C7668.63989415@srr.ro>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 Latest cvs alsa-lib compiles ok up to a point where the linker fails on
a library:

gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo
dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al
mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al
timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al
instr/.libs/libinstr.al compat/.libs/libcompat.al
-Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname
-Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/i386-slackware-linux/bin/ld: .libs/libasound.so.2.0.0: undefined
versioned symbol name snd_pcm_forward@@ALSA_0.9.0rc8
/usr/i386-slackware-linux/bin/ld: failed to set dynamic section sizes:
Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
make: *** [all-recursive] Error 1




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
