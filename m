From: brett-alsa@kavi.com
Subject: powermac build fails
Date: Tue, 24 Sep 2002 16:16:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020924231609.GC3369@debian>
Reply-To: brett-alsa@kavi.com
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm trying to compile alsa 0.9rc3 on a Powerbook G4 DVI against
2.4.20-pre7 + benh patches, I get an error:

../alsa-kernel/ppc/burgundy.c:314: warning: (near initialization for `snd_pmac_b
urgundy_mixers[1]')
../alsa-kernel/ppc/burgundy.c:314: incompatible types in initialization
../alsa-kernel/ppc/burgundy.c:314: initializer element is not constant
../alsa-kernel/ppc/burgundy.c:314: (near initialization for `snd_pmac_burgundy_m
ixers[1].iface')
../alsa-kernel/ppc/burgundy.c: In function `snd_pmac_burgundy_init':
../alsa-kernel/ppc/burgundy.c:416: `snd_pmac_burgundy_master_sw'
undeclared (fir
st use in this function)
../alsa-kernel/ppc/burgundy.c:416: (Each undeclared identifier is
reported only 
once
../alsa-kernel/ppc/burgundy.c:416: for each function it appears in.)
../alsa-kernel/ppc/burgundy.c:419: `snd_pmac_burgundy_speaker_sw'
undeclared (fi
rst use in this function)
burgundy.c: At top level:
../alsa-kernel/ppc/burgundy.c:433: warning: This file contains more `{'s
than `}
's.
make[4]: *** [burgundy.o] Error 1
make[4]: Leaving directory `/usr/src/modules/alsa-driver/ppc'
make[3]: *** [compile] Error 1
make[3]: Leaving directory `/usr/src/modules/alsa-driver'
make[2]: *** [install-modules] Error 2
make[2]: Leaving directory `/usr/src/modules/alsa-driver'
make[1]: *** [kdist_image] Error 2
make[1]: Leaving directory `/usr/src/modules/alsa-driver'
Module /usr/src/modules/alsa-driver failed.


Thanks, 
-Brett




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
