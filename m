From: Allan Klinbail <allank@labyrinth.net.au>
Subject: can't compile CVS after fresh system install
Date: 17 Feb 2003 15:22:07 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045455722.13170.13.camel@littlewolf2.littlewolf>
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
To: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi 

To try and resolve some of my autogen/automake issues  I re-installed my
system to start afresh... 

Just before I did though I downloaded CVS to test the new mtpav driver..
the installation went fine.. BUt now I'm having trouble.. 

The driver itself seemed to compile and install properly but something
seems to have gone missing.. neither jack nor alsa-lib will compile at
this point 

alsa-lib configures okay but then ... (this happens on make)  

  ibs/libpcm.al rawmidi/.libs/librawmidi.al timer/.libs/libtimer.al
hwdep/.libs/libhwdep.al seq/.libs/libseq.al instr/.libs/libinstr.al
compat/.libs/libcompat.al -lm -ldl -lpthread          
-Wl,--version-script=Versions -Wl,-soname -Wl,libasound.so.2 -o
.libs/libasound.so.2.0.0
gcc: pcm/.libs/libpcm.al: No such file or directory
gcc: pcm/.libs/libpcm.al: No such file or directory
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/usr/local/audio/cvs/alsa/alsa-lib/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/local/audio/cvs/alsa/alsa-lib/src'
make: *** [all-recursive] Error 1

Jack (both CVS and release 0.34) complain that I don't have ALSA 0.9.X
on the system.)

I am running a freshly insalled Mandrake 9.0 with linux-2.4.20 (real
time and capabilities patches implemented). I have removed all packaged
versions of alsa from the system. 


cheers

Allan Klinbail 










-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
