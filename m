From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Cross compiling alsa-utils
Date: Sun, 31 Aug 2003 11:17:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308311117.39079.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA05650
	for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2003 12:17:29 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Apologies to anyone who has read this within the bowels of the thread abo=
ut=20
building alsa-lib as cross compiled static library.

Actually, I have been able to compile and install static versions of the=20
alsa-libs, though I am finding it next to impossible to configure the=20
alsa-utils for cross compiling - if anybody knows how to do that, I would=
=20
welcome advice: this is what I am getting now...


[Adrian@landslide alsa-utils-0.9.6]$ CC=3Dsh-linux-gcc ./configure=20
--enable-shared=3Dno --enable-static=3Dyes --host=3Dsh-linux=20
--prefix=3D/home/Adrian/dc-down/initrd=20
--includedir=3D/home/Adrian/_alsa-lib-0.9.6.tar.bz2/alsa-lib-0.9.6/includ=
e
configure: WARNING: If you wanted to set the --build type, don't use --ho=
st.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for mawk... no
checking for gawk... gawk
checking whether make sets ${MAKE}... yes
checking for sh-linux-gcc... sh-linux-gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for executable suffix...
checking for object suffix... o
checking whether we are using the GNU C compiler... yes
checking whether sh-linux-gcc accepts -g... yes
checking for style of include used by make... GNU
checking dependency style of sh-linux-gcc... gcc3
checking for a BSD compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >=3D 0.9.0... not present.
configure: error: Sufficiently new version of libasound not found.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
