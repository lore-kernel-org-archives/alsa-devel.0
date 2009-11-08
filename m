From: "=?iso-8859-1?q?R=E9mi?= Denis-Courmont" <remi@remlab.net>
Subject: Re: [PATCH 3/3] Define _GNU_SOURCE so that <fcntl.h>
	gives O_CLOEXEC
Date: Sun, 8 Nov 2009 17:23:36 +0200
Message-ID: <200911081723.37763.remi@remlab.net>
References: <200911052116.53251.remi@remlab.net>
	<1257448662-5124-3-git-send-email-remi@remlab.net>
	<20091108144936.GA25366@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id AB26924493
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:23:40 +0100 (CET)
Received: from basile.remlab.net (cs27051160.pp.htv.fi [89.27.51.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: remi)
	by yop.chewa.net (Postfix) with ESMTPSA id 4EF6E7EE
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 16:23:40 +0100 (CET)
In-Reply-To: <20091108144936.GA25366@tango.0pointer.de>
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

Le dimanche 8 novembre 2009 16:49:37 Lennart Poettering, vous avez =E9crit :
> On Thu, 05.11.09 21:17, R=E9mi Denis-Courmont (remi@remlab.net) wrote:
> > Signed-off-by: R=E9mi Denis-Courmont <remi@remlab.net>
> > ---
> >  configure.in |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/configure.in b/configure.in
> > index a455de1..cc8950f 100644
> > --- a/configure.in
> > +++ b/configure.in
> > @@ -38,6 +38,8 @@ then
> >    AC_MSG_RESULT($CC)
> >  fi
> >
> > +CFLAGS=3D"$CFLAGS -D_GNU_SOURCE"
> =

> There's acually an autoconf macro for this. AC_GNU_SOURCE. And even
> better than that is usually AC_SYSTEM_EXTENSIONS.

AC_SYSTEM_EXTENSIONS is not much extra help from AC_GNU_SOURCE in a Linux-o=
nly =

library. alsa-lib does not systematically include <config.h> first, so neit=
her =

of them will work anyway.

I did not dare to make such a big change. We need _GNU_SOURCE before *any* =

system header is included. Hence I added it to C(PP)FLAGS.

-- =

R=E9mi Denis-Courmont
http://www.remlab.net/
