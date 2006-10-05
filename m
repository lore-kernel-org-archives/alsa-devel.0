From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: 2.6.19rc1: pcm_native.c doesn't build
Date: Thu, 5 Oct 2006 22:19:28 +0200
Message-ID: <20061005201928.GD3809@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

I tried to build alsa-driver (sources) 1.0.13 against kernel
2.6.19rc1 on i386. The build stops with:

/usr/bin/make -C /usr/src/linux-2.6.19-rc1 \
SUBDIRS=/usr/src/modules/alsa-driver O=/usr/src/linux-2.6.19-rc1 \
CPP="gcc-4.1 -E" CC="gcc-4.1" modules
make[4]: Entering directory `/usr/src/linux-2.6.19-rc1'
  CC [M]  /usr/src/modules/alsa-driver/acore/pcm_native.o
/usr/src/modules/alsa-driver/acore/pcm_native.c:3569: error: unknown field \
'writev' specified in initializer
/usr/src/modules/alsa-driver/acore/pcm_native.c:3569: warning: \
initialization from incompatible pointer type
/usr/src/modules/alsa-driver/acore/pcm_native.c:3589: error: unknown field \
'readv' specified in initializer
/usr/src/modules/alsa-driver/acore/pcm_native.c:3589: warning: \
initialization from incompatible pointer type

Any hints?

Elimar

-- 
  Do you smell something burning or ist it me?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
