From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: PCI_D0 and PCI_D3hot in atiixp_modem.c not defined in pci.h
Date: Wed, 13 Apr 2005 07:53:07 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB51501E4B074@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6452E254
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 02:28:03 +0200 (MEST)
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

The CVS version of atiixp_modem.c use PCI_D0 and PCI_D3hot. These =
constants are not defined in pci.h before kernel version 2.6.11, compile =
the file will cause compile error as following:

  CC [M]  /home/cltien/work/alsa-cvs/alsa-driver/pci/atiixp_modem.o
In file included from =
/home/cltien/work/alsa-cvs/alsa-driver/pci/atiixp_modem.c:1:
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c: In function `snd_atiixp_suspend':
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c:1124: error: `PCI_D3hot' undeclared (first use in this function)
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c:1124: error: (Each undeclared identifier is reported only once
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c:1124: error: for each function it appears in.)
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c: In function `snd_atiixp_resume':
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/atiixp_mode=
m.c:1135: error: `PCI_D0' undeclared (first use in this function)
make[4]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci/atiixp_modem.o] =
Error 1make[3]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci] Error 2
make[2]: *** [_module_/home/cltien/work/alsa-cvs/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/lib/modules/2.6.9-1.667/build'
make: *** [compile] Error 2

Sincerely,
ChenLi Tien


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
