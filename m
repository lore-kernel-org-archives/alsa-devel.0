From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: als4000 compile error in alsa-driver CVS
Date: Wed, 23 Mar 2005 07:09:09 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6BD@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 036A029A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 01:14:18 +0100 (MET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I got it updated but still got following error, should I also need to =
update kernel source? My kernel is 2.6.9-1.667 (Fedora Core 3)

  CC [M]  /home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.o
In file included from =
/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.c:1:
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
03:63: macro "gameport_set_phys" passed 3 arguments, but takes just 2
In file included from =
/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.c:1:
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c: =
In function `snd_als4000_create_gameport':
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
03: error: `gameport_set_phys' undeclared (first use in this function)
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
03: error: (Each undeclared identifier is reported only once
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:6=
03: error: for each function it appears in.)
make[4]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.o] =
Error 1
make[3]: *** [/home/cltien/work/alsa-cvs/alsa-driver/pci] Error 2
make[2]: *** [_module_/home/cltien/work/alsa-cvs/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/lib/modules/2.6.9-1.667/build'
make: *** [compile] Error 2

Sincerly,
ChenLi Tien

-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/3/22 [=ACP=B4=C1=A4G] =A4U=A4=C8 03:46
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@alsa-project.org
Subject:	Re: [Alsa-devel] als4000 compile error in alsa-driver CVS
At Wed, 23 Mar 2005 03:21:29 +0800,
Tien, C.L. wrote:
>=20
> Hi,
>=20
> Since I cannot use --with-cards to skip card that I don't have, I got =
following compile error for alsa-driver CVS tree:
>=20
> make -C /lib/modules/2.6.9-1.667/source =
SUBDIRS=3D/home/cltien/work/alsa-cvs/alsa-driver =
O=3D/lib/modules/2.6.9-1.667/build modules
> make[1]: Entering directory `/lib/modules/2.6.9-1.667/build'
>   CC [M]  /home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.o
> In file included from =
/home/cltien/work/alsa-cvs/alsa-driver/pci/als4000.c:1:
> =
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c: =
In function `snd_als4000_create_gameport':
> =
/home/cltien/work/alsa-cvs/alsa-driver/pci/../alsa-kernel/pci/als4000.c:5=
94: warning: implicit declaration of function `gameport_allocate_port'
(snip)

This was due to the merge of the latest gameport patch, which has
incompatibility with older kernels.
It's already fixed on CVS.  Please update again after sf's tree gets
sync'ed.


Takashi


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application =
Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or =
Smartphones
for the chance to win $25,000 and application distribution. Enter today =
at
http://ads.osdn.com/?ad_id=3D6882&alloc_id=3D15148&op=3Dclick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
