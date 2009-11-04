From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH 1/3] Open device nodes with close-on-exec
 flag
Date: Wed, 4 Nov 2009 20:03:11 +0100
Message-ID: <20091104190311.GC17556@tango.0pointer.de>
References: <200911042038.09618.rem@videolan.org>
	<1257359933-3791-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C536910383A
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 20:03:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257359933-3791-1-git-send-email-remi@remlab.net>
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

On Wed, 04.11.09 20:38, R=E9mi Denis-Courmont (remi@remlab.net) wrote:

>  static inline int snd_open_device(const char *filename, int fmode)
>  {
> -	int fd =3D open(filename, fmode);
> +	int fd;
> +
> +#ifdef O_CLOEXEC
> +	fd =3D open(filename, fmode|O_CLOEXEC);
>  	if (fd >=3D 0)
>  		return fd;
> +	if (errno =3D=3D EINVAL)
> +#endif
> +	{
> +		fd =3D open(filename, fmode);
> +		if (fd >=3D 0) {
> +			fcntl(fd, F_SETFD, FD_CLOEXEC);
> +			return fd;
> +		}

That's actually not how things works. O_CLOEXEC is silently ignored by
old kernels. (The calls with SOCK_CLOEXEC fail with EINVAL while the
calls with O_CLOEXEC silently succeed) You need to set
FD_CLOEXEC unconditionally to cover all cases:

fd =3D open(fn, fmode
#ifdef O_CLOEXEC
          |O_CLOEXEC
#endif
);
fcntl(fd, F_SETFD, FD_CLOEXEC);


Lennart

-- =

Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
