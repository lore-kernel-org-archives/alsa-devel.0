From: Dennis van der Meer <dvdmeer@wanadoo.nl>
Subject: Compile errors with current cvs
Date: Thu, 19 Jun 2003 20:55:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030619205332.01e2f670@192.168.10.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hi,

When trying to compile the latest cvs version I got the following errors:

In file included from ac97_codec.c:1:
../../alsa-kernel/pci/ac97/ac97_codec.c: In function `snd_ac97_mixer_build':
../../alsa-kernel/pci/ac97/ac97_codec.c:1394: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1394: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1395: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1417: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1417: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1418: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1424: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1424: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1425: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1436: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1436: structure has no member named 
`build_ops'
../../alsa-kernel/pci/ac97/ac97_codec.c:1437: structure has no member named 
`build_ops'
make[3]: *** [ac97_codec.o] Error 1
make[2]: *** [_modsubdir_ac97] Error 2
make[1]: *** [compile] Error 1
install: cannot create regular file `/sbin/init.d/alsasound': No such file 
or directory
cp: cannot stat `snd-ac97-codec.o': No such file or directory
cp: cannot stat `snd-ak4531-codec.o': No such file or directory
make[3]: *** [_modinst__] Error 1
make[2]: *** [_modinst_ac97] Error 2
make[1]: *** [install-modules] Error 1
make: *** [build] Error 2

Anyone has an clue what could be wrong??


Dennis



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
