From: Mysth-R <mysthr21@gmail.com>
Subject: : Can't compile alsa-driver-1.0.18a on x86_64 arch
Date: Mon, 15 Dec 2008 08:57:40 +0100
Message-ID: <907c05c70812142357j6cd420ccj10940671d3a14946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id DC4491037F6
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 08:57:41 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2373640rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 23:57:40 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to compile the lastest alsa-driver, but I got an error :

patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
Hunk #11 succeeded at 1057 (offset 1 line).
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
make[3]: quittant le r=E9pertoire =AB
/home/mysthr2/Logiciels/musique/alsa-driver-1.0.18a/usb/usx2y =BB
make[2]: quittant le r=E9pertoire =AB
/home/mysthr2/Logiciels/musique/alsa-driver-1.0.18a/usb =BB
make[1]: quittant le r=E9pertoire =AB
/home/mysthr2/Logiciels/musique/alsa-driver-1.0.18a =BB
make -C /lib/modules/2.6.24.7-rt7/build
SUBDIRS=3D/home/mysthr2/Logiciels/musique/alsa-driver-1.0.18a CPP=3D"gcc -E"
CC=3D"gcc" modules
make[1]: entrant dans le r=E9pertoire =AB /usr/src/linux-2.6.24.7-rt7 =BB
Makefile:510: /usr/src/linux-2.6.24.7-rt7/arch/x86/Makefile: Aucun fichier
ou dossier de ce type
make[1]: *** Pas de r=E8gle pour fabriquer la cible =AB
/usr/src/linux-2.6.24.7-rt7/arch/x86/Makefile =BB. Arr=EAt.
make[1]: quittant le r=E9pertoire =AB /usr/src/linux-2.6.24.7-rt7 =BB
make: *** [compile] Erreur 2

Here is my ./configure :

 ./configure --prefix=3D/usr --with-cards=3Dhda-intel usb-caiaq usb-audio
hrtimer rtctimer hpet --with-sequencer=3Dyes --with-card-options=3Dall
--with-oss=3Dno--with-kernel=3D/usr/src/linux-2.6.24.7-rt7/
CFLAGS=3D"-march=3Dnocona -pipe -O2"

Thank you for your help !

cheers,

Mysth-R

-- =

*
***************************************************************************=
************
*  {^_^} Mysth-R {^_^}
*  <=3D Aide Auditive =3D>
*
* http://myspace.com/mysthr
* http://myspace.com/aideauditive
* http://mysthr.free.fr/Joomla  =3D> Site d=E9di=E9 =E0 l'audio sous
Fedora/PlanetCCRMA.
*
***************************************************************************=
************
