From: Geoff Beasley <songshop@bizmedia.com.au>
Subject: compile error in wine
Date: Sun, 17 Jul 2005 12:44:45 +0000
Message-ID: <1121604285.8251.10.camel@localhost>
References: <20050716204029.53076898E7@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050716204029.53076898E7@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

G'day folks. Trying to build wine 20040505 (and several other releases
as well) on my new gentoo 2.6.12 r4 install using alsa 1.0.9.a I get the
following error:

make[2]: Entering directory
`/home/geoff/wine-20040505/dlls/winmm/winealsa'
gcc -c -I. -I. -I../../../include -I../../../include  -D__WINESRC__
-D_REENTRANT -fPIC -Wall -pipe -mpreferred-stack-boundary=2
-fno-strict-aliasing -gstabs+ -Wpointer-arith  -g -O2 -o audio.o audio.c
In file included from /usr/include/alsa/asoundlib.h:48,
                 from alsa.h:23,
                 from audio.c:59:
/usr/include/alsa/conf.h:189: error: syntax error before "struct"
make[2]: *** [audio.o] Error 1
make[2]: Leaving directory
`/home/geoff/wine-20040505/dlls/winmm/winealsa'
make[1]: *** [winmm/winealsa] Error 2
make[1]: Leaving directory `/home/geoff/wine-20040505/dlls'
make: *** [dlls] Error 2

Compilation failed, aborting install.


Is there something that needs to be edited in /usr/include/alsa/conf.h ?
Is this a wine specific problem ?

thanks for any help !

Cheers,
Geoff.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
