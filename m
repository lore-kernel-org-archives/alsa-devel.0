From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_commit asserts
Date: Fri, 11 Jun 2004 12:23:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406111217580.1785@pnote.perex-int.cz>
References: <E1BYj3t-0001eU-00@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BYj3t-0001eU-00@mailer.emlix.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso8859-15?Q?Nicolas_H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jun 2004, Nicolas H=FCppelsh=E4user wrote:

> > > pcm.c:5945: snd_pcm_mmap_commit: Assertion `offset =3D=3D *pcm->appl.=
ptr %
> > > pcm->buffer_size' failed.
> >
> > Did you call snd_pcm_mmap_begin() after xrun recovery again?
>=20
> No I did not.  If I need to it takes me to the following questions:
>=20
> (1) Does this mean in case of an xrun my mmap region got "unmapped"?

It is not valid more.

> (2) Why does my second snd_pcm_mmap_commit call not fail every time then
>     but only "most of the time"?

It's possible. The xrun recovery calls might shift/reset the writing=20
position (appl_ptr).

> (3) The mmap region obtained via the "re-begin" - does it match the regio=
n
>     previously obtained --- is it the same as before?

It's not guaranteed.

> (4) In playback case - do I have to rewrite the data?

After xrun recovery, you start with an empty buffer.

> (5) What happens to the application frame pointer in xrun case?

snd_pcm_prepare() or snd_pcm_drop() sync the appl_ptr to hw_ptr
(thus it can be moved).

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
