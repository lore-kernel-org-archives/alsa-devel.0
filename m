From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Cross compiling alsa-utils
Date: Sun, 31 Aug 2003 13:18:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308311318.56876.adrian@mcmen.demon.co.uk>
References: <200308311117.39079.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA07387
	for <alsa-devel@alsa-project.org>; Sun, 31 Aug 2003 14:18:47 +0200
In-Reply-To: <200308311117.39079.adrian@mcmen.demon.co.uk>
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

On Sunday 31 August 2003 11:17, Adrian McMenamin wrote:
> Apologies to anyone who has read this within the bowels of the thread a=
bout
> building alsa-lib as cross compiled static library.
>
> Actually, I have been able to compile and install static versions of th=
e
> alsa-libs, though I am finding it next to impossible to configure the
> alsa-utils for cross compiling -

Fixed this, apologies for wasting bandwidth:

CC=3Dsh-linux-gcc ./configure --enable-shared=3Dno --enable-static=3Dyes=20
--host=3Dsh-linux --prefix=3D/home/Adrian/dc-down/initrd/usr=20
--with-alsa-prefix=3D/home/Adrian/dc-down/initrd/usr/lib=20
--with-alsa-inc-prefix=3D/home/Adrian/dc-down/initrd/usr/include=20
--disable-alsamixer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
