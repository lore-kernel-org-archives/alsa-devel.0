From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: alsa-driver-1.0.23 fails to build on ppc
Date: Sat, 29 May 2010 12:16:37 +0200
Message-ID: <20100529101637.GA17139@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id 889EF245B7
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 12:16:51 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

Hi,

preparing alsa-driver-1.0.23 for Debian upload I found while building modules all:

  LD [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/core/snd-aoa.o
  CC [M]  /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.o
In file included from /usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.c:2:
/usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c: In function 'check_codec':
/usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/../../alsa-kernel/aoa/fabrics/layout.c:772: error: 'struct device_node' has no member named 'phandle'
make[8]: *** [/usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics/layout.o] Error 1
make[7]: *** [/usr/src/modass/usr_src/modules/alsa-driver/aoa/fabrics] Error 2
make[6]: *** [/usr/src/modass/usr_src/modules/alsa-driver/aoa] Error 2
make[5]: *** [_module_/usr/src/modass/usr_src/modules/alsa-driver] Error 2
make[4]: *** [sub-make] Error 2
make[3]: *** [all] Error 2

I found no fix in git. I would be glad if someone could give me a hint.

Thanks
Elimar

-- 
  Planung:
  Ersatz des Zufalls durch den Irrtum.
                                -unknown-
