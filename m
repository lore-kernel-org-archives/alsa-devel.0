From: m <m@iriXx.org>
Subject: problems with rc4 alsa-lib
Date: 23 Oct 2002 02:36:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035337002.2871.93.camel@hamish.iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

im afraid i'm still having problems compiling rc4 - although i'm working
with the latest version from the front page of the site now, and not the
cvs.... 
alsa-driver compiled smoothly, but its alsa-lib that im having troubles
with - consequently trying to load modules wont work at the moment, i
assume because i have a conflicting version of alsa-lib (rc3)... 

below is the error im getting - i've upgraded my libalsa2 and
libalsa-data just to be sure i have the latest version of
libasound.so.2.0.0 for my system (Mandrake 8.2)... 

thanks for your help

m


gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo
dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al
mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al
timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al
instr/.libs/libinstr.al compat/.libs/libcompat.al
-Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname
-Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name
snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4
/usr/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/usr/src/alsa/alsa-lib-0.9.0rc4/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-lib-0.9.0rc4/src'
make: *** [all-recursive] Error 1
-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

 _
( )  ascii ribbon against html email
 X
/ \    cat /dev/sda1 > /dev/dsp


  *** stopping make sense ***



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
