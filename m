From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Memory leaks in alsa-lib
Date: Tue, 26 Aug 2003 14:33:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308261432320.29234-100000@pnote.perex-int.cz>
References: <yw1xptis1vp4.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xptis1vp4.fsf@users.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Aug 2003, [iso-8859-1] M=E5ns Rullg=E5rd wrote:

> Jaroslav Kysela <perex@suse.cz> writes:
>=20
> >> Is there a memory leak in alsa-lib?  When playing music with a player
> >> I'm writing (TCVP, http://tcvp.sf.net), the memory usage reported by
> >> top grows for each file I play, but only if I use ALSA for sound
> >> playback.  If I use OSS the memory usage varies around 1.5 MB, but if
> >> I use ALSA, it starts at 1.9 MB (OK, libasound takes some space) and
> >> grows by 30-40 kB for each played file.  Running the whole thing under
> >> valgrind gives me this, which is all alsa-related.  When using OSS,
> >> valgrind reports no leaks.
> >
> > I tested aplay with valgrind and I cannot find any leak (except a few=
=20
> > allocations probably from glibc). Note that you have to use=20
> > snd_config_update_free_global() after end of the session to free
>=20
> OK, so what constitutes a session?  A snd_pcm_open/snd_pcm_close pair?
> Won't snd_pcm_open reuse the data from a previous call?
>=20
> I added that call after my call to snd_pcm_open, and valgrind no
> longer reports any leaks, except for a few kilobytes from a flex
> scanner (not related to alsa).  Still, the memory used by the player
> when running increases with each file.  The virtual size of the player
> is rather constant at around 25 MB all the time, while the resident
> size is slowly increasing, until it too reaches 25 MB.  Then the
> impossible happens:
>=20
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND     =
     =20
>  7148 mru       11   0 25160  27m 2740 S  0.0 12.4   0:00.08 tcvp        =
     =20
>=20
> Now the man page for top tells me that "VIRT =3D SWAP + RES", so unless
> a negative amount has been swapped (what would that mean?), something
> strange is going on.  The odd thing is that this happens only when I
> use the ALSA output module.  Could it be that alsa-lib triggers some
> bug somewhere in top, or in the kernel?  This seems a little unlikely,
> though.

I will try to investigate this problem.

> In case it matters, I use ALSA OSS emulation when testing OSS sound.
>=20
> > the configuration cache in alsa-lib. This is described in=20
> > the alsa-lib/MEMORY-LEAK file.
>=20
> That file isn't present in the alsa-lib 0.9.6 tarball.  It should be
> added the EXTRA_DIST list in Makefile.am.

Thanks for info. Fixed.

> I ran valgrind on aplay, and it tells me more or less the same as for
> my program.  Does aplay not call the above function?  Not that it
> needs to, really.

I've added the free function to aplay before tests, of course.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
