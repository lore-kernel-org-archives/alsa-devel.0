From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH 3/3] Define _GNU_SOURCE so that <fcntl.h>
 gives O_CLOEXEC
Date: Sun, 8 Nov 2009 15:49:37 +0100
Message-ID: <20091108144936.GA25366@tango.0pointer.de>
References: <200911052116.53251.remi@remlab.net>
	<1257448662-5124-3-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D9A8B244C0
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 15:50:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257448662-5124-3-git-send-email-remi@remlab.net>
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

On Thu, 05.11.09 21:17, R=E9mi Denis-Courmont (remi@remlab.net) wrote:

> Signed-off-by: R=E9mi Denis-Courmont <remi@remlab.net>
> ---
>  configure.in |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/configure.in b/configure.in
> index a455de1..cc8950f 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -38,6 +38,8 @@ then
>    AC_MSG_RESULT($CC)
>  fi
>  	    =

> +CFLAGS=3D"$CFLAGS -D_GNU_SOURCE"

There's acually an autoconf macro for this. AC_GNU_SOURCE. And even
better than that is usually AC_SYSTEM_EXTENSIONS.

Lennart

-- =

Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
