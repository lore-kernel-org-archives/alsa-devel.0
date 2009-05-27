From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#529940: lib32asound2: symbol
	versioning	changed in an incompatible way
Date: Wed, 27 May 2009 23:48:56 +0200
Message-ID: <20090527214856.GB3549@aragorn.home.lxtec.de>
References: <20090527115302.GA16925@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 19F092444A
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 23:49:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090527115302.GA16925@chistera.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 529940@bugs.debian.org, Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>, Jordi Mallach <jordi@debian.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, debian-powerpc <debian-powerpc@lists.debian.org>, control@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

tags 529940 pending
forwarded 529940 alsa-devel@alsa-project.org
thanks

* Adeodato Sim=F3 [090527 13:53 +0200]
> severity 529940 serious
> retitle 529940 lib32asound2: symbol versioning changed in an incompatible=
 way (ALSA_0.9.0rc4/8 dropped)
> thanks
> =

> Hello,
> =

> it seems that between 1.0.19-1 and 1.0.20-1 the list of symbols in
> lib32asound2 changed. More precisely, the list of symbols remained but
> their associated versioning changed: all symbols associated with
> ALSA_0.9.0rc4 and ALSA_0.9.0rc8 were changed to live under ALSA_0.9
> instead, making applications compiled against <=3D 1.0.19 fail to start
> due to missing symbols.
> =

> Note that this problem affects the 32-bit library in amd64, but not the
> native libraries nor in i386 nor amd64.

Don't we have to verify it at ppc64 as well? CC'd to debian-ppc.

> =

> Also note that we've started having applications like WINE 1.1.19 in
> experimental rebuilt against 1.0.20, and which don't work against
> alsa-lib 1.0.19 either. And we'll have no easy way to detect these,
> since shlibs are not bumped.
> =

> Will you be able to upload fixed packages in a timely manner?

According to [0] I created svn version 2249 on alioth [1]. I've tested
it on amd64, were rc4 symbols appeared by checking via readelf. But
maybe alsa-devel rechecks the buildsystem of alsa-libs to avoid that
dirty hacks? --with-versioned appended to ./configure opts didn't
help.

[0] http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April/016083.=
html
[1] http://svn.debian.org/wsvn/pkg-alsa/?op=3Dcomp&compare[]=3D%2F@2248&com=
pare[]=3D%2F@2249

Jordi, please recheck and upload.

Index: debian/rules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- debian/rules	(Revision 2248)
+++ debian/rules	(Arbeitskopie)
@@ -39,7 +39,7 @@
   endif
 endif
 =

-CFLAGS =3D -g -Wall
+CFLAGS =3D -g -Wall -DUSE_VERSIONED_SYMBOLS
 =

 ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
 	CFLAGS +=3D -O0


-- =

  "Talking much about oneself can also =

   be a means to conceal oneself."
         -Friedrich Nietzsche
