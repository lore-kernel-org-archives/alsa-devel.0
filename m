From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: als4000 compile error in alsa-driver CVS
Date: Wed, 23 Mar 2005 03:21:29 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6BA@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1E9FF287
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 20:57:54 +0100 (MET)
Content-Class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Since I cannot use --with-cards to skip card that I don't have, I got =
following compile error for alsa-driver CVS tree:

make -C /lib/modules/2.6.9-1.667/source =
SUBDIRS=3D/home/cltien/work/alsa-cvs/alsa-driver =
O=3D/lib/modules/2.6.9-1.667/build modules
make[1]: Entering directory `/lib/modules/2.6.9-1.667/build'
  CC [M]  /home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.o
In file included from =
/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.c:1:
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c: =
In function `snd_als4000_create_gameport':
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:5=
94: warning: implicit declaration of function `gameport_allocate_port'
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:5=
94: warning: assignment makes pointer from integer without a cast
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
02: warning: implicit declaration of function `gameport_set_name'
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
03: warning: implicit declaration of function `gameport_set_phys'
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
04: error: request for member `parent' in something not a structure or =
union
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
06: error: structure has no member named `port_data'
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c: =
In function `snd_als4000_free_gameport':
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
19: error: structure has no member named `port_data'
make[4]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.o] =
Error 1
make[3]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci] Error 2
make[2]: *** [_module_/home/cltien/work/alsa-cvs/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/lib/modules/2.6.9-1.667/build'
make: *** [compile] Error 2

I don't know if it is good in 1.0.9rc1. I use --with-cards to omit the =
other cards before today.

Sincerely,
ChenLi Tien


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
